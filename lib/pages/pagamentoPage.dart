import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meu_app/models/product_item.dart';

class PagamentoPage extends StatelessWidget {
  final ProductItem product;

  const PagamentoPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double discount;

    if (product.price > 100) {
      discount = 20.0;
    } else {
      discount = product.price * 0.10;
    }

    double finalPrice = product.price - discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pague e torne o produto especial',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Você está prestes a pagar por:',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: const TextStyle(color: Colors.yellow, fontSize: 24),
              ),
              Text(
                product.store + ', ' + product.location,
                style: const TextStyle(color: Colors.yellow, fontSize: 17),
              ),
              const SizedBox(height: 50),
              Text(
                'Preço Original: R\$ ${product.price.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Valor para ser especial: R\$ ${discount.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Color.fromARGB(255, 2, 243, 26), fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showPaymentModal(context);
                },
                child: const Text('Pagar via PIX'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 400, // Altura do modal
          color: const Color.fromRGBO(0, 12, 36, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Escaneie o QR Code para pagar:',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                  'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
              const SizedBox(height: 20),
              Image.network(
                'https://miro.medium.com/v2/resize:fit:1400/1*f3oY1PxU9BbzKUyU_v822A.png',
                width: 140, // Largura da imagem
                height: 140, // Altura da imagem
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(
                          text:
                              'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'));
                      Navigator.of(context).pop(); // Fecha o modal

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Código copiado!'),
                          backgroundColor: Color.fromARGB(255, 3, 41, 117),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                          margin: EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 100.0),
                        ),
                      );
                    },
                    child: const Text('Copiar código'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o modal
                    },
                    child: const Text('Fechar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
