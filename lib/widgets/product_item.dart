// widgets/product_item.dart

import 'package:flutter/material.dart';
import 'base_item.dart';

class ProductItem extends BaseItem {
  final String imageUrl;
  final String location;
  final double price;

  const ProductItem({
    super.key,
    required String name,
    required this.imageUrl,
    required this.location,
    required this.price,
  }) : super(name: name, padding: const EdgeInsets.all(26));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: containerDecoration(),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(
                name,
                style: _nameTextStyle(), // Novo estilo para o nome
              ),
              
              const SizedBox(height: 5),
              Text(
                location,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 5),
              Text(
                'R\$ ${price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  } 
  TextStyle _nameTextStyle() {
    return const TextStyle(
      fontSize: 14, // Ajuste o tamanho da fonte conforme necessário
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }
}
