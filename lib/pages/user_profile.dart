import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/user_profile_controller.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Inicializa o AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repetir a animação continuamente

    // Define a animação da rotação
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Limpa o controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileController controller = Get.put(UserProfileController());
    controller.loadUserProfile();

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
            Container(
              decoration: BoxDecoration(
              color: const Color.fromARGB(255, 8, 2, 46),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
                ),
              ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfoRow(Icons.person, 'Nome: ${controller.userName.value}'),
                _buildUserInfoRow(Icons.star, 'Avaliações: ${controller.reviewCount.value}'),
                _buildUserInfoRow(Icons.post_add, 'Postagens: ${controller.postCount.value}'),
                _buildUserInfoRow(Icons.approval_outlined, 'Nível: ${controller.userLevel.value}'),
              ],
              ),
            ),
            const SizedBox(height: 20),
           
            const Text(
              'Minhas Avaliações',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 8, 2, 46),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
                ],
              ),
              child: ListView.builder(
                itemCount: 5, // Número de avaliações fictícias
                itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.comment, color: Color.fromARGB(255, 75, 113, 188)),
                  title: Text('Comentário ${index + 1}', style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  subtitle: const Text('Esta é uma avaliação fictícia.',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                );
                },
              ),
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
                      color: const Color.fromARGB(255, 8, 2, 46),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _animation.value * 2.0 * 3.14159, // 2π radianos para completar uma rotação
                            // ignore: prefer_const_constructors
                            child: Icon(
                              Icons.local_fire_department_rounded, // Seta para indicar carregamento
                              size: 40,
                              color: const Color.fromARGB(255, 75, 113, 188),
                            ),
                            
                          );
                        },
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
          Icon(icon, color: const Color.fromARGB(255, 75, 113, 188)),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      ),
    );
  }
}
