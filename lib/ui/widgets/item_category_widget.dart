import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:flutter/material.dart';

class ItemCategoryWidget extends StatelessWidget {
  String texto;
  ItemCategoryWidget({
    required this.texto,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
      decoration: BoxDecoration(
        color: CategoryColor[texto],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}
