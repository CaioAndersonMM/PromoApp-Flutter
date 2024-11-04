import 'package:get/get.dart';
import 'package:Promoapp/models/product_item.dart';
import 'package:Promoapp/databases/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EspecialController extends GetxController {
  var specialProducts = <ProductItem>[].obs;
  final FirebaseFirestore _firestore = DBFirestore.get();
  var isLoading = false.obs;

  @override
  void onInit() {
    print('Iniciando EspecialController');
    super.onInit();
    _loadSpecialProducts();
  }

  Future<void> _loadSpecialProducts() async {
    try {
      isLoading.value = true;
      final QuerySnapshot snapshot = await _firestore.collection('produtos')
          .where('isSpecial', isEqualTo: true) // Filtra apenas produtos especiais
          .get();

      List<ProductItem> productList = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        double price = (data['price'] as num).toDouble();

        return ProductItem(
          name: data['name'],
          imageUrl: data['imageUrl'],
          location: data['location'],
          store: data['store'] ?? '',
          price: price,
          type: "Produto",
          // isSpecial: data['isSpecial'] ?? false, // Adiciona a tag de especial
        );
      }).toList();

      specialProducts.assignAll(productList);
      print('Produtos especiais carregados: $specialProducts');
    } catch (e) {
      print('Erro ao carregar produtos especiais: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addSpecialProduct(ProductItem product) async {
    try {
      // Adiciona o produto ao Firestore com a tag especial
      await _firestore.collection('produtos').add({
        'name': product.name,
        'imageUrl': product.imageUrl,
        'location': product.location,
        'store': product.store,
        'price': product.price,
        'isSpecial': true, // Define que o produto é especial
      });

      // Atualiza a lista de produtos especiais após a inserção
      specialProducts.add(product);
      print('Produto especial salvo no Firestore: ${product.name}');
    } catch (e) {
      print('Erro ao salvar produto especial: $e');
    }
  }
}
