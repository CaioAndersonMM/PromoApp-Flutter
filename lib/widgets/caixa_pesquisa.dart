import 'package:flutter/material.dart';

Widget caixaPesquisa({
  required String placeholder,
  required TextEditingController controller,
  required ValueChanged<String> onChanged,
}) {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
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
          onChanged: onChanged,
        ),
      ),
    ],
  );
}