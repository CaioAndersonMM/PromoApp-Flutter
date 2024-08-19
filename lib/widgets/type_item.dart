// widgets/type_item.dart

import 'package:flutter/material.dart';
import 'base_item.dart';

class TypeItem extends BaseItem {
  final Widget destinationPage;

  const TypeItem({
    super.key,
    required String name,
    required this.destinationPage,
  }) : super(
          name: name,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 10, top: 20),
          borderRadius: 2,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        margin: margin,
        padding: padding,
        decoration: containerDecoration(),
        child: Text(
          name,
          style: textStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
