class UsuariosEntity {
  int? idUsuario;
  String nombres;
  String apellidos;
  String dni;
  String telefono;
  String email;
  String contrasena;
  String direccion;
  DateTime? fechaNacimiento;
  String sexo;
  String fotoUrl;
  int idRol;
  DateTime? fechaRegistro;
  String estado;

  UsuariosEntity({
    this.idUsuario,
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.telefono,
    required this.email,
    required this.contrasena,
    required this.direccion,
    this.fechaNacimiento,
    required this.sexo,
    required this.fotoUrl,
    required this.idRol,
    this.fechaRegistro,
    required this.estado,
  });

  // Convertir desde Map (para obtener datos desde la BD)
  factory UsuariosEntity.fromMap(Map<String, dynamic> map) {
    return UsuariosEntity(
      idUsuario: map['id_usuario'] != null
          ? int.tryParse(map['id_usuario'].toString())
          : null,
      nombres: map['nombres'] ?? '',
      apellidos: map['apellidos'] ?? '',
      dni: map['dni'] ?? '',
      telefono: map['telefono'] ?? '',
      email: map['email'] ?? '',
      contrasena: map['contrasena'] ?? '',
      direccion: map['direccion'] ?? '',
      sexo: map['sexo'] ?? '',
      fotoUrl: map['foto_url'] ?? '',
      idRol: int.tryParse(map['id_rol'].toString()) ?? 0,
      fechaNacimiento: map['fecha_nacimiento'] != null
          ? DateTime.tryParse(map['fecha_nacimiento'].toString())
          : null,
      fechaRegistro: map['fecha_registro'] != null
          ? DateTime.tryParse(map['fecha_registro'].toString())
          : null,
      estado: map['estado'] ?? 'activo',
    );
  }

  // Convertir a Map (para insertar o actualizar en la BD)
  Map<String, dynamic> toMap() {
    return {
      'id_usuario': idUsuario,
      'nombres': nombres,
      'apellidos': apellidos,
      'dni': dni,
      'telefono': telefono,
      'email': email,
      'contrasena': contrasena,
      'direccion': direccion,
      'sexo': sexo,
      'foto_url': fotoUrl,
      'id_rol': idRol,
      'fecha_nacimiento':
          fechaNacimiento?.toLocal().toIso8601String().split('T')[0],
      'fecha_registro':
          fechaRegistro?.toLocal().toIso8601String().split('T')[0],
      'estado': estado,
    };
  }

  // Future<UsuariosEntity> fromMap(Map<String, String?> assoc) {}
}
