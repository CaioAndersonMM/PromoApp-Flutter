import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String location;
  final double price;
  final String type; // Adiciona o tipo do produto

  const ProductItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.type, // Adiciona o tipo do produto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(imageUrl),
          ListTile(
            title: Text(name),
            subtitle: Text(location),
            trailing: Text('\$${price.toStringAsFixed(2)}'),
          ),
        ],
      ),
    );
  }
}
