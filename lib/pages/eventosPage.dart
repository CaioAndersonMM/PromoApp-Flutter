import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_app/controllers/evento_controller.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/widgets/product_widget.dart';

class EventosPage extends StatelessWidget {
  const EventosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EventosController controller =
        Get.put(EventosController()); // Instanciar o controlador

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    _showAddEventDialog(context, controller);
                  },
                ),
                const Text(
                  'Adicionar novo evento',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.events.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum evento disponível',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Wrap(
                  runSpacing: 10.0,
                  children: controller.events.map((event) {
                    return ProductWidget(
                        product:
                            event); // Certifique-se de que ProductWidget seja usado para exibir os eventos
                  }).toList(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog(BuildContext context, EventosController controller) {
    String name = '';
    String location = '';
    double price = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Evento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Nome do evento'),
                onChanged: (value) {
                  name = value;
                },
              ),
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
                  controller.addEvent(ProductItem(
                    name: name,
                    imageUrl:
                        "https://via.placeholder.com/50", // Defina a URL da imagem ou peça ao usuário
                    location: location,
                    price: price,
                    type: 'Evento', // Define o tipo como 'Evento'
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
