import 'package:flutter/material.dart';
import 'package:meu_app/widgets/product_item.dart';

Widget product_grid(BuildContext context) {
  final List<ProductItem> products = _getProducts();

  return SizedBox(
    height: MediaQuery.of(context).size.height, // Define a altura total
    child: GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // Mostra um produto por linha
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 4 / 2, // Ajuste o aspecto conforme necessário
      ),
      itemBuilder: (context, index) {
        return products[index];
      },
      shrinkWrap: true, // Ajusta o tamanho da GridView para o conteúdo
    ),
  );
}

List<ProductItem> _getProducts() {
  return [
    const ProductItem(
      name: 'Produto X',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja A',
      price: 19.99,
    ),
    const ProductItem(
      name: 'Produto 2',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja B',
      price: 29.99,
    ),
    const ProductItem(
      name: 'Produto 3',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja C',
      price: 39.99,
    ),
    const ProductItem(
      name: 'Produto 4',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja D',
      price: 49.99,
    ),
    const ProductItem(
      name: 'Produto 5',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja E',
      price: 59.99,
    ),
    const ProductItem(
      name: 'Produto 6',
      imageUrl: 'https://via.placeholder.com/50',
      location: 'Loja F',
      price: 69.99,
    ),
  ];
}
