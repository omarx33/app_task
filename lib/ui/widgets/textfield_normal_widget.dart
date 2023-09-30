import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:flutter/material.dart';

class TextFieldNormalhWidget extends StatelessWidget {
  String texto;
  IconData icono;
  Function? onTap;
  TextEditingController controller;

  TextFieldNormalhWidget({
    required this.texto,
    required this.icono,
    this.onTap,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap != null
          ? () {
              onTap!();
            }
          : null,
      readOnly: onTap != null ? true : false,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        prefixIcon: Icon(
          icono,
          size: 20,
          color: kBrandPrimaryColor.withOpacity(0.6),
        ),
        hintText: texto,
        hintStyle: TextStyle(
          fontSize: 14,
          color: kBrandPrimaryColor.withOpacity(0.6),
        ),
        filled: true,
        fillColor: kBrandSecondaryColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (String? value) {
        if (value != null && value.isEmpty) {
          //vacio o null
          return "Campo Obligatorio";
        }
        return null;
      },
    );
  }
}
