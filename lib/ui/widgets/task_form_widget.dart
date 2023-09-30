import 'package:firebase_sem11/models/task_model.dart';
import 'package:firebase_sem11/services/my_service_firestore.dart';
import 'package:firebase_sem11/ui/general/colors.dart';
import 'package:firebase_sem11/ui/widgets/button_normal_widget.dart';
import 'package:firebase_sem11/ui/widgets/general_widget.dart';
import 'package:firebase_sem11/ui/widgets/textfield_normal_widget.dart';
import 'package:flutter/material.dart';

class TaskFormWidget extends StatefulWidget {
  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final formKey = GlobalKey<FormState>();
  MyServiceFirestore taskService = MyServiceFirestore(coleccion: "bd_prueba");

  final TextEditingController _tituloControlador = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  String categoriaSelect = "Personal";

  showSelectdate() async {
    DateTime? datetime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      helpText: "Seleccione fecha",
      builder: (context, Widget? widget) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.white,
            dialogTheme: DialogTheme(
              elevation: 0,
              backgroundColor: kBrandSecondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            colorScheme: ColorScheme.light(
              primary: kBrandPrimaryColor,
            ),
          ),
          child: widget!,
        );
      },
    );

    if (datetime != null) {
      _fechaController.text = datetime.toString().substring(0, 10);
      setState(() {});
    }
  }

  registroTask() {
    if (formKey.currentState!.validate()) {
      TaskModel taskModel = TaskModel(
        titulo: _tituloControlador.text,
        descripcion: _descripcionController.text,
        fecha: _fechaController.text,
        categoria: categoriaSelect,
        estado: true,
      );
      taskService.addTask(taskModel).then((value) {
        if (value.isNotEmpty) {
          Navigator.pop(context); // para que se cierre el formulario (modal)
          showSnackBarSuccess(context, "Tarea registrada..!");
        }
        ;
      }).catchError((error) {
        showSnackBarError(context, "Error de registro");
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "agregar tarea",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            divicion10(),
            TextFieldNormalhWidget(
              texto: "Titulo",
              icono: Icons.text_fields,
              controller: _tituloControlador,
            ),
            divicion10(),
            TextFieldNormalhWidget(
              texto: "Descripcion",
              icono: Icons.description,
              controller: _descripcionController,
            ),
            divicion10(),
            const Text("Categorias: "),
            Wrap(
              // crossAxisAlignment: WrapCrossAlignment.start,
              // runAlignment: WrapAlignment.start,
              spacing: 10,
              children: [
                FilterChip(
                  selected: categoriaSelect == "Personal", //dara true
                  label: Text("Personal"),
                  backgroundColor: kBrandSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  selectedColor: CategoryColor[categoriaSelect],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: categoriaSelect == "Personal"
                        ? Colors.white
                        : kBrandPrimaryColor,
                  ),
                  onSelected: (bool value) {
                    categoriaSelect = "Personal";
                    setState(() {});
                  },
                ),
                FilterChip(
                  selected: categoriaSelect == "Trabajo", //dara true
                  label: Text("Trabajo"),
                  backgroundColor: kBrandSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  selectedColor: CategoryColor[categoriaSelect],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: categoriaSelect == "Trabajo"
                        ? Colors.white
                        : kBrandPrimaryColor,
                  ),
                  onSelected: (bool value) {
                    categoriaSelect = "Trabajo";
                    setState(() {});
                  },
                ),
                FilterChip(
                  selected: categoriaSelect == "Otro", //dara true
                  label: Text("Otro"),
                  backgroundColor: kBrandSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  selectedColor: CategoryColor[categoriaSelect],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: categoriaSelect == "Otro"
                        ? Colors.white
                        : kBrandPrimaryColor,
                  ),
                  onSelected: (bool value) {
                    categoriaSelect = "Otro";
                    setState(() {});
                  },
                ),
              ],
            ),
            divicion10(),
            TextFieldNormalhWidget(
              controller: _fechaController,
              texto: "Fecha",
              icono: Icons.date_range,
              onTap: () {
                showSelectdate();
              },
            ),
            divicion10(),
            divicion10(),
            ButtonNormalWidget(
              onPress: () {
                registroTask();
              },
            ),
          ],
        ),
      ),
    );
  }
}
