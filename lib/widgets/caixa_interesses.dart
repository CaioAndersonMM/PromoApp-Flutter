import 'package:flutter/material.dart';

Widget caixaInteresses(String placeholder, TextEditingController controller) {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1), // Fundo semi-transparente
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                color: Colors.white, // Cor da borda quando focado
                width: 2.0,
              ),
            ),
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.white70), // Cor do texto do placeholder
            prefixIcon: const Icon(Icons.search, color: Colors.white70), // Ícone de pesquisa
          ),
          style: const TextStyle(color: Colors.white), // Cor do texto do campo
        ),
      ),
    ],
  );
}
