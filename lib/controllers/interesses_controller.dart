import 'package:get/get.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/services/database.dart';

class InteressesController extends GetxController {
  var interesses = <String>[].obs;
  var userId = 1.obs;  // Id do usuário, defina conforme necessário

  @override
  void onInit() {
    super.onInit();
    loadInteresses();
  }

  Future<void> loadInteresses() async {
    try {
      final dbHelper = DatabaseHelper();
      // interesses.value = await dbHelper.getDesejos(userId.value);
    } catch (e) {
      print('Erro ao carregar interesses: $e');
    }
  }

  removeInteresse(String interesse) {
    // Implemente a remoção de um interesse
  }

  addInteresse(String interesse) {
    // Implemente a adição de um interesse
  print('Adicionando interesse: $interesse');
    // interesses.add(interesse);
  }
}
