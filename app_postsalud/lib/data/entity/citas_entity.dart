import 'package:flutter/material.dart';

class CitasEntity {
  int idcita;
  int? idusuario;
  int idmedico;
  int idespecialidad;
  int? idposta;
  DateTime? fecha;
  TimeOfDay? hora;
  String tipocita;
  String estado;
  String? motivo;
  String observaciones;
  DateTime? fechareprogramada;
  TimeOfDay? horareprogramada;

  CitasEntity({
    required this.idcita,
    this.idusuario,
    required this.idmedico,
    required this.idespecialidad,
    this.idposta,
    this.fecha,
    this.hora,
    required this.tipocita,
    required this.estado,
    required this.motivo,
    required this.observaciones,
    this.fechareprogramada,
    this.horareprogramada,
  });

  factory CitasEntity.fromMap(Map<String, dynamic> map) {
    return CitasEntity(
      idcita: map['id_cita'] != null ? int.parse(map['id_cita'].toString()) : 0,
      idusuario: map['id_usuario'] != null
          ? int.parse(map['id_usuario'].toString())
          : 0,
      idmedico:
          map['id_medico'] != null ? int.parse(map['id_medico'].toString()) : 0,
      idespecialidad: map['id_especialidad'] != null
          ? int.parse(map['id_especialidad'].toString())
          : 0,
      idposta: map['id_posta'] != null
          ? int.parse(map['id_posta'].toString())
          : null,
      fecha: DateTime.parse(map['fecha'])
          .toLocal()
          .copyWith(hour: 0, minute: 0, second: 0),
      hora: (map['hora'] != null && map['hora'].contains(":"))
          ? TimeOfDay(
              hour: int.parse(map['hora'].split(":")[0]),
              minute: int.parse(map['hora'].split(":")[1]),
            )
          : const TimeOfDay(hour: 0, minute: 0),
      tipocita: map['tipo_cita'] ?? '',
      estado: map['estado'] ?? '',
      motivo: map['motivo'] ?? '',
      observaciones: map['observaciones'] ?? '',
      fechareprogramada: map['fecha_programada'] != null
          ? DateTime.parse(map['fecha_programada'])
              .toLocal()
              .copyWith(hour: 0, minute: 0, second: 0)
          : DateTime.now(),
      horareprogramada: map['hora_reprogramada'] != null &&
              map['hora_reprogramada'].contains(":")
          ? TimeOfDay(
              hour: int.parse(map['hora_reprogramada'].split(":")[0]),
              minute: int.parse(map['hora_reprogramada'].split(":")[1]),
            )
          : const TimeOfDay(hour: 0, minute: 0),
    );
  }

  Map<String, dynamic> toMap() {
    String formatTime(TimeOfDay? t) {
      if (t == null) return '00:00:00';
      return '${t.hour.toString().padLeft(2, '0')}:'
          '${t.minute.toString().padLeft(2, '0')}:00';
    }

    return {
      'id_cita': idcita,
      'id_usuario': idusuario,
      'id_medico': idmedico,
      'id_especialidad': idespecialidad,
      'id_posta': idposta,
      'fecha': fecha?.toIso8601String(),
      'hora': formatTime(hora),
      'tipo_cita': tipocita,
      'estado': estado,
      'motivo': motivo,
      'observaciones': observaciones,
      'fecha_reprogramada': fechareprogramada?.toIso8601String(),
      'hora_reprogramada': formatTime(horareprogramada),
    };
  }
}
