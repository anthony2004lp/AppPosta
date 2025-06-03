class UsuariosEntity {
  final int idUsuario;
  final String dni;
  final String email;
  final String contrasena;
  // final String rol;
  final bool estado;
  final DateTime fechaRegistro;

  UsuariosEntity({
    required this.idUsuario,
    required this.dni,
    required this.email,
    required this.contrasena,
    // required this.rol,
    required this.estado,
    required this.fechaRegistro,
  });

  factory UsuariosEntity.fromMap(Map<String, dynamic> map) {
    return UsuariosEntity(
      idUsuario: int.parse(map["id_usuario"]),
      dni: map["dni"],
      email: map["email"],
      contrasena: map["contrasena"],
      // rol: map["rol"],
      estado: map["estado"] == 1,
      fechaRegistro: DateTime.parse(map["fecha_registro"]),
    );
  }
}
