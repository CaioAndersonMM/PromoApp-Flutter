import 'package:get/get.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          await _firestore.collection('produtos').get();
      List<ProductItem> foodProducts = snapshot.docs
          .map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return ProductItem(
              name: data['name'],
              imageUrl: data['imageUrl'],
              location: data['location'],
              price: data['price'],
              type: data['type'],
            );
          })
          .where((product) => product.type == 'Comida')
          .toList();

      products.assignAll(foodProducts);
      print('Produtos filtrados: $products');
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  Future<void> addProduct(ProductItem product) async {
    try {
      // Adiciona o produto ao Firestore
      await _firestore.collection('produtos').add({
        'name': product.name,
        'imageUrl': product.imageUrl,
        'location': product.location,
        'price': product.price,
        'type': product.type,
      });

      // Atualiza a lista de produtos após a inserção
      products.add(product);
      print('Produto salvo no Firestore: ${product.name}');
    } catch (e) {
      print('Erro ao salvar produto: $e');
    }
  }
}
