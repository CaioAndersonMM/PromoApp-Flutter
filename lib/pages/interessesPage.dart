import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Promoapp/controllers/interesses_controller.dart';
import 'package:Promoapp/widgets/caixa_interesses.dart';

class InteressesPage extends StatelessWidget {
  InteressesPage({super.key});

  final TextEditingController interestController = TextEditingController();
  final InteressesController controller = Get.put(InteressesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adicionar Interesses',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.workspaces_outlined),
          onPressed: () {
            // Navegação para a página inicial ou outra ação
          },
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(0, 12, 36, 1), // Fundo azul escuro
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Adicione seus interesses para receber recomendações personalizadas e acompanhar conteúdos relacionados.',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              caixaInteresses("Adicione um interesse", interestController),
              const SizedBox(height: 10),
              _buildAddButton(),
              const SizedBox(height: 20),
              _buildInterestChips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: () {
        if (interestController.text.isNotEmpty) {
          // Adiciona o interesse digitado pelo usuário
          controller.addInteresse(interestController.text);
          interestController.clear(); // Limpa o campo de texto após adicionar
        }
      },
      child: const Text('Adicionar'),
    );
  }

  Widget _buildInterestChips() {
    return Obx(() {
      if (controller.interesses.isEmpty) {
        return const Text(
          'Não há interesses cadastrados',
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        );
      }
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: controller.interesses.map((interesse) {
          return Chip(
            label: Text(interesse),
            deleteIcon: const Icon(Icons.close),
            onDeleted: () {
              controller.removeInteresse(interesse);
            },
          );
        }).toList(),
      );
    });
  }
}
