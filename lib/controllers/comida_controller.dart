import 'package:get/get.dart';
import 'package:Promoapp/controllers/my_home_page_controller.dart';
import 'package:Promoapp/models/product_item.dart';
import 'package:Promoapp/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:Promoapp/services/auth.dart';
import 'package:Promoapp/services/countPosts.dart';
import 'package:Promoapp/services/countProductRate.dart';

class ComidasController extends GetxController {
  var products = <ProductItem>[].obs;
  final FirebaseFirestore _firestore = DBFirestore.get();
  var isLoading = false.obs; // Variável de estado de carregamento
  var countPostService = CountPostService();
  var countProductService = CountProductRatingService();
  

  @override
  void onInit() {
    print('Iniciando ComidasController');
    super.onInit();
    _loadProducts();
  }

  @override
  void onReady() {
    super.onReady();
    print('Tela ComidasController');
  }

  Future<void> _loadProducts() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('comidas').get();
      List<ProductItem> foodProducts = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        // Conversão do 'price' para double
        double price = (data['price'] as num)
            .toDouble();

        return ProductItem(
          id: doc.id,
          name: data['name'],
          imageUrl: data['imageUrl'],
          location: data['location'],
          store: data['store'] ?? '',
          price: price,
          type: "Comida",
          description: data['description'],
        );
      }).toList();

      products.assignAll(foodProducts);
      print('Produtos filtrados: $products');
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  Future<void> addProduct(ProductItem product) async {

    isLoading.value = true;
    try {
      // Obtém a posição atual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Adiciona o produto ao Firestore
      await _firestore.collection('comidas').add({
        'name': product.name,
        'imageUrl': product.imageUrl,
        'coords': {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
        'location': product.location,
        'store': product.store,
        'price': product.price,
        'description': product.description,
      });
      
      countPostService.adicionarPost(AuthService().getUserId());

      // Atualiza a lista de produtos após a inserção
      products.add(product);
      print('Produto salvo no Firestore: ${product.name}');
       // Chama o _loadProducts do MyHomePageController
      MyHomePageController homePageController = Get.find();
      await homePageController.updateProducts();
    } catch (e) {
      print('Erro ao salvar produto: $e');
    } finally {
      isLoading.value = false; // Finaliza o estado de carregamento
    }
  }
}
