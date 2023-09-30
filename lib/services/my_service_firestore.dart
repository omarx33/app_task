import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sem11/models/task_model.dart';
import 'package:firebase_sem11/models/user_model.dart';

class MyServiceFirestore {
  String coleccion;

  MyServiceFirestore({
    required this.coleccion,
  });
  late final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(coleccion);

  //
  Future<String> addTask(TaskModel model) async {
    DocumentReference documentReference =
        await _collectionReference.add(model.toJson());
    String id = documentReference.id;
    return id;
  }

  Future<void> finishTask(String taskId) async {
    await _collectionReference.doc(taskId).update(
      {
        "estado": false,
      },
    );
  }

  Future<String> agregarUser(UserModel userModel) async {
    DocumentReference documentReference =
        await _collectionReference.add(userModel.toJson());
    return documentReference.id;
  }

  Future<bool> validaUsuario(String email) async {
    //veduelve la coleccion validando antes el correo de bd
    QuerySnapshot coleccion =
        await _collectionReference.where("correo", isEqualTo: email).get();
    if (coleccion.docs.isNotEmpty) {
      // si no es vacia
      return true;
    }
    return false;
  }
}
