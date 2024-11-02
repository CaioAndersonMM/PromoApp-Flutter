import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meu_app/models/product_item.dart'; // Modelo do produto
import 'package:meu_app/controllers/produto_controller.dart'; // Controlador de produtos

class PertosPage extends StatelessWidget {
  PertosPage({Key? key}) : super(key: key);

  final ProdutosController controller = Get.put(ProdutosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos Mais Próximos',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
      body: FutureBuilder<Position>(
        future: _getCurrentLocation(), // Método para obter localização
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao obter localização: ${snapshot.error}'));
          }

          Position? position = snapshot.data;

          // Filtra os produtos mais próximos
          List<ProductItem> nearbyProducts = _getNearbyProducts(position!);

          if (nearbyProducts.isEmpty) {
            return const Center(child: Text('Nenhum produto próximo disponível', style: TextStyle(color: Colors.white)));
          }

          return ListView.builder(
            itemCount: nearbyProducts.length,
            itemBuilder: (context, index) {
              final product = nearbyProducts[index];
              return ListTile(
                title: Text(product.name, style: const TextStyle(color: Colors.white)),
                subtitle: Text('Localização: ${product.location}', style: const TextStyle(color: Colors.grey)),
                trailing: Text('R\$ ${product.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green)),
              );
            },
          );
        },
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  List<ProductItem> _getNearbyProducts(Position position) {
    // Simulando a lógica de proximidade; substitua com sua lógica real
    return controller.products.where((product) {

      // return _calculateDistance(position.latitude, position.longitude, product.latitude, product.longitude) < 10.0;

      // Simulando a lógica de proximidade; substitua com sua lógica real
      var latitude;
      var longitude;
      return _calculateDistance(position.latitude, position.longitude, latitude, longitude) < 10.0;
    }).toList();
  }

  double _calculateDistance(double userLat, double userLong, double productLat, double productLong) {
    return Geolocator.distanceBetween(userLat, userLong, productLat, productLong) / 1000; // Distância em km
  }
}
