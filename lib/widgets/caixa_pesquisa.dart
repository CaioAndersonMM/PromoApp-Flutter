import 'package:flutter/material.dart';

Widget caixaPesquisa(String placeholder) {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.white70),
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
          ),
        ),
      )

    ],
  );
}