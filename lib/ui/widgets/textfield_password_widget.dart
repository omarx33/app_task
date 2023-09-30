import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:flutter/material.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  TextEditingController controlador;

  TextFieldPasswordWidget({
    required this.controlador,
  });

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool esInvisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:
          widget.controlador, //widget para que jale el controlador de arriva
      obscureText: esInvisible,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        prefixIcon: Icon(
          Icons.lock,
          size: 20,
          color: kBrandPrimaryColor.withOpacity(0.6),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            esInvisible = !esInvisible;
            setState(() {});
          },
          icon: Icon(
            esInvisible ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
            color: kBrandPrimaryColor.withOpacity(0.60),
          ),
        ),
        hintText: "Password",
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
    ;
  }
}
