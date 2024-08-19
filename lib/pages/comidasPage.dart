import 'package:flutter/material.dart';

class ComidasPage extends StatelessWidget {
  const ComidasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comidas')),
      body: Center(child: Text('Página de Comidas')),
    );
  }
}