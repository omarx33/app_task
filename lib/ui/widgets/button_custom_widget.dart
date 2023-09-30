import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonCustomWidget extends StatelessWidget {
  String texto;
  Color color;
  String icono;
  Function onPress;
  ButtonCustomWidget({
    required this.texto,
    required this.color,
    required this.icono,
    required this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: SvgPicture.asset(
          "assets/icons/$icono.svg",
          color: Colors.white,
        ),
        label: Text(
          texto,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
