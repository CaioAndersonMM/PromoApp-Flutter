import 'package:flutter/material.dart';

class EventosPage extends StatelessWidget {
  const EventosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Eventos')),
      body: Center(child: Text('Página de Eventos')),
    );
  }
}