import 'package:flutter/material.dart';
import '../models/product_item.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductItem product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

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
                width: double.infinity,
                height: 200,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
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
                SizedBox(width: 16.0),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color.fromARGB(255, 38, 31, 73),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                )
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
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 15, 0, 66),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.favorite_border),
                        label: const Text('Desejos'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          // Ação para adicionar aos favoritos
                        },
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.report_problem, color: Colors.white,),
                        label: const Text('Reportar!', style: const TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 154, 21, 12),
                        ),
                        onPressed: () {
                          // Ação para denunciar
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Ação para avaliar o produto
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Icon(
                          Icons.thumb_up,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Ação para avaliar o produto
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Icon(
                          Icons.thumb_down,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton(
                        onPressed: () {
                          // Ação para ver avaliações
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Ver Avaliações'),
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