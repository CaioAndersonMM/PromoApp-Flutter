import 'package:flutter/material.dart';
import 'package:meu_app/main.dart';

class ComidasPage extends StatelessWidget {
  const ComidasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comidas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                     Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            // Ação ao clicar no botão de adicionar
                          },
                        ),
                        const Text(
                          'Adicionar nova comida',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const Wrap(
                    // spacing: 40.0,
                    runSpacing: 10.0,
                    children: <Widget>[
                      ProductItem(
                        name: 'Comida 1',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja A',
                        price: 19.99,
                      ),
                      ProductItem(
                        name: 'Comida 2',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja B',
                        price: 29.99,
                      ),
                      ProductItem(
                        name: 'Comida 3',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja C',
                        price: 39.99,
                      ),
                      ProductItem(
                        name: 'Comida 4',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja D',
                        price: 49.99,
                      ),
                      ProductItem(
                        name: 'Comida 5',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja E',
                        price: 59.99,
                      ),
                      ProductItem(
                        name: 'Comida 6',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja F',
                        price: 69.99,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}