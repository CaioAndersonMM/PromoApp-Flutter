import 'package:get/get.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventosController extends GetxController {
  var events = <ProductItem>[].obs;
  final FirebaseFirestore _firestore = DBFirestore.get();

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
          name: data['name'],
          imageUrl: data['imageUrl'],
          location: data['location'],
          price: data['price'],
          type: "Evento",
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
      // Adiciona o evento ao Firestore
      await _firestore.collection('eventos').add({
        'name': event.name,
        'imageUrl': event.imageUrl,
        'location': event.location,
        'price': event.price,
      });

      events.add(event);
      print('Evento salvo no Firestore: ${event.name}');
    } catch (e) {
      print('Erro ao salvar evento: $e');
    }
  }
}
