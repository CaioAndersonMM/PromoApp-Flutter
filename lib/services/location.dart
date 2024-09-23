import 'package:geolocator/geolocator.dart';

class LocationService {
  // Função para obter a posição atual
  Future<Position> getCurrentPosition() async {
    try {
      // Verifica se o serviço de localização está habilitado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Serviço de localização desativado");
      }

      // Verifica as permissões de localização
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Permissão de localização negada");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Permissão de localização negada permanentemente");
      }

      // Obtém a posição atual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position; // Retorna a posição obtida
    } catch (e) {
      throw Exception("Erro ao obter localização: $e");
    }
  }
}

// Uso
void getLocation() async {
  try {
    Position position = await LocationService().getCurrentPosition();
    double latitude = position.latitude; // Obtém a latitude
    double longitude = position.longitude; // Obtém a longitude

    print('Latitude: $latitude, Longitude: $longitude');
  } catch (e) {
    print('Erro: $e');
  }
}
