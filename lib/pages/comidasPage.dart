import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meu_app/services/storage_service.dart';
import 'package:meu_app/widgets/product_item.dart';

class ComidasPage extends StatefulWidget {
  const ComidasPage({super.key});

  @override
  _ComidasPageState createState() => _ComidasPageState();
}

class _ComidasPageState extends State<ComidasPage> {
  final StorageService _storageService = StorageService();
  List<ProductItem> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final jsonString = await _storageService.readFromFile('products.json');
      print('JSON String read from file: $jsonString'); // Debug print

      if (jsonString.isNotEmpty) {
        final List<dynamic> jsonProducts =
            jsonDecode(jsonString) as List<dynamic>;
        print('Decoded JSON: $jsonProducts'); // Debug print

        final products = jsonProducts
            .map((dynamic json) {
              if (json is Map<String, dynamic>) {
                return ProductItem(
                  name: json['name'] as String,
                  imageUrl: json['imageUrl'] as String,
                  location: json['location'] as String,
                  price: (json['price'] as num).toDouble(),
                  type: json['type'] as String,
                );
              } else {
                return null; // Pode adicionar tratamento para dados inválidos
              }
            })
            .where((product) => product != null)
            .cast<ProductItem>()
            .toList();

        setState(() {
          _products = products;
        });
      } else {
        print('No products found in JSON string.'); // Debug print
      }
    } catch (e) {
      print('Error loading products: $e'); // Debug print
    }
  }

  Future<void> _saveProducts() async {
    final productsJson = _products.map((product) {
      return {
        'name': product.name,
        'imageUrl': product.imageUrl,
        'location': product.location,
        'price': product.price,
        'type': product.type,
      };
    }).toList();

    final jsonString = jsonEncode(productsJson);
    await _storageService.writeToFile('products.json', jsonString);
  }

  void _addProduct(ProductItem product) {
    setState(() {
      _products.add(product); // Adiciona o produto à lista
      _saveProducts(); // Salva os produtos de volta no JSON
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comidas',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    _showAddProductDialog(context);
                  },
                ),
                const Text('Adicionar nova comida',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 10.0,
                children: _products,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    String name = '';
    String imageUrl = '';
    String location = '';
    double price = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Produto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (value) {
                  name = value;
                },
              ),
              // Adicione o campo URL da Imagem se necessário
              TextField(
                decoration: const InputDecoration(labelText: 'Localização'),
                onChanged: (value) {
                  location = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.tryParse(value) ?? 0.0;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                if (name.isNotEmpty && location.isNotEmpty && price > 0) {
                  _addProduct(ProductItem(
                    name: name,
                    imageUrl:
                        "https://via.placeholder.com/50", // Defina a URL da imagem ou peça ao usuário
                    location: location,
                    price: price,
                    type: 'Comida', // Define o tipo como 'Comida'
                  ));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
