import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/services/auth.dart';
import 'package:meu_app/services/countProductRate.dart';
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
                    width: double.infinity,
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
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Ajuste conforme necessário
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 40,
                            child: FloatingActionButton(
                              onPressed: () {
                                _showReportDialog(context);
                              },
                              backgroundColor:
                                  const Color.fromARGB(255, 94, 10, 5),
                              child: const Icon(Icons.report,
                                  color: Colors.white,
                                  size: 20), // Ajustando o tamanho do ícone
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Reportar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5.0), // Espaço horizontal
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 40,
                            child: FloatingActionButton(
                              onPressed: () {
                                // _showReportDialog(context);
                                Get.snackbar(
                                  'Produto adicionado a sacola!',
                                  'Você poderá vê-lo acessando o menu.',
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 41, 117),
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                  borderRadius: 10,
                                  margin: const EdgeInsets.all(10),
                                );
                              },
                              backgroundColor:
                                  const Color.fromARGB(255, 17, 1, 32),
                              child: const Icon(Icons.shopping_bag_rounded,
                                  color: Color.fromARGB(255, 253, 253, 253),
                                  size: 20), // Ajustando o tamanho do ícone
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Salvar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(118, 3, 13, 196),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double fontSizeType = 15.0;

                      // Ajusta o tamanho do texto de product.type com base no comprimento de product.name
                      if (product.name.length > 10) {
                        fontSizeType =
                            14.0; // Diminuir o tamanho da fonte de product.type
                      }

                      return Text(
                        product.type,
                        style: TextStyle(
                          fontSize: fontSizeType,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    },
                  ),
                ),
                const SizedBox(
                    width: 10.0), // Espaço entre o tipo do produto e o nome
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double fontSizeName =
                          product.name.length > 10 ? 17.0 : 22.0;
                      return Text(
                        product.name,
                        style: TextStyle(
                          fontSize: fontSizeName,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow
                            .ellipsis, // Adiciona reticências se o texto for muito longo
                      );
                    },
                  ),
                ),
                // Botões de avaliação
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
                const SizedBox(width: 5.0),
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
              //   product.description, // ProductItem deve ter uma descrição
              //   style: const TextStyle(
              //     color: Colors.white, // Cor do texto
              //     fontSize: 16, // Tamanho da fonte
              //   ),
              // ),
            ),
            const SizedBox(height: 16.0),

            Row(
              children: [
                const Text(
                  'AVALIAÇÕES',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddReviewDialog(context);
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Avaliar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 20, 94),
                  ),
                ),
              ],
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
    final TextEditingController _reportReasonController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reportar Produto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Deseja realmente reportar este produto?"),
              const SizedBox(height: 10),
              TextField(
                controller: _reportReasonController,
                decoration: const InputDecoration(
                  hintText: "Explique o motivo do reporte",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Get.snackbar(
                  'Reporte feito',
                  'Moderadores irão verificar e tomar as devidas providências.',
                  backgroundColor: const Color.fromARGB(255, 73, 3, 3),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  borderRadius: 10,
                  margin: const EdgeInsets.all(10),
                );
                String reportReason = _reportReasonController.text;
                // Adicione a lógica para lidar com o motivo do reporte aqui
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

void _showAddReviewDialog(BuildContext context) {
  final TextEditingController reviewController = TextEditingController();
  final CountProductRatingService pts = CountProductRatingService();
  final String userId = AuthService().getUserId();
  int selectedStars = 0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Adicionar sua avaliação"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Quantas estrelas você dá para este produto?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    size: 30,
                    index < selectedStars ? Icons.star : Icons.star_border,
                    color: const Color.fromARGB(255, 172, 156, 13),
                  ),
                  onPressed: () {
                    selectedStars = index + 1;
                    (context as Element).markNeedsBuild();
                  },
                );
              }),
            ),
            TextField(
              controller: reviewController,
              decoration: const InputDecoration(
                labelText: "Sua avaliação",
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              pts.adicionarAvaliacao(AuthService().getUserId());

              Get.snackbar(
                'Avaliação feita',
                'Obrigado! Outros usuários poderão ver sua avaliação.',
                backgroundColor: const Color.fromARGB(255, 3, 41, 117),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                borderRadius: 10,
                margin: const EdgeInsets.all(10),
              );
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: const Text("Adicionar"),
          ),
        ],
      );
    },
  );
}
