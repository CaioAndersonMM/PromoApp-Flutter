import 'package:flutter/material.dart';
import 'package:meu_app/main.dart';
import 'package:meu_app/widgets/product_item.dart';

class EventosPage extends StatelessWidget {
  const EventosPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eventos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Adicionar evento'),
                                  content: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Nome do evento',
                                        ),
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Preço',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Localização',
                                        ),
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
                                        // Ação ao adicionar a Evento
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        const Text(
                          'Adicionar novo evento',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const Wrap(
                    // spacing: 40.0,
                    runSpacing: 10.0,
                    children: <Widget>[
                      ProductItem(
                        name: 'Evento 1',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja A',
                        price: 19.99, type: 'Evento',
                      ),
                      ProductItem(
                        name: 'Evento 2',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja B',
                        price: 29.99, type: 'Evento',
                      ),
                      ProductItem(
                        name: 'Evento 3',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja C',
                        price: 39.99, type: 'Evento',
                      ),
                      ProductItem(
                        name: 'Evento 4',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja D',
                        price: 49.99, type: 'Evento',
                      ),
                      ProductItem(
                        name: 'Evento 5',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja E',
                        price: 59.99, type: 'Evento',
                      ),
                      ProductItem(
                        name: 'Evento 6',
                        imageUrl: 'https://via.placeholder.com/50',
                        location: 'Loja F',
                        price: 69.99, type: 'Evento',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}