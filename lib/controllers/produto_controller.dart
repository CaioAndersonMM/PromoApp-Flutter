import 'dart:convert';
import 'package:get/get.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/services/database.dart';

class ProdutosController extends GetxController {
  final DatabaseHelper _databaseService = DatabaseHelper();
  var products = <ProductItem>[].obs;

  @override
  void onInit() {
    print('Iniciando ProdutosController');
    super.onInit();
    _loadEvents();
  }

   @override
  void onReady() {
    super.onReady();
    print('Tela Produtos');
    _loadEvents();
  }

Future<void> _loadEvents() async {
  try {
    final allProducts = await _databaseService.getProducts(); // Obtendo todos os produtos
    final productsProducts = allProducts.where((product) => product.type == 'Produto').toList(); // Filtrando eventos

    products.assignAll(productsProducts); // Atualiza a lista de eventos
  } catch (e) {
    print('Error loading products: $e'); // Debug print
  }
}


  Future<void> _saveEvents(ProductItem products) async {
    try {
      await _databaseService.insertProduct(products);
    } catch (e) {
      print('Error saving products: $e'); // Debug print
    }
  }

  void addEvent(ProductItem product) {
    products.add(product);
    _saveEvents(product);
  }
}