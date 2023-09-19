import 'package:firebase_sem11/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //habilita codigo nativo para que firebase funciones bien
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyaApp());
}

class MyaApp extends StatelessWidget {
  const MyaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "taskApp",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
