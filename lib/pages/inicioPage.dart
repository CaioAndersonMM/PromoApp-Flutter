import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Promoapp/controllers/my_home_page_controller.dart';
import 'package:Promoapp/controllers/produto_controller.dart';
import 'package:Promoapp/controllers/comida_controller.dart';
import 'package:Promoapp/controllers/evento_controller.dart';
import 'package:Promoapp/pages/altasPage.dart';
import 'package:Promoapp/pages/especiaisPage.dart';
import 'package:Promoapp/pages/pertosPages.dart';
import 'package:Promoapp/widgets/caixa_pesquisa.dart';
import 'package:Promoapp/widgets/header_products.dart';
import 'package:Promoapp/widgets/type_item.dart';
import 'package:Promoapp/widgets/product_widget.dart';

class InicioPage extends StatelessWidget {
  InicioPage({super.key});

  final MyHomePageController controller = Get.put(MyHomePageController());
  final ProdutosController controllerProduto = Get.put(ProdutosController());
  final ComidasController controllerComida = Get.put(ComidasController());
  final EventosController controllerEvento = Get.put(EventosController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Obx(() {
            // Verifica se a cidade foi selecionada
            if (controller.selectedCity.value == 'Selecione uma cidade') {
              return Column(
                children: [
                  const Text(
                    'Nenhuma cidade selecionada',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Ação para ativar localização
                      controller.activateLocation();
                    },
                    child: const Text('Ligar Localização'),
                  ),
                ],
              );
            } else {
              return Text(
                'Cidade Selecionada: ${controller.selectedCity}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }
          }),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20.0,
            runSpacing: 10.0,
            children: <Widget>[
              TypeItem(name: 'Em Alta', destinationPage: AltasPage()),
              TypeItem(
                  name: 'Especiais', destinationPage: EspeciaisPage()),
              TypeItem(
                  name: 'Mais Perto', destinationPage: PertosPage()),
            ],
          ),
          const SizedBox(height: 25),
          caixaPesquisa(
            placeholder: 'Pesquisar produtos, lojas, promoções...',
            controller: searchController,
            onChanged: (value) {
              controller.filterAndSortProducts(
                'Mais Baratos',
                controller.currentFilterCriteria.value,
                searchQuery: value,
              );
            },
          ),
          const SizedBox(height: 5),
          headerProducts(),
          Expanded(
            child: Obx(() {
              if (controller.filteredProducts.isEmpty) {
                return const Center(
                    child: Text('Nenhum produto disponível',
                        style: TextStyle(color: Colors.white)));
              }

              return SingleChildScrollView(
                child: Wrap(
                  runSpacing: 10.0,
                  children: controller.filteredProducts.map((product) {
                    return ProductWidget(product: product);
                  }).toList(),
                ),
              );
            }),
          ),
          if (controller.isLoading.value)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
