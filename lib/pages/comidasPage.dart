import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Promoapp/controllers/comida_controller.dart';
import 'package:Promoapp/models/product_item.dart';
import 'package:Promoapp/widgets/product_widget.dart';

class ComidasPage extends StatelessWidget {
  const ComidasPage({super.key}); // Remover const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comidas',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: GetBuilder<ComidasController>(
        init: ComidasController(),
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        _showAddProductDialog(context, controller);
                      },
                    ),
                    const Text('Adicionar nova comida',
                        style: TextStyle(color: Colors.white)),
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

  void _showAddProductDialog(
    BuildContext context, ComidasController controller) {
    String name = '';
    String location = '';
    double price = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Produto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Localização'),
                onChanged: (value) {
                  location = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.tryParse(value) ?? 0.0;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                if (name.isNotEmpty && location.isNotEmpty && price > 0) {
                  controller.addProduct(ProductItem(
                    name: name,
                    imageUrl: "https://via.placeholder.com/50",
                    location: location,
                    price: price,
                    type: 'Comida',
                  ));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
