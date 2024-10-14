import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/my_home_page_controller.dart';
import 'package:meu_app/pages/produtosDetailPage.dart';
import 'package:meu_app/services/database.dart';
import '../models/product_item.dart';

class ProductWidget extends StatelessWidget {
  final ProductItem product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final userId = Get.find<MyHomePageController>().dadosUsuario['id'];
    return GestureDetector(
      onTap: () {
        // Navega para a página de detalhes do produto
        Get.to(() => ProductDetailsPage(product: product));
      },
      child: SizedBox(
        width: double.infinity, // Ajusta para preencher a largura disponível
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagem do produto
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: product.imageUrl
                          .startsWith('http') // Verifica se a URL é de rede
                      ? Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                                Icons.error); // Ícone de erro se falhar
                          },
                        )
                      : Image.file(
                          File(product.imageUrl), // Carrega a imagem local
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                                Icons.error); // Ícone de erro se falhar
                          },
                        ),
                ),
              ),
              const SizedBox(width: 16.0),
              // Informações do produto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      product.location,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              // Ícones para ver mais detalhes
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.assignment_returned_rounded,
                      color: Color.fromARGB(192, 21, 99, 163),
                    ),
                    onPressed: () async {
                      final dbHelper = DatabaseHelper();
                      await dbHelper.inserirDesejo(1, product.id!);
                      Get.snackbar(
                        'Sucesso',
                        'Produto adicionado aos desejos!',
                        backgroundColor: Colors.white, // Fundo branco
                        colorText: Colors.blue[800], // Texto azul escuro
                        snackPosition: SnackPosition
                            .BOTTOM, // Posiciona o snackbar na parte inferior
                        borderRadius: 8.0, // Borda arredondada opcional
                        margin: const EdgeInsets.all(10.0), // Margem opcional
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0), // Padding opcional
                        duration:
                            const Duration(seconds: 2), // Duração do snackbar
                      );
                    },
                  ),
                  Container(
                    width: 25, // Largura do quadrado
                    height: 25, // Altura do quadrado
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _getRateColor(product.rate), // Cor da borda cinza
                      ),
                      borderRadius:
                          BorderRadius.circular(5), // Bordas arredondadas
                    ),
                    child: Center(
                      child: Text(
                        product.rate?.toString() ??
                            '5', // Converte o número de avaliação para string ou exibe '-' se for nulo
                        style: TextStyle(
                          color: _getRateColor(product.rate), // Cor do texto
                          fontWeight: FontWeight.bold, // Negrito
                          fontSize: 15, // Tamanho da fonte
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRateColor(double? rate) {
    if (rate == null)
      return const Color.fromARGB(220, 4, 22, 104); // Cor atual
    final rateValue = rate;
    if (rateValue < 3) {
      return const Color.fromARGB(255, 116, 17, 17)!; // Vermelho escuro
    } else if (rateValue == 3 || rateValue == 3.7) {
      return const Color.fromARGB(220, 4, 22, 104); // Cor atual
    } else {
      return Color.fromARGB(255, 13, 114, 18)!; // Verde escuro
    }
  }
}
