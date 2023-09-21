import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  //apuntando a la bd bd_task de firebase
  CollectionReference bd_taskReference =
      FirebaseFirestore.instance.collection('bd_prueba');

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
                bd_taskReference.get().then((QuerySnapshot value) {
                  // QuerySnapshot coleccion = value;
                  // List<QueryDocumentSnapshot> docs = coleccion.docs;
                  // QueryDocumentSnapshot doc = docs[0];
                  // print(doc.id);
                  // print(doc.data());

                  QuerySnapshot coleccion = value;
                  coleccion.docs.forEach((QueryDocumentSnapshot element) {
                    Map<String, dynamic> myMap =
                        element.data() as Map<String, dynamic>;
                    print(myMap["titulo"]);
                  });
                });
                // print(bd_taskReference.id);
              },
              child: Text("Obtener dato"),
            ),
            ElevatedButton(
              onPressed: () {
                bd_taskReference.add(
                  {
                    "titulo": "ir a comer segunda prueba",
                    "descripcion": "comprar",
                  },
                ).then((DocumentReference value) {
                  print(value.id);
                }).catchError((error) {
                  print("error de registro");
                }).whenComplete(() {
                  print("registrado");
                });
              },
              child: Text("Agregar Documento"),
            ),
            ElevatedButton(
              onPressed: () {
                bd_taskReference.doc("SkooDip7JdjeoUZr604k").update(
                  {
                    "titulo": "Ir de paseo 2",
                    //   "descripcion": "salir temprano", <-- si no se envia, la bd lo deja tal cual
                  },
                ).catchError(
                  (error) {
                    print(error);
                  },
                ).whenComplete(
                  () {
                    print("Actualizado");
                  },
                );
              },
              child: Text("Actualizar documento"),
            ),
            ElevatedButton(
              onPressed: () {
                bd_taskReference
                    .doc("xgzfInjDsC7ayZuHqSVn")
                    .delete()
                    .catchError(
                  (error) {
                    print(error);
                  },
                ).whenComplete(() {
                  print("Eliminado");
                });
              },
              child: Text("Eliminar"),
            ),
            ElevatedButton(
              onPressed: () {
                //id personalizado
                bd_taskReference.doc("123456").set(
                  {
                    "titulo": "ir al concierto",
                    "descripcion": "el fin de semana",
                  },
                ).catchError((error) {
                  print(error);
                }).whenComplete(() {
                  print("Creación completa");
                });
              },
              child: Text("Agregar Documento personalizado"),
            ),
          ],
        ),
      ),
    );
  }
}
