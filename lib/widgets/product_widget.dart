import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/pages/produtosDetailPage.dart';
import '../models/product_item.dart';

class ProductWidget extends StatelessWidget {
  final ProductItem product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
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
                      Icons.shopping_bag_outlined,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      // Ação quando o ícone é pressionado
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.remove_red_eye_rounded,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      // Ação quando o ícone é pressionado
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
