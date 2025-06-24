import 'package:flutter/material.dart';

class CitasEntity {
  int idcita;
  int idusuario;
  int idmedico;
  int idespecialidad;
  DateTime fecha;
  TimeOfDay hora;
  String tipocita;
  String estado;
  String motivo;
  String observaciones;
  DateTime fechareprogramada;
  TimeOfDay horareprogramada;

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
      idusuario: map['id_usuario'] != null
          ? int.parse(map['id_usuario'].toString())
          : 0,
      idmedico:
          map['id_medico'] != null ? int.parse(map['id_medico'].toString()) : 0,
      idespecialidad: map['id_especialidad'] != null
          ? int.parse(map['id_especialidad'].toString())
          : 0,
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
    return {
      'id_cita': idcita,
      'id_usuario': idusuario,
      'id_medico': idmedico,
      'id_especialidad': idespecialidad,
      'fecha': fecha.toIso8601String(),
      'hora':
          '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}',
      'tipo_cita': tipocita,
      'estado': estado,
      'hora_reprogramada':
          '${horareprogramada.hour.toString().padLeft(2, '0')}:${horareprogramada.minute.toString().padLeft(2, '0')}',
      'observaciones': observaciones,
      'fecha_reprogramada': fechareprogramada.toIso8601String(),
    };
  }
}
