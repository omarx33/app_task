import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sem11/models/user_model.dart';
import 'package:firebase_sem11/pages/home_page.dart';
import 'package:firebase_sem11/services/my_service_firestore.dart';

import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:firebase_sem11/ui/widgets/button_custom_widget.dart';
import 'package:firebase_sem11/ui/widgets/general_widget.dart';
import 'package:firebase_sem11/ui/widgets/textfield_normal_widget.dart';
import 'package:firebase_sem11/ui/widgets/textfield_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final keyForm = GlobalKey<FormState>();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  MyServiceFirestore userService = MyServiceFirestore(coleccion: "usuarios");
  _registroUsuario() async {
    try {
      //valida campos
      if (keyForm.currentState!.validate()) {
        //crea el usuario en Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        //  print(userCredential);
        if (userCredential.user != null) {
          UserModel userModel = UserModel(
            fullNombre: _nombresController.text,
            correo: _emailController.text,
          );

          //agregar el usuario a firestore a una tabla
          userService.agregarUser(userModel).then((value) {
            // print(value);
            if (value.isNotEmpty) {
              //con esto si se loguea ira  a homepage y si retrocede las vistas de logis y registros no se visualizaran porque ya esta logueado
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }
          });
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        showSnackBarError(context, "La contraseña es muy debil");
      } else if (error.code == "email-already-in-use") {
        showSnackBarError(context, "El correo ya existe");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: keyForm,
          child: Column(
            children: [
              divicion10(),
              divicion10(),
              divicion10(),
              SvgPicture.asset(
                "assets/img/register.svg",
                height: 180,
              ),
              divicion10(),
              divicion10(),
              divicion10(),
              Text(
                "Registrate",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kBrandPrimaryColor,
                ),
              ),
              divicion10(),
              divicion10(),
              TextFieldNormalhWidget(
                  texto: "Nombre completo",
                  icono: Icons.email,
                  controller: _nombresController),
              divicion10(),
              TextFieldNormalhWidget(
                  texto: "Correo Electrónico",
                  icono: Icons.email,
                  controller: _emailController),
              divicion10(),
              divicion10(),
              TextFieldPasswordWidget(controlador: _passwordController),
              divicion10(),
              divicion10(),
              ButtonCustomWidget(
                color: kBrandPrimaryColor,
                icono: "check",
                texto: "Registrate",
                onPress: () {
                  _registroUsuario();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
