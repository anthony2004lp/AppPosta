import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/services/database_service.dart';
import 'package:flutter/material.dart';

class CitasDao {
  static Future<List<CitasEntity>> getCitas() async {
    var conn = await DatabaseService.connect();
    var result = await conn.execute("SELECT * FROM citas");
    List<CitasEntity> citas =
        result.rows.map((row) => CitasEntity.fromMap(row.assoc())).toList();
    await conn.close();
    return citas;
  }

  static Future<void> insertarCita(CitasEntity cita) async {
    var conn = await DatabaseService.connect();
    await conn.execute(
      '''
    INSERT INTO citas  
    (id_usuario, id_medico, id_especialidad, fecha, hora, tipo_cita, estado, motivo, observaciones, fecha_reprogramada, hora_reprogramada)  
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''',
      [
        cita.idusuario,
        cita.idmedico,
        cita.idespecialidad,
        cita.fecha?.toIso8601String(),
        '${cita.hora?.hour.toString().padLeft(2, '0')}:${cita.hora?.minute.toString().padLeft(2, '0')}',
        cita.tipocita,
        cita.estado,
        cita.motivo,
        cita.observaciones,
        cita.fechareprogramada?.toIso8601String(),
        '${cita.horareprogramada?.hour.toString().padLeft(2, '0')}:${cita.horareprogramada?.minute.toString().padLeft(2, '0')}',
      ] as Map<String, dynamic>?,
    );
    await conn.close();
  }

  static Future<void> updateCitas(CitasEntity cita) async {
    var conn = await DatabaseService.connect();

    String formatTimeOfDay(TimeOfDay time) {
      return '${time.hour.toString().padLeft(2, '0')}:'
          '${time.minute.toString().padLeft(2, '0')}:00';
    }

    await conn.execute(
        " UPDATE citas SET id_usuario= :id_usuario, id_medico= :id_medico, id_especialidad= :id_especialidad, fecha= :fecha, hora= :hora, tipo_cita=:tipo_cita, estado= :estado, motivo= :motivo, observaciones= :observaciones, fecha_reprogramada= :fecha_reprogramada, hora_reprogramada= :hora_reprogramada  WHERE id_cita= :id_cita",
        {
          'id_usuario': cita.idusuario,
          'id_medico': cita.idmedico,
          'id_especialidad': cita.idespecialidad,
          'fecha': cita.fecha?.toIso8601String(),
          'tipo_cita': cita.tipocita,
          'estado': cita.estado,
          'motivo': cita.motivo,
          'observaciones': cita.observaciones,
          'fecha_reprogramada': cita.fechareprogramada?.toIso8601String(),
          'hora': cita.hora != null ? formatTimeOfDay(cita.hora!) : null,
          'hora_reprogramada': cita.horareprogramada != null
              ? formatTimeOfDay(cita.horareprogramada!)
              : null,
          'id_cita': cita.idcita,
        });
    await conn.close();
  }

  static Future<List<CitasEntity>> getCitasPorUsuario(int idUsuario) async {
    var conn = await DatabaseService.connect();
    var result = await conn.execute(
        "SELECT * FROM citas WHERE id_usuario = :id_usuario",
        {'id_usuario': idUsuario});
    List<CitasEntity> citas =
        result.rows.map((row) => CitasEntity.fromMap(row.assoc())).toList();
    await conn.close();
    return citas;
  }

  static Future<List<CitasEntity>> getCitasPorIdPosta(int idPosta) async {
    var conn = await DatabaseService.connect();
    var result = await conn.execute(
        "SELECT * FROM citas WHERE id_posta = :id_posta",
        {'id_posta': idPosta});
    List<CitasEntity> citas =
        result.rows.map((row) => CitasEntity.fromMap(row.assoc())).toList();
    await conn.close();
    return citas;
  }

  static Future<void> eliminarCita(int idCita) async {
    var conn = await DatabaseService.connect();
    await conn.execute("DELETE FROM citas WHERE id_cita = ?",
        [idCita] as Map<String, dynamic>?);
    await conn.close();
  }
}
