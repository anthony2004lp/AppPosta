class MedicosEntity {
  int? idMedico;
  String? apellidos;
  String? nombres;
  String? dni;
  String? correo;
  String? telefono;
  String? direccionPersonal;
  DateTime? fechaNacimiento;
  String? sexo;
  int? idEspecialidad;
  String? direccionConsultorio;
  String? ciudad;
  String? region;
  String? horarioAtencion;
  String? fotoUrl;
  int? idPosta;

  MedicosEntity({
    this.idMedico,
    this.apellidos,
    this.nombres,
    this.dni,
    this.correo,
    this.telefono,
    this.direccionPersonal,
    this.fechaNacimiento,
    this.sexo,
    this.idEspecialidad,
    this.direccionConsultorio,
    this.ciudad,
    this.region,
    this.horarioAtencion,
    this.fotoUrl,
    this.idPosta,
  });

  factory MedicosEntity.fromMap(Map<String, dynamic> map) {
    return MedicosEntity(
      idMedico: map['id_medico'] != null
          ? int.tryParse(map['id_medico'].toString())
          : null,
      apellidos: map['apellidos'],
      nombres: map['nombres'],
      dni: map['dni'],
      correo: map['correo'],
      telefono: map['telefono'],
      direccionPersonal: map['direccion_personal'],
      fechaNacimiento: map['fecha_nacimiento'] != null
          ? DateTime.tryParse(map['fecha_nacimiento'].toString())
          : null,
      sexo: map['sexo'],
      idEspecialidad: map['id_especialidad'] != null
          ? int.tryParse(map['id_especialidad'].toString())
          : null,
      direccionConsultorio: map['direccion_consultorio'],
      ciudad: map['ciudad'],
      region: map['region'],
      horarioAtencion: map['horario_atencion'],
      fotoUrl: map['foto_url'],
      idPosta: map['id_posta'] != null
          ? int.tryParse(map['id_posta'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_medico': idMedico,
      'apellidos': apellidos,
      'nombres': nombres,
      'dni': dni,
      'correo': correo,
      'telefono': telefono,
      'direccion_personal': direccionPersonal,
      'fecha_nacimiento': fechaNacimiento?.toIso8601String().split('T').first,
      'sexo': sexo,
      'id_especialidad': idEspecialidad,
      'direccion_consultorio': direccionConsultorio,
      'ciudad': ciudad,
      'region': region,
      'horario_atencion': horarioAtencion,
      'foto_url': fotoUrl,
      'id_posta': idPosta,
    };
  }
}
