import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  final Map<String, dynamic> dadosUsuario;

  const UserProfilePage({
    Key? key,
    required this.dadosUsuario  
    }) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late String _selectedCity;

  @override
  void initState() {
    super.initState();
    // Inicialize _selectedCity com a cidade do mapa de dados do usuário
    _selectedCity = widget.dadosUsuario['city'] ?? 'Mossoró'; // Valor padrão se não houver cidade
  }
  
  @override
  Widget build(BuildContext context) {
    // Extraindo dados do mapa
    final userName = widget.dadosUsuario['userName'] ?? 'Desconhecido';
    final postCount = widget.dadosUsuario['postCount'] ?? 0;
    final reviewCount = widget.dadosUsuario['reviewCount'] ?? 0;
    final userLevel = widget.dadosUsuario['userLevel'] ?? '0';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        backgroundColor: const Color.fromRGBO(0, 12, 36, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nome: $userName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Quantidade de Avaliações: $reviewCount',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Quantidade de Postagens: $postCount',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Nível: $userLevel',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Escolha uma cidade para receber ofertas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedCity,
              items:
                  <String>['Mossoró', 'Natal', 'Jucurutu'].map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
