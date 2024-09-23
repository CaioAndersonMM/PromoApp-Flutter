import 'package:get/get.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class ComidasController extends GetxController {
  var products = <ProductItem>[].obs;
  final FirebaseFirestore _firestore = DBFirestore.get();

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
          name: data['name'],
          imageUrl: data['imageUrl'],
          location: data['location'],
          price: price,
          type: "Comida",
        );
      }).toList();

      products.assignAll(foodProducts);
      print('Produtos filtrados: $products');
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  Future<void> addProduct(ProductItem product) async {
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
        'price': product.price,
      });

      // Atualiza a lista de produtos após a inserção
      products.add(product);
      print('Produto salvo no Firestore: ${product.name}');
    } catch (e) {
      print('Erro ao salvar produto: $e');
    }
  }
}
