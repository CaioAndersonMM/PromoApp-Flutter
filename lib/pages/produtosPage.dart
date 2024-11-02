import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/produto_controller.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/services/auth.dart';
import 'package:meu_app/services/countProductRate.dart';
import 'package:meu_app/widgets/product_widget.dart';

class ProdutosPage extends StatelessWidget {
  const ProdutosPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    final ProdutosController controller = Get.put(ProdutosController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Produtos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: Column(
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
                const Text(
                  'Adicionar novo produto',
                  style: TextStyle(color: Colors.white),
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
      ),
    );
  }

  void _showAddProductDialog(
      BuildContext context, ProdutosController controller) {
    String name = '';
    String location = '';
    double price = 0.0;
    var countProductService = CountProductRatingService();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Produto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Nome do Produto'),
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
                    imageUrl:
                        "https://via.placeholder.com/50", // Defina a URL da imagem ou peça ao usuário
                    location: location,
                    price: price,
                    type: 'Produto', // Define o tipo como 'Produto'
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
