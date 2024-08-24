import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String location;
  final double price;

  const ProductItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.price, required String type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 36.0),
            // Informações do produto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'R\$ ${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            // Ícone para ver mais detalhes
              IconButton(
              icon: const Icon(
                Icons.report_gmailerrorred_rounded,
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
      ),
    );
  }
}