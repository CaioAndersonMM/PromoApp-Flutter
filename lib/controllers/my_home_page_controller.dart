import 'package:get/get.dart';

class MyHomePageController extends GetxController {
  var selectedCity = 'Selecione uma cidade'.obs;
  var dadosUsuario = {
    'city': 'Mossoró',
    'userName': 'Bruno',
    'postCount': 5,
    'reviewCount': 15,
    'userLevel': '2',
  }.obs;
  var selectedIndex = 0.obs;

  void updateSelectedCity(String newCity) {
    selectedCity.value = newCity;
    dadosUsuario['city'] = newCity;
  }

  void showCitySelectionAlert() {
    Get.defaultDialog(
      title: 'Seleção de Cidade',
      middleText:
          'Por favor, selecione uma cidade no menu esquerdo para continuar.',
      textConfirm: 'OK',
      onConfirm: () => Get.back(),
    );
  }
}
