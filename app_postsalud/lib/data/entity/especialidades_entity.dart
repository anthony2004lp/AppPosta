class EspecialidadEntity {
  int? idEspecialidad;
  String nombre;

  EspecialidadEntity({this.idEspecialidad, required this.nombre});

  factory EspecialidadEntity.fromMap(Map<String, dynamic> map) {
    return EspecialidadEntity(
      idEspecialidad: map['id_especialidad'] != null
          ? int.tryParse(map['id_especialidad'].toString())
          : null,
      nombre: map['nombre'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_especialidad': idEspecialidad,
      'nombre': nombre,
    };
  }
}
