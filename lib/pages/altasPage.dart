import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Promoapp/controllers/my_home_page_controller.dart';
import 'package:Promoapp/models/product_item.dart';
import 'package:Promoapp/widgets/product_widget.dart';

class AltasPage extends StatefulWidget {
  AltasPage({super.key});

  @override
  _AltasPageState createState() => _AltasPageState();
}

class _AltasPageState extends State<AltasPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<ProductItem> _sortedProducts = [];
  final Random _random = Random();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    // Inicie o timer para mudar a posição dos itens
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        _shuffleProducts();
      }
    });
  }

  void _loadProducts() {
    final controller = Get.find<MyHomePageController>();
    // Carregue os produtos e ordene-os
    _sortedProducts = List.from(controller.allproducts);
    _sortedProducts.sort((a, b) => (b.rate ?? 0).compareTo(a.rate ?? 0));
    _sortedProducts = _sortedProducts.take(15).toList();
    
    // Exiba a lista inicial
    for (int i = 0; i < _sortedProducts.length; i++) {
      _listKey.currentState?.insertItem(i);
    }
  }

 void _shuffleProducts() {
  List<ProductItem> shuffledProducts = List.from(_sortedProducts);
  shuffledProducts.shuffle();

  // Atualize a lista original
  for (int i = 0; i < _sortedProducts.length; i++) {
    if (_sortedProducts[i] != shuffledProducts[i]) {
      // Capture o item a ser removido
      ProductItem removedProduct = _sortedProducts[i];
      int newIndex = shuffledProducts.indexOf(removedProduct);

      // Remova o item da AnimatedList
      _listKey.currentState?.removeItem(
        i,
        (context, animation) => _buildItem(context, removedProduct, animation),
        duration: const Duration(milliseconds: 500),
      );

      // Atualize a lista original
      _sortedProducts.removeAt(i);

      // Adicione o item na nova posição
      _sortedProducts.insert(newIndex, removedProduct);
      _listKey.currentState?.insertItem(newIndex, duration: const Duration(milliseconds: 500));

      break; // Para evitar problemas com o índice
    }
  }
}

  Widget _buildItem(BuildContext context, ProductItem product, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation.drive(CurveTween(curve: Curves.easeInOut)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                children: [
                  Icon(
                    _random.nextBool() ? Icons.arrow_upward : Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  Text(
                    _random.nextBool() ? 'Subindo' : 'Descendo',
                    style: TextStyle(
                      color: _random.nextBool() ? Colors.lightGreen : Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ProductWidget(
                product: product,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos em Alta',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: GetBuilder<MyHomePageController>(
        init: MyHomePageController(),
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.allproducts.isEmpty) {
                    return const Center(
                        child: Text('Nenhum produto disponível',
                            style: TextStyle(color: Colors.white)));
                  }

                  return AnimatedList(
                    key: _listKey,
                    initialItemCount: _sortedProducts.length,
                    itemBuilder: (context, index, animation) {
                      return _buildItem(context, _sortedProducts[index], animation);
                    },
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}