import 'package:firebase_sem11/models/task_model.dart';
import 'package:firebase_sem11/services/my_service_firestore.dart';
import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:firebase_sem11/ui/widgets/general_widget.dart';
import 'package:firebase_sem11/ui/widgets/item_category_widget.dart';
import 'package:flutter/material.dart';

class ItemTaskWidget extends StatelessWidget {
  TaskModel taskModel;
  ItemTaskWidget({
    required this.taskModel,
  });

  final MyServiceFirestore _myServiceFirestore =
      MyServiceFirestore(coleccion: "bd_prueba");
  showFinishDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Finalizar tarea",
                style: TextStyle(
                  color: kBrandPrimaryColor.withOpacity(0.87),
                  fontWeight: FontWeight.w600,
                ),
              ),
              divicion6(),
              Text(
                "¿Estas seguro?",
                style: TextStyle(
                  color: kBrandPrimaryColor.withOpacity(0.87),
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              divicion10(),
              divicion10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                        color: kBrandPrimaryColor.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  divicion6Width(),
                  ElevatedButton(
                    onPressed: () {
                      _myServiceFirestore.finishTask(taskModel.id!);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kBrandPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        )),
                    child: Text("Finalizar"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(4, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemCategoryWidget(texto: taskModel.categoria),
              divicion6(),
              Text(
                taskModel.titulo,
                style: TextStyle(
                  decoration: taskModel.estado
                      ? TextDecoration.none
                      : TextDecoration.lineThrough, //tachar el titulo
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kBrandPrimaryColor.withOpacity(0.85),
                ),
              ),
              Text(
                taskModel.descripcion,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kBrandPrimaryColor.withOpacity(0.75),
                ),
              ),
              divicion6(),
              Text(
                taskModel.fecha,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kBrandPrimaryColor.withOpacity(0.75),
                ),
              ),
            ],
          ),
          Positioned(
            top: -10,
            right: -12,
            child: PopupMenuButton(
              elevation: 2,
              //  color: Colors.white,
              icon: Icon(
                Icons.more_vert,
                color: kBrandPrimaryColor.withOpacity(0.8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              onSelected: (value) {
                if (value == 2) {
                  //si el valor que selecciono de PopupMenuItem ==
                  showFinishDialog(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      "Editar",
                      style: TextStyle(
                        fontSize: 14,
                        color: kBrandPrimaryColor.withOpacity(0.85),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      "Finalizar",
                      style: TextStyle(
                        fontSize: 14,
                        color: kBrandPrimaryColor.withOpacity(0.85),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
