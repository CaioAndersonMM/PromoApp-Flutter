import 'package:get/get.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/services/database.dart';

class ComidasController extends GetxController {

  var products = <ProductItem>[].obs;

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
    _loadProducts();
  }

 Future<void> _loadProducts() async {
    try {
      final dbHelper = DatabaseHelper();
      List<ProductItem> allProducts = await dbHelper.getProducts();

      // Filtra apenas os produtos do tipo 'Comida'
      List<ProductItem> foodProducts = allProducts.where((product) => product.type == 'Comida').toList();

      products.assignAll(foodProducts);
      print('Produtos filtrados: $products');
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  Future<void> addProduct(ProductItem product) async {
    try {
      final dbHelper = DatabaseHelper();
      await dbHelper.insertProduct(product);

      // Atualiza a lista de produtos após a inserção
      products.add(product);
      print('Produto salvo no banco de dados: ${product.name}');
    } catch (e) {
      print('Erro ao salvar produto: $e');
    }
  }
}