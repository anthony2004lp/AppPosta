class CitasEntity {
  final int idcita;
  final int idusuario;
  final int idmedico;
  final int idespecialidad;
  final DateTime fecha;
  final DateTime hora;
  final String tipocita;
  final String estado;
  final String motivo;
  final String observaciones;
  final DateTime fechareprogramada;
  final DateTime horareprogramada;

  CitasEntity({
    required this.idcita,
    required this.idusuario,
    required this.idmedico,
    required this.idespecialidad,
    required this.fecha,
    required this.hora,
    required this.tipocita,
    required this.estado,
    required this.motivo,
    required this.observaciones,
    required this.fechareprogramada,
    required this.horareprogramada,
  });

  factory CitasEntity.fromMap(Map<String, dynamic> map) {
    return CitasEntity(
      idcita: map['id_cita'] != null ? int.parse(map['id_cita'].toString()) : 0,
      idusuario:
          map['idusuario'] != null ? int.parse(map['idusuario'].toString()) : 0,
      idmedico:
          map['idmedico'] != null ? int.parse(map['idmedico'].toString()) : 0,
      idespecialidad: map['idespecialidad'] != null
          ? int.parse(map['idespecialidad'].toString())
          : 0,
      fecha: DateTime.parse(map['fecha']),
      hora: DateTime.parse(map['hora']),
      tipocita: map['tipo'] ?? '',
      estado: map['estado'] ?? 'pendiente',
      motivo: map['motivo'] ?? '',
      observaciones: map['observaciones'] ?? '',
      fechareprogramada: DateTime.parse(map['fechareprogramada']),
      horareprogramada: DateTime.parse(map['horareprogramada']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_cita': idcita,
      'id_usuario': idusuario,
      'id_medico': idmedico,
      'id_posta': idespecialidad,
      'id_especialidad': fecha.toIso8601String(),
      'fecha': hora.toIso8601String(),
      'tipo_cita': tipocita,
      'estado': estado,
      'motivo': motivo,
      'observaciones': observaciones,
      'fecha_reprogramada': fechareprogramada.toIso8601String(),
      'hora_reprogramada': horareprogramada.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'CitasEntity{idcita: $idcita, idusuario: $idusuario, idmedico: $idmedico, idespecialidad: $idespecialidad, fecha: $fecha, hora: $hora, estado: $estado, motivo: $motivo, observaciones: $observaciones, fechareprogramada: $fechareprogramada, horareprogramada: $horareprogramada}';
  }
}
