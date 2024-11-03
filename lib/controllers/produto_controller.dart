import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/my_home_page_controller.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meu_app/services/auth.dart';
import 'package:meu_app/services/countPosts.dart';
import 'package:meu_app/services/countProductRate.dart';

class ProdutosController extends GetxController {
  var products = <ProductItem>[].obs;
  final FirebaseFirestore _firestore = DBFirestore.get();
  var isLoading = false.obs;
  var countPostService = CountPostService();
  var countProductService = CountProductRatingService();

  @override
  void onInit() {
    print('Iniciando ProdutosController');
    super.onInit();
    _loadProducts();
  }

  @override
  void onReady() {
    super.onReady();
    print('Tela ProdutosController');
  }

  Future<void> _loadProducts() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('produtos').get();

      List<ProductItem> productList = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        double price = (data['price'] as num).toDouble();

        return ProductItem(
          id: doc.id,
          name: data['name'],
          imageUrl: data['imageUrl'],
          location: data['location'],
          store: data['store'] ?? '',
          price: price,
          type: "Produto",
          description: data['description'],
        );
      }).toList();

      products.assignAll(productList);
      print('Produtos filtrados: $products');
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  Future<void> addProduct(ProductItem product) async {
    try {
      // Verificar permissões de localização
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Serviço de localização desativado.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Permissão de localização negada.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Permissão de localização permanentemente negada.');
      }

      // Obtém a posição atual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Adiciona o produto ao Firestore
      await _firestore.collection('produtos').add({
        'name': product.name,
        'imageUrl': product.imageUrl,
        'location': product.location,
        'store': product.store,
        'coords': {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
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
    }
  }
}
