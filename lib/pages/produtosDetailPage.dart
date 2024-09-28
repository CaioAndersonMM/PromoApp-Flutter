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
      body: SingleChildScrollView(
        // Adicionando SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment
                  .bottomLeft, // Alinhamento do botão no canto inferior esquerdo
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Permite que a coluna use o mínimo de espaço necessário
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          // Ação para reportar o produto
                          _showReportDialog(context);
                        },
                        backgroundColor: Color.fromARGB(255, 94, 10, 5),
                        child: const Icon(Icons.report, color: Colors.white),
                      ),
                      const SizedBox(
                          height: 4), // Espaçamento entre o ícone e o texto
                      const Text(
                        'Reportar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12, // Tamanho da fonte do texto
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Ação para avaliar o produto (thumb down)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: const Icon(
                    Icons.thumb_down,
                    color: Color.fromARGB(255, 230, 1, 1),
                  ),
                ),
                const SizedBox(width: 5.0), // Espaço entre os botões
                ElevatedButton(
                  onPressed: () {
                    // Ação para avaliar o produto (thumb up)
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
              padding:
                  const EdgeInsets.all(16.0), // Adicionando padding interno
              // child: Text(
              //   product.description, // Supondo que o modelo ProductItem tenha uma descrição
              //   style: const TextStyle(
              //     color: Colors.white, // Cor do texto
              //     fontSize: 16, // Tamanho da fonte
              //   ),
              // ),
            ),
            const SizedBox(height: 16.0),
            // Adicionando o título para as avaliações
            const Text(
              'AVALIAÇÕES',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10.0),
            // Lista de avaliações fictícias
            _buildReviewList(),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewList() {
    // Avaliações fictícias
    List<Map<String, dynamic>> reviews = [
      {
        'text': "Ótimo produto! Recomendo.",
        'stars': 5,
      },
      {
        'text': "Não atendeu minhas expectativas.",
        'stars': 2,
      },
      {
        'text': "Excelente qualidade e entrega rápida!",
        'stars': 4,
      },
      {
        'text': "Vale cada centavo! Muito satisfeito.",
        'stars': 5,
      },
      {
        'text': "Produto ok, mas poderia ser melhor.",
        'stars': 3,
      },
    ];

    return Column(
      children: reviews.map((review) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.person, // Ícone do usuário
                color: Colors.white,
              ),
              const SizedBox(width: 10.0), // Espaço entre ícone e texto
              Expanded(
                child: Text(
                  review['text'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              // Estrelas
              Row(
                children: List.generate(review['stars'], (index) {
                  return const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  );
                }),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reportar Produto"),
          content: const Text("Deseja realmente reportar este produto?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica para reportar o produto
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text("Reportar"),
            ),
          ],
        );
      },
    );
  }
}
