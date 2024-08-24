import 'package:flutter/material.dart';
import 'package:meu_app/widgets/product_item.dart';

class ComidasPage extends StatefulWidget {
  const ComidasPage({super.key});

  @override
  _ComidasPageState createState() => _ComidasPageState();
}

class _ComidasPageState extends State<ComidasPage> {
  final List<ProductItem> _products = [
    const ProductItem(name: 'Comida 1', imageUrl: 'https://via.placeholder.com/50', location: 'Loja A', price: 19.99, type: 'Comida'),
    const ProductItem(name: 'Comida 2', imageUrl: 'https://via.placeholder.com/50', location: 'Loja B', price: 29.99, type: 'Comida'),
    const ProductItem(name: 'Comida 3', imageUrl: 'https://via.placeholder.com/50', location: 'Loja B', price: 29.99, type: 'Comida'),
  ];

  void _addProduct(ProductItem product) {
    setState(() {
      _products.add(product); // Adiciona o produto à lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comidas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
                const Text('Adicionar nova comida', style: TextStyle(color: Colors.white)),
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
                    imageUrl: "https://via.placeholder.com/50", // Defina a URL da imagem ou peça ao usuário
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
