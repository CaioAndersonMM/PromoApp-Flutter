import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/user_profile_controller.dart';
import 'package:meu_app/services/auth.dart';
import 'package:meu_app/services/countPosts.dart';
import 'package:meu_app/services/countProductRate.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String userId;
  late Future<int> numAvaliacoes;
  late Future<int> numPostagens;

  @override
  void initState() {
    super.initState();
    userId = AuthService().getUserId();
    numAvaliacoes = CountProductRatingService().obterAvaliacao(userId);
    numPostagens = CountPostService().obterPostagens(userId);

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int calcularNivel(int? numAvaliacoes, int? numPostagens) {
    if (numAvaliacoes == null || numPostagens == null || (numAvaliacoes == 0 && numPostagens == 0)) {
      return 0; // Nível padrão se algum dado estiver ausente
    }

    double resultado = log(numAvaliacoes + 2*numPostagens) / log(2);
    
    return resultado.floor();    
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
              child: FutureBuilder<int>( // Para avaliações
                future: numAvaliacoes,
                builder: (context, avaliacoesSnapshot) {
                  if (avaliacoesSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (avaliacoesSnapshot.hasError) {
                    return Text('Erro: ${avaliacoesSnapshot.error}');
                  } else {
                    return FutureBuilder<int>( // Para postagens
                      future: numPostagens,
                      builder: (context, postSnapshot) {
                        if (postSnapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (postSnapshot.hasError) {
                          return Text('Erro: ${postSnapshot.error}');
                        } else {
                          int nivel = calcularNivel(avaliacoesSnapshot.data, postSnapshot.data);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildUserInfoRow(Icons.person, 'Nome: ${controller.userName.value}'),
                              _buildUserInfoRow(Icons.star, 'Avaliações: ${avaliacoesSnapshot.data}'),
                              _buildUserInfoRow(Icons.post_add, 'Postagens: ${postSnapshot.data}'),
                              _buildUserInfoRow(Icons.approval_outlined, 'Nível: $nivel'),
                            ],
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Minhas Avaliações',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: FutureBuilder<int>(
                future: numPostagens,
                builder: (context, avaliacoesSnapshot) {
                  if (avaliacoesSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (avaliacoesSnapshot.hasError) {
                    return Text('Erro: ${avaliacoesSnapshot.error}');
                  } else {
                    return Container(
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
                        itemCount: avaliacoesSnapshot.data ?? 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.comment, color: Color.fromARGB(255, 75, 113, 188)),
                            title: Text('Comentário ${index + 1}', style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                            subtitle: const Text('Avaliação feita pelo usuário.', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                          );
                        },
                      ),
                    );
                  }
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
              child: FutureBuilder<int>(
                future: numPostagens,
                builder: (context, postSnapshot) {
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (postSnapshot.hasError) {
                    return Text('Erro: ${postSnapshot.error}');
                  } else {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: postSnapshot.data ?? 0,
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
                                  angle: _animation.value * 2.0 * 3.14159,
                                  child: const Icon(
                                    Icons.local_fire_department_rounded,
                                    size: 40,
                                    color: Color.fromARGB(255, 75, 113, 188),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
