import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sem11/models/user_model.dart';
import 'package:firebase_sem11/pages/home_page.dart';
import 'package:firebase_sem11/pages/register_page.dart';
import 'package:firebase_sem11/services/my_service_firestore.dart';
import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:firebase_sem11/ui/widgets/button_custom_widget.dart';
import 'package:firebase_sem11/ui/widgets/button_normal_widget.dart';
import 'package:firebase_sem11/ui/widgets/general_widget.dart';
import 'package:firebase_sem11/ui/widgets/textfield_normal_widget.dart';
import 'package:firebase_sem11/ui/widgets/textfield_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googloeSignbIn = GoogleSignIn(scopes: ["email"]);
  MyServiceFirestore userService = MyServiceFirestore(coleccion: "usuarios");

  _login() async {
    try {
      //validar campos vacios
      if (formKey.currentState!.validate()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        //    print(userCredential);
        //si el usuario existe o esta logueado
        if (userCredential.user != null) {
          //con esto si se loguea ira  a homepage y si retrocede las vistas de logis y registros no se visualizaran porque ya esta logueado
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      }
    } on FirebaseAuthException catch (error) {
      print(error.code);
      if (error.code == "INVALID_LOGIN_CREDENTIALS") {
        showSnackBarError(context, "Error con sus datos de registro");
      }
    }
  }

  _loginConGoogle() async {
//busca las cuentas que ya an iniciado antes
// si es nueva te pedira que accedas una nueva

    GoogleSignInAccount? googleSignInAccount = await _googloeSignbIn.signIn();
    // print(googleSignInAccount);
    if (googleSignInAccount == null) {
      return;
    }

//_googleSigInAuth contiene idToken y accessToken
    GoogleSignInAuthentication _googleSigInAuth =
        await googleSignInAccount.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleSigInAuth.idToken,
      accessToken: _googleSigInAuth.accessToken,
    );

//registra las credenciales en firebase
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      UserModel userModel = UserModel(
        //!para indicar que no seran nulos porque podrian serlo
        fullNombre: userCredential.user!.displayName!,
        correo: userCredential.user!.email!,
      );
      userService.validaUsuario(userCredential.user!.email!).then((value) {
        if (value == false) {
          //si no existe el usuario agrega a la bd la sesion y redirige
          userService.agregarUser(userModel).then(
            (value) {
              if (value.isNotEmpty) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
              }
            },
          );
        } else {
          //redirige
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      });
    }
  }

  _loginConFacebook() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              divicion10(),
              divicion10(),
              divicion10(),
              SvgPicture.asset(
                "assets/img/login.svg",
                height: 180,
              ),
              divicion10(),
              divicion10(),
              divicion10(),
              Text(
                "Iniciar Sesión",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kBrandPrimaryColor,
                ),
              ),
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
                texto: "Iniciar Seseión",
                onPress: () {
                  _login();
                },
              ),
              divicion10(),
              divicion10(),
              Text(
                "O Ingresa con redes sociales",
              ),
              divicion10(),
              divicion10(),
              ButtonCustomWidget(
                color: Color(0xfff84b2a),
                icono: "google",
                texto: "Iniciar sesión con Google",
                onPress: () {
                  _loginConGoogle();
                },
              ),
              divicion10(),
              divicion10(),
              ButtonCustomWidget(
                color: Color(0xff507cc0),
                icono: "facebook",
                texto: "Iniciar sesión con Facebook",
                onPress: () {
                  //_googloeSignbIn.signOut();
                  _loginConFacebook();
                },
              ),
              divicion10(),
              divicion10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Aún no estas registrado?"),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      "Registrate",
                      style: TextStyle(
                        color: kBrandPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore
