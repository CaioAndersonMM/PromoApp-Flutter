import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/user_profile_controller.dart'; // Importa o controlador

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém o controller
    final UserProfileController controller = Get.put(UserProfileController());

    // Recupera dados do usuário do GetX
    final userName = controller.userName.value;
    final postCount = controller.postCount.value;
    final reviewCount = controller.reviewCount.value;
    final userLevel = controller.userLevel.value;
    final selectedCity = controller.selectedCity.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do Usuário',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nome: $userName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Quantidade de Avaliações: $reviewCount',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Quantidade de Postagens: $postCount',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Nível: $userLevel',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Escolha uma cidade para receber ofertas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() => DropdownButton<String>(
              value: controller.selectedCity.value,
              items: <String>['Mossoró', 'Natal', 'Jucurutu'].map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedCity.value = newValue;
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
