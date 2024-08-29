import 'package:get/get.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/services/database.dart';

class DesejosController extends GetxController {
  var desejos = <ProductItem>[].obs;
  var userId = 1.obs;  // Id do usuário, defina conforme necessário

  @override
  void onInit() {
    super.onInit();
    loadDesejos();
  }

  Future<void> loadDesejos() async {
    try {
      final dbHelper = DatabaseHelper();
      desejos.value = await dbHelper.getDesejos(userId.value);
    } catch (e) {
      print('Erro ao carregar desejos: $e');
    }
  }
}
