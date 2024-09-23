import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product_item.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductItem product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SizedBox(
                width: double.infinity, // Preenche a largura disponível
                height: 250,
                child: product.imageUrl.startsWith('http')
                    ? Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      )
                    : Image.file(
                        File(product.imageUrl),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  product.type,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color.fromARGB(255, 38, 31, 73),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color.fromARGB(255, 38, 31, 73),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
            Text(
              'Localização: ${product.location}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Preço: R\$ ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 15, 0, 66),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.report_problem,
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                        label: const Text(
                          'Reportar!',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 105, 15, 8),
                        ),
                        onPressed: () {
                          // Ação para denunciar
                        },
                      ),
                      const SizedBox(width: 40.0), // Espaço entre os botões
                      ElevatedButton(
                        onPressed: () {
                          // Ação para avaliar o produto
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Icon(
                          Icons.thumb_down,
                          color: Color.fromARGB(255, 230, 1, 1),
                        ),
                      ),
                      const SizedBox(width: 16.0), // Espaço entre os botões
                      ElevatedButton(
                        onPressed: () {
                          // Ação para avaliar o produto
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 251, 251, 251),
                        ),
                        child: const Icon(
                          Icons.thumb_up,
                          color: Color.fromARGB(255, 0, 41, 246),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.favorite_border),
                        label: const Text('Desejos   '),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          // Ação para adicionar aos favoritos
                        },
                      ),
                        const SizedBox(width: 40.0), // Espaço entre os botões
                      ElevatedButton(
                        onPressed: () {
                          // Ação para ver avaliações
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Text('    Ver Avaliações  '),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
