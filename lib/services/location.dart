import 'package:geolocator/geolocator.dart';

class LocationService {
  // Função para verificar se o serviço de localização está habilitado e se as permissões estão corretas
  Future<void> _handleLocationPermissions() async {
    // Verifica se o serviço de localização está habilitado
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Serviço de localização desativado. Habilite o GPS.");
    }

    // Verifica as permissões de localização
    LocationPermission permission = await Geolocator.checkPermission();
    
    // Solicita permissão se estiver negada
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão de localização negada.");
      }
    }

    // Verifica se a permissão foi negada permanentemente
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          "Permissão de localização negada permanentemente. Altere isso nas configurações.");
    }
  }

  // Função principal para obter a posição atual com permissões tratadas
  Future<Position> getCurrentPosition() async {
    try {
      // Trata as permissões
      await _handleLocationPermissions();

      // Obtém a posição atual após as permissões serem garantidas
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, // Precisão alta
      );

      return position; // Retorna a posição obtida
    } catch (e) {
      throw Exception("Erro ao obter localização: $e");
    }
  }
}

void getLocation() async {
  try {
    Position position = await LocationService().getCurrentPosition();
    
    // Obtém a latitude e a longitude da posição
    double latitude = position.latitude;
    double longitude = position.longitude;

    print('Latitude: $latitude, Longitude: $longitude');
  } catch (e) {
    print('Erro ao obter localização: $e');
  }
}
