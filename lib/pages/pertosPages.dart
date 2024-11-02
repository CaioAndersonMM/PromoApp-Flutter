import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meu_app/controllers/my_home_page_controller.dart';
import 'package:meu_app/models/product_item.dart'; // Modelo do produto

class PertosPage extends StatelessWidget {
  PertosPage({Key? key}) : super(key: key);

  final MyHomePageController controller = Get.put(MyHomePageController());

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
    print('Obtendo produtos próximos...');
    // Simulando a lógica de proximidade; substitua com sua lógica real
    return controller.allproducts.where((product) {
      // Imprima as coordenadas dos produtos
      print('Produto: ${product.toMap()}');

      
      // Verifique se latitude e longitude não são nulos antes de calcular a distância
      if (product.latitude != null && product.longitude != null) {
        print('Calculando distância para o produto: ${product.name}');
        double distance = _calculateDistance(position.latitude, position.longitude, product.latitude!, product.longitude!);
        print('Distância para o produto ${product.name}: $distance km');
        return distance < 10.0; // Filtra produtos dentro de 10 km
      }
      print('Produto ${product.name} não tem coordenadas válidas.');
      return false;
    }).toList();
  }

  double _calculateDistance(double userLat, double userLong, double productLat, double productLong) {
    double distanceInMeters = Geolocator.distanceBetween(userLat, userLong, productLat, productLong);
    double distanceInKm = distanceInMeters / 1000; // Distância em km
    print('Distância calculada: $distanceInKm km'); // Adiciona um log para depuração
    return distanceInKm;
  }
}