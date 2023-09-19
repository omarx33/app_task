import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  //apuntando a la bd bd_task de firebase
  CollectionReference bd_taskReference =
      FirebaseFirestore.instance.collection('bd_task');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Firestore"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                bd_taskReference.get().then((value) {
                  print(value.docs);
                });
                //  print(bd_taskReference.id);
              },
              child: Text("Obtener dato"),
            ),
          ],
        ),
      ),
    );
  }
}
