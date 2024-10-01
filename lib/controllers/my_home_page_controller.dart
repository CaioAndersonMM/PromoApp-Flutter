import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:meu_app/databases/db_firestore.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePageController extends GetxController {
  var allproducts = <ProductItem>[].obs;
  var filteredProducts = <ProductItem>[].obs;
  var currentPageIndex = 0.obs;
  var currentFilterCriteria = 'Tudo'.obs;

  // Variável reativa para armazenar o caminho da imagem
  var imagePath = ''.obs;

  final FirebaseFirestore _firestore = DBFirestore.get();

  @override
  void onInit() {
    super.onInit();
    _loadSelectedCity(); // Carrega a cidade selecionada ao iniciar
    print('Iniciando MyHomePageController');
    _loadProducts().then((__) {
      filterAndSortProducts('Mais Baratos', 'Tudo');
    });
  }

  Future<void> addProduct(ProductItem product) async {
    try {
      await _firestore.collection(product.type.toLowerCase() + 's').add({
        'name': product.name,
        'imageUrl': product.imageUrl,
        'location': product.location,
        'price': product.price,
        'type': product.type,
      });
      print('Produto adicionado ao Firestore: ${product.name}');
      await _loadProducts(); // Recarrega produtos após a adição
    } catch (e) {
      print('Erro ao adicionar produto: $e');
    }
  }

  Future<void> _loadProducts() async {
    try {
      allproducts.clear(); // Limpa a lista antes de carregar novos produtos

      // Carregar produtos das coleções
      final QuerySnapshot comidasSnapshot =
          await _firestore.collection('comidas').get();
      final QuerySnapshot produtosSnapshot =
          await _firestore.collection('produtos').get();
      final QuerySnapshot eventosSnapshot =
          await _firestore.collection('eventos').get();

      // Mapeia produtos da coleção 'comidas'
      List<ProductItem> comidaProducts = comidasSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return ProductItem(
          name: data['name'],
          imageUrl: data['imageUrl'],
          location: data['location'],
          price: (data['price'] is num)
              ? (data['price'] as num).toDouble()
              : 0.0, // Verifica se é num
          type: "Comida",
        );
      }).toList();

      // Mapeia produtos da coleção 'produtos'
      List<ProductItem> produtosList = produtosSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return ProductItem(
          name: data['name'],
          imageUrl: data['imageUrl'],
          location: data['location'],
          price: (data['price'] is num)
              ? (data['price'] as num).toDouble()
              : 0.0, // Verifica se é num
          type: "Produto",
        );
      }).toList();

      // Mapeia produtos da coleção 'eventos'
      List<ProductItem> eventosList = eventosSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return ProductItem(
          name: data['name'],
          imageUrl: data['imageUrl'],
          location: data['location'],
          price: (data['price'] is num)
              ? (data['price'] as num).toDouble()
              : 0.0, // Verifica se é num
          type: "Evento",
        );
      }).toList();

      // Combina todas as listas em uma única lista
      List<ProductItem> allProducts = [
        ...comidaProducts,
        ...produtosList,
        ...eventosList,
      ];

      // Atualiza a lista observável
      allproducts.assignAll(allProducts);
      print('Todos os produtos carregados: $allProducts');
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  var selectedCity = 'Selecione uma cidade'.obs;
  var dadosUsuario = {
    'id': 1,
    'userName': 'João Silva',
    'postCount': 10,
    'reviewCount': 25,
    'userLevel': '2',
    'city': 'Mossoró',
  }.obs;

  var selectedIndex = 0.obs;

void updateSelectedCity(String newCity) async {
  selectedCity.value = newCity;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('selectedCity', newCity);
  Get.snackbar('Cidade Atualizada', 'A cidade foi alterada para $newCity'); // Notifica o usuário
}

  void showCitySelectionAlert() {
    Get.snackbar(
        'Aviso', 'Por favor, selecione uma cidade ou ative a localização.');
  }

 Future<void> _loadSelectedCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedCity.value = prefs.getString('selectedCity') ?? 'Selecione uma cidade';
  }

  void filterAndSortProducts(String sortCriteria, String filterCriteria) {
    currentFilterCriteria.value = filterCriteria; // Armazena o critério atual
    List<ProductItem> tempProducts = List.from(allproducts);

    switch (filterCriteria) {
      case 'Comidas':
        filterCriteria = 'Comida';
        break;
      case 'Produtos':
        filterCriteria = 'Produto';
        break;
      case 'Eventos':
        filterCriteria = 'Evento';
        break;
    }

    // Filtrando produtos por tipo
    if (filterCriteria != 'Tudo') {
      tempProducts = tempProducts
          .where((product) => product.type == filterCriteria)
          .toList();
    }

    switch (sortCriteria) {
      case 'Mais Baratos':
        tempProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Mais Recentes':
        // Lógica para ordenar mais recentes pode ser implementada aqui
        break;
      case 'Mais Comprados':
        // Adicione aqui a lógica de "mais comprados" se disponível
        break;
    }

    filteredProducts.value = tempProducts;
  }

  var isLocationEnabled = false.obs;

  Future<void> activateLocation() async {
    await getCityFromIP(); // Chama o método para obter a cidade
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedCity', selectedCity.value); // Armazena a cidade no SharedPreferences
    filterAndSortProducts('Mais Baratos', 'Tudo');
  }

  Future<void> getCityFromIP() async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        selectedCity.value = data['city'] ?? 'Cidade desconhecida';
        Get.snackbar('Localização Detectada', 'Cidade: ${selectedCity.value}');
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('selectedCity', selectedCity.value); // Atualiza a cidade no SharedPreferences
      } else {
        Get.snackbar('Erro', 'Não foi possível obter a localização');
      }
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao obter cidade: $e');
    }
  }
}
