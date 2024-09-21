import 'package:flutter/material.dart';

class MenuCidades extends StatelessWidget {
  final Function(String) onCitySelected;

  // Lista de cidades interna
  final List<String> cidades = [
    'Mossoró',
    'Natal',
    'Jucurutu',
    'João Pessoa',
    'Campina Grande',
    'Fortaleza',
    'Recife'
  ];

  MenuCidades({
    super.key,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 12, 36, 1),
            ),
            child: Text(
              'Escolha uma cidade para ver as promoções',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ...cidades.map((cidade) {
            return ListTile(
              leading: const Icon(Icons.location_city),
              title: Text(cidade),
              onTap: () {
                onCitySelected(cidade);
                Navigator.pop(context); // Fecha o Drawer após seleção
              },
            );
          }),
        ],
      ),
    );
  }
}
