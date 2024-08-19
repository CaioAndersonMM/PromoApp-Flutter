// widgets/base_item.dart

import 'package:flutter/material.dart';

class BaseItem extends StatelessWidget {
  final String name;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;

  const BaseItem({
    super.key,
    required this.name,
    required this.padding,
    this.margin = EdgeInsets.zero,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: containerDecoration(),
      child: Text(
        name,
        style: textStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }
}
