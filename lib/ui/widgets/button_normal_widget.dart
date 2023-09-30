import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:flutter/material.dart';

class ButtonNormalWidget extends StatelessWidget {
  Function onPress;
  ButtonNormalWidget({
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.0,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kBrandPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: Icon(Icons.save),
        label: Text(
          "Guardar",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
