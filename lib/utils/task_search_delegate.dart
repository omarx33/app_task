import 'package:firebase_sem11/models/task_model.dart';
import 'package:firebase_sem11/ui/widgets/item_task_widget.dart';
import 'package:flutter/material.dart';

class TaskSearchDelegate extends SearchDelegate {
  List<TaskModel> task;
  TaskSearchDelegate({
    required this.task,
  });
  List<String> nombres = [
    "Juan",
    "Ana",
    "Omar",
    "Liz",
  ];

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Buscar titulo...";
  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => TextStyle(
        fontSize: 18,
      );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          //  print(query); //query toma el valor del imput
          query = "";
        },
        icon: Icon(
          Icons.close,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, ""); //cerrar sin retornar nada
      },
      icon: Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<TaskModel> resultados = task
        .where(
          (element) => element.titulo.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.builder(
        itemCount: resultados.length,
        itemBuilder: (context, int index) {
          return ItemTaskWidget(
            taskModel: resultados[index],
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //toLowerCase para que sea minuscula y no interfiera si ay mayusculas
    List<TaskModel> resultados = task
        .where(
          (element) => element.titulo.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.builder(
        itemCount: resultados.length,
        itemBuilder: (context, int index) {
          return ItemTaskWidget(
            taskModel: resultados[index],
          );
        },
      ),
    );
  }
}
