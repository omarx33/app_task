import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sem11/models/task_model.dart';
import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:firebase_sem11/ui/widgets/button_normal_widget.dart';
import 'package:firebase_sem11/ui/widgets/general_widget.dart';
import 'package:firebase_sem11/ui/widgets/item_task_widget.dart';
import 'package:firebase_sem11/ui/widgets/task_form_widget.dart';
import 'package:firebase_sem11/ui/widgets/textfield_normal_widget.dart';
import 'package:firebase_sem11/utils/task_search_delegate.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  List<TaskModel> tasksGeneral = [];
  final TextEditingController _buscarController = TextEditingController();
  // apuntando a la bd bd_task de firebase
  CollectionReference bd_taskReference =
      FirebaseFirestore.instance.collection('bd_prueba');

  vistaTaskForm(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context)
              .viewInsets, //esto mueve el form si aparece el teclado
          child: TaskFormWidget(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandSecondaryColor,
      floatingActionButton: InkWell(
        onTap: () {
          vistaTaskForm(context);
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: kBrandPrimaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                "Nueva Agregar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bienvenidos, usuarios",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: kBrandPrimaryColor,
                      ),
                    ),
                    Text(
                      "Mis tareas",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: kBrandPrimaryColor,
                      ),
                    ),
                    divicion10(),
                    TextFieldNormalhWidget(
                      controller: _buscarController,
                      texto: "Buscar tarea...",
                      icono: Icons.search,
                      onTap: () async {
                        await showSearch(
                          context: context,
                          delegate: TaskSearchDelegate(task: tasksGeneral),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Todas mis tareas",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kBrandPrimaryColor.withOpacity(0.85),
                    ),
                  ),
                  StreamBuilder(
                    stream: bd_taskReference.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (snap.hasData) {
                        List<TaskModel> task = [];
                        QuerySnapshot coleccion = snap.data;

                        //1era forma (covertir a map y luego a modelo)
                        // coleccion.docs.forEach((element) {
                        //   Map<String, dynamic> miMapa =
                        //       element.data() as Map<String, dynamic>;
                        //   task.add(TaskModel.fromJson(miMapa));
                        // });

                        //2da forma

                        // task = coleccion.docs
                        //     .map(
                        //       (e) => TaskModel.fromJson(
                        //           e.data() as Map<String, dynamic>),
                        //     )
                        //     .toList();

                        // con id
                        task = coleccion.docs.map((e) {
                          TaskModel task = TaskModel.fromJson(
                              e.data() as Map<String, dynamic>);
                          task.id = e.id;
                          return task;
                        }).toList();
                        tasksGeneral.clear();
                        //esto para el buscador cuando se llene task asigna tbm a tasksGeneral
                        tasksGeneral = task;
                        //fin
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: task.length,
                          itemBuilder: (context, int index) {
                            return ItemTaskWidget(
                              taskModel: task[index],
                            );
                          },
                        );
                      }
                      return loadingWidget();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // body: StreamBuilder(
      //   stream: bd_taskReference.snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot snap) {
      //     if (snap.hasData) {
      //       QuerySnapshot coleccion = snap.data;
      //       List<QueryDocumentSnapshot> docs = coleccion.docs;
      //       List<Map<String, dynamic>> docsMap =
      //           docs.map((e) => e.data() as Map<String, dynamic>).toList();
      //       print(docsMap);
      //       return ListView.builder(
      //         itemCount: docsMap.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           return Text(docsMap[index]["titulo"]);
      //         },
      //       );
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
    );
  }
}
