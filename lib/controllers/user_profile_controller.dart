import 'package:get/get.dart';

class UserProfileController extends GetxController {
  var userName = 'Caio'.obs;
  var postCount = 0.obs;
  var reviewCount = 0.obs;
  var userLevel = '0'.obs;
  var selectedCity = 'Mossoró'.obs;

  // Método para atualizar dados do usuário
  void updateUserProfile({
    required String name,
    required int posts,
    required int reviews,
    required String level,
    required String city,
  }) {
    userName.value = name;
    postCount.value = posts;
    reviewCount.value = reviews;
    userLevel.value = level;
    selectedCity.value = city;
  }
}
