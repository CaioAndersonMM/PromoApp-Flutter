import 'dart:convert';
import 'package:get/get.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/services/database.dart';

class EventosController extends GetxController {
  final DatabaseHelper _databaseService = DatabaseHelper();
  var events = <ProductItem>[].obs;

  @override
  void onInit() {
    print('Iniciando EventoController');
    super.onInit();
    _loadEvents();
  }

  @override
  void onReady() {
    super.onReady();
    print('Tela Eventos');
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final allProducts =
          await _databaseService.getProducts(); // Obtendo todos os produtos
      final eventsProducts = allProducts
          .where((product) => product.type == 'Evento')
          .toList(); // Filtrando eventos

      events.assignAll(eventsProducts); // Atualiza a lista de eventos
    } catch (e) {
      print('Error loading events: $e'); // Debug print
    }
  }

  Future<void> _saveEvents(ProductItem event) async {
    try {
      await _databaseService.insertProduct(event);
    } catch (e) {
      print('Error saving event: $e'); // Debug print
    }
  }

  void addEvent(ProductItem event) {
    events.add(event); // Adiciona o evento à lista
    _saveEvents(event); // Salva os eventos de volta no Banco
  }
}