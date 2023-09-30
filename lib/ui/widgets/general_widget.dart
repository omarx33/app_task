import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:flutter/material.dart';

Widget divicion3() => const SizedBox(height: 3);

Widget divicion6() => const SizedBox(height: 6);
Widget divicion10() => const SizedBox(height: 10);

Widget divicion3Width() => const SizedBox(height: 3);
Widget divicion6Width() => const SizedBox(height: 6);

Widget loadingWidget() => Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: kBrandPrimaryColor,
          strokeWidth: 2.2,
        ),
      ),
    );

showSnackBarSuccess(BuildContext context, String texto) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: const Color(0xff17c3b2),
      content: Row(
        children: [
          const Icon(
            Icons.check,
            color: Colors.white,
          ),
          Text(texto),
        ],
      ),
    ),
  );
}

showSnackBarError(BuildContext context, String texto) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: Colors.redAccent,
      content: Row(
        children: [
          const Icon(
            Icons.warning_amber,
            color: Colors.white,
          ),
          Text(texto),
        ],
      ),
    ),
  );
}
