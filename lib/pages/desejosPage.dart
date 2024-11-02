import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/desejos_controller.dart';
import 'package:meu_app/widgets/product_widget.dart';

class DesejosPage extends StatelessWidget {
  const DesejosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DesejosController controller = Get.put(DesejosController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sacola de itens desejados',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Get.offAll(() => MyHomePage());
        //   },
        // ),
      ),
      body: GetBuilder<DesejosController>(
        builder: (_) {
          if (controller.desejos.isEmpty) {
            return const Center(
              child: Text('Nenhum desejo encontrado'),
            );
          }

          return Container(
            color: const Color.fromRGBO(0, 12, 36, 1), // Background color
            child: ListView.builder(
              itemCount: controller.desejos.length,
              itemBuilder: (context, index) {
                final product = controller.desejos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0), // Add vertical spacing
                  child: ProductWidget(product: product, isFavorite: true),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
