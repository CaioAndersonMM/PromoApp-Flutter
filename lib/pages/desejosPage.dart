import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/desejos_controller.dart';
import 'package:meu_app/controllers/my_home_page_controller.dart';
import 'package:meu_app/main.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/services/database.dart';
import 'package:meu_app/widgets/product_widget.dart'; // Supondo que você tenha um widget para exibir produtos

class DesejosPage extends StatelessWidget {
  const DesejosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DesejosController controller = Get.put(DesejosController());

    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text(
          'Sacola de itens desejados',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(() => MyHomePage());
          },
        ),
      ),
      body: Obx(() {
        if (controller.desejos.isEmpty) {
          return const Center(
            child: Text('Nenhum desejo encontrado'),
          );
        }

        return ListView.builder(
          itemCount: controller.desejos.length,
          itemBuilder: (context, index) {
            final product = controller.desejos[index];
            return ProductWidget(product: product); // Certifique-se de que ProductWidget está configurado para exibir produtos
          },
        );
      }),
    );
  }
}
