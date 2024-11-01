import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/produto_controller.dart'; // Altere o import para o controlador correto
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/pages/pagamentoPage.dart';
import 'package:meu_app/widgets/product_widget.dart';

class EspeciaisPage extends StatelessWidget {
  EspeciaisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos Especiais',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: GetBuilder<ProdutosController>(
        init: ProdutosController(),
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _showTransformToSpecialDialog(context, controller);
                          },
                          child: const Text('Transformar Produto em Especial!'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.products.isEmpty) {
                    return const Center(
                        child: Text('Nenhum produto disponível',
                            style: TextStyle(color: Colors.white)));
                  }

                  return SingleChildScrollView(
                    child: Wrap(
                      runSpacing: 10.0,
                      children: controller.products.map((product) {
                        return ProductWidget(product: product);
                      }).toList(),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showTransformToSpecialDialog(
      BuildContext context, ProdutosController controller) {
    List<ProductItem> products = controller.products;
    List<bool> isSelected = List<bool>.filled(products.length, false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Transformar Produtos em Especiais'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: products.map((product) {
                    int index = products.indexOf(product);
                    return CheckboxListTile(
                      title: Text(product.name),
                      subtitle: Text(product.location),
                      value: isSelected[index],
                      onChanged: (bool? value) {
                        setState(() {
                          isSelected[index] = value ?? false;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Transformar'),
                  onPressed: () {
                    List<ProductItem> selectedProducts = [];
                    for (int i = 0; i < isSelected.length; i++) {
                      if (isSelected[i]) {
                        ProductItem product = products[i];
                        selectedProducts.add(product);
                      }
                    }

                    if (selectedProducts.isNotEmpty) {
                      print('página de pagamento');
                      Get.to(
                          () => PagamentoPage(product: selectedProducts.first));
                    }
                    // Navigator.of(context)
                    //     .pop(); // Opcional, dependendo do fluxo que você quer
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
