import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:Promoapp/controllers/my_home_page_controller.dart';
import 'package:Promoapp/models/product_item.dart';
import 'package:Promoapp/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Promoapp/services/auth.dart';
import 'package:Promoapp/services/countPosts.dart';
import 'package:Promoapp/services/countProductRate.dart';

class EventosController extends GetxController {
  var events = <ProductItem>[].obs;
  final FirebaseFirestore _firestore = DBFirestore.get();
  var isLoading = false.obs;
  var countPostService = CountPostService();
  var countProductService = CountProductRatingService();

  @override
  void onInit() {
    print('Iniciando EventoController');
    super.onInit();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('eventos').get(); // Coleção 'eventos'
      List<ProductItem> eventList = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return ProductItem(
          id: doc.id,
          name: data['name'],
          imageUrl: data['imageUrl'],
          location: data['location'],
          store: data['store'] ?? '',
          price: data['price'],
          type: "Evento",
          description: data['description'],
        );
      }).toList();

      events.assignAll(eventList);
      print('Eventos filtrados: $events');
    } catch (e) {
      print('Erro ao carregar eventos: $e');
    }
  }

  Future<void> addEvent(ProductItem event) async {
    try {
      // Obtém a posição atual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Adiciona o evento ao Firestore
      await _firestore.collection('eventos').add({
        'name': event.name,
        'imageUrl': event.imageUrl,
        'coords': {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
        'location': event.location,
        'store': event.store,
        'price': event.price,
        'description': event.description,
      });
      
      countPostService.adicionarPost(AuthService().getUserId());

      events.add(event);
      print('Evento salvo no Firestore: ${event.name}');
      // Chama o _loadProducts do MyHomePageController
      MyHomePageController homePageController = Get.find();
      await homePageController.updateProducts();
    } catch (e) {
      print('Erro ao salvar evento: $e');
    }
  }
}
