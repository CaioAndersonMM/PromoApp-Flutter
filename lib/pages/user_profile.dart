import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/user_profile_controller.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileController controller = Get.put(UserProfileController());

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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Informações do Usuário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 16),
            _buildUserInfoRow(Icons.person, 'Nome: ${controller.userName.value}'),
            _buildUserInfoRow(Icons.star, 'Avaliações: ${controller.reviewCount.value}'),
            _buildUserInfoRow(Icons.post_add, 'Postagens: ${controller.postCount.value}'),
            _buildUserInfoRow(Icons.approval_outlined, 'Nível: ${controller.userLevel.value}'),
            const SizedBox(height: 20),
            const Text(
              'Escolha uma cidade para receber ofertas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() => DropdownButton<String>(
                  value: controller.selectedCity.value,
                  isExpanded: true,
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
            const SizedBox(height: 20),
            const Text(
              'Minhas Avaliações',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Número de avaliações fictícias
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.comment, color: const Color.fromRGBO(0, 12, 36, 1)),
                    title: Text('Comentário ${index + 1}'),
                    subtitle: Text('Esta é uma avaliação fictícia.'),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Minhas Postagens',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 6, // Número de postagens fictícias
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Postagem ${index + 1}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromRGBO(0, 12, 36, 1)),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
