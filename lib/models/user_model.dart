class UserModel {
  String? id; //puede ser null
  String fullNombre;
  String correo;

  UserModel({
    this.id,
    required this.fullNombre,
    required this.correo,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullNombre": fullNombre,
        "correo": correo,
      };
}
