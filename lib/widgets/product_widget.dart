import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/desejos_controller.dart';
import 'package:meu_app/pages/produtosDetailPage.dart';
import 'package:meu_app/services/auth.dart';
import 'package:meu_app/services/productSave.dart';
import '../models/product_item.dart';

final DesejosController desejosController = Get.put(DesejosController());

class ProductWidget extends StatelessWidget {
  final ProductItem product;
  final bool? isFavorite;

  const ProductWidget({
    super.key,
    required this.product,
    this.isFavorite = false, // Valor padrão é false
  });

  @override
  Widget build(BuildContext context) {
    final String userId = AuthService().getUserId();
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
              // Imagem do produto com verificação de tipo
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: _getProductImage(product),
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
                      '${product.location}: ${product.store}',
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
                    icon: Icon(
                      Icons.assignment_returned_rounded,
                      color: isFavorite == true
                          ? Colors.red
                          : const Color.fromARGB(192, 21, 99, 163),
                    ),
                    onPressed: () async {
                      final authService = AuthService();
                      final productSaveService = ProductSaveService();

                      if (isFavorite == true) {
                        await productSaveService.apagarProduto(userId, product.id!);
                        desejosController.loadDesejos();
                      } else {
                        await productSaveService.salvarProduto(userId, product.id!);
                        desejosController.loadDesejos();
                      }

                      Get.snackbar(
                        'Sucesso',
                        isFavorite == true
                            ? 'Produto removido dos desejos!'
                            : 'Produto adicionado aos desejos!',
                        backgroundColor: const Color.fromARGB(255, 3, 41, 117),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        borderRadius: 10,
                        margin: const EdgeInsets.all(10.0),
                      );
                    },
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _getRateColor(product.rate),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        product.rate?.toString() ?? '5',
                        style: TextStyle(
                          color: _getRateColor(product.rate),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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

  Widget _getProductImage(ProductItem product) {
    // Determina a URL da imagem com base no tipo do produto
    String imageUrl;
    if (product.type == 'Produto') {
      imageUrl = 'https://radio93fm.com.br/wp-content/uploads/2019/02/produto.png';
    } else if (product.type == 'Comida') {
      imageUrl = 'https://img.freepik.com/vetores-premium/ilustracao-colorida-de-desenhos-animados-de-comida_1305385-66378.jpg?semt=ais_hybrid';
    } else if (product.type == 'Evento') {
      imageUrl = 'https://thumbs.dreamstime.com/b/no-show-isolado-ilustra%C3%A7%C3%B5es-do-vetor-de-desenho-animado-grupo-amigos-sorridentes-se-divertem-concerto-evento-grandioso-festival-256583009.jpg';
    } else {
      imageUrl = 'https://radio93fm.com.br/wp-content/uploads/2019/02/produto.png'; // Imagem padrão
    }

    // Carrega a imagem da rede ou arquivo local, conforme necessário
    return product.imageUrl.startsWith('http')
        ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://radio93fm.com.br/wp-content/uploads/2019/02/produto.png',
                fit: BoxFit.cover,
              );
            },
          )
        : Image.file(
            File(product.imageUrl),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://radio93fm.com.br/wp-content/uploads/2019/02/produto.png',
                fit: BoxFit.cover,
              );
            },
          );
  }

  Color _getRateColor(double? rate) {
    if (rate == null) return const Color.fromARGB(220, 4, 22, 104);
    final rateValue = rate;
    if (rateValue < 3) {
      return const Color.fromARGB(255, 116, 17, 17);
    } else if (rateValue == 3 || rateValue == 3.7) {
      return const Color.fromARGB(220, 4, 22, 104);
    } else {
      return const Color.fromARGB(255, 13, 114, 18);
    }
  }
}
