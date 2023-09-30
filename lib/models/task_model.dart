class TaskModel {
  String? id;
  String titulo;
  String descripcion;
  String fecha;
  String categoria;
  bool estado;

  TaskModel({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.categoria,
    required this.estado,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"] ?? "", //si es null manda vacio
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        fecha: json["fecha"],
        categoria: json["categoria"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "descripcion": descripcion,
        "fecha": fecha,
        "categoria": categoria,
        "estado": estado,
      };
}
