import 'package:get/get.dart';
import 'package:meu_app/services/auth.dart';
import 'package:meu_app/services/interest.dart';

class InteressesController extends GetxController {
  var interesses = <String>[].obs;
  final userId = 1.obs;
  final InterestService interestServ = InterestService();

  @override
  void onInit() {
    super.onInit();
    loadInteresses();
  }

  Future<void> loadInteresses() async {
    final String userId = AuthService().getUserId();

    try {
      List<String> interessesCarregados = await interestServ.obterInteresses(userId);
      interesses.assignAll(interessesCarregados);
    } catch (e) {
      print('Erro ao carregar interesses: $e');
    }
  }

  Future<void> removeInteresse(String interesse) async {
    final String userId = AuthService().getUserId();

    try {
      await interestServ.removerInteresse(userId, interesse);
      await loadInteresses();
    } catch (e) {
      print('Erro ao remover interesse: $e');
    }
  }

  Future<void> addInteresse(String interesse) async {
    final String userId = AuthService().getUserId();

    try {
      await interestServ.adicionarInteresse(userId, interesse);
      await loadInteresses();
      print('Adicionando interesse: $interesse');
    } catch (e) {
      print('Erro ao adicionar interesse: $e');
    }
  }
}
