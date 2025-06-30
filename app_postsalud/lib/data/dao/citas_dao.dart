import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/data/entity/paciente_cita.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
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
    ( id_medico, id_especialidad, fecha, hora, tipo_cita, estado)  
    VALUES (:id_medico, :id_especialidad, :fecha, :hora, :tipo_cita, :estado)
  ''',
      {
        'id_medico': cita.idmedico,
        'id_especialidad': cita.idespecialidad,
        'fecha': cita.fecha?.toIso8601String(),
        'hora': cita.hora != null
            ? '${cita.hora!.hour.toString().padLeft(2, '0')}:${cita.hora!.minute.toString().padLeft(2, '0')}:00'
            : null,
        'tipo_cita': cita.tipocita,
        'estado': cita.estado,
      },
    );
    await conn.close();
  }

  static Future<bool> updateCitaDetalles(CitasEntity cita) async {
    try {
      final conn = await DatabaseService.connect();

      String formatTimeOfDay(TimeOfDay? t) {
        if (t == null) return '';
        return '${t.hour.toString().padLeft(2, '0')}:'
            '${t.minute.toString().padLeft(2, '0')}:00';
      }

      await conn.execute(
        '''
      UPDATE citas
         SET id_medico          = :id_medico,
             id_especialidad    = :id_especialidad,
             fecha              = :fecha,
             hora               = :hora,
             tipo_cita          = :tipo_cita,
             estado             = :estado,
             fecha_reprogramada = :fecha_reprogramada,
             hora_reprogramada  = :hora_reprogramada
       WHERE id_cita = :id_cita
      ''',
        {
          'id_medico': cita.idmedico,
          'id_especialidad': cita.idespecialidad,
          'fecha': cita.fecha?.toIso8601String(),
          'hora': formatTimeOfDay(cita.hora),
          'tipo_cita': cita.tipocita,
          'estado': cita.estado,
          'fecha_reprogramada': cita.fechareprogramada?.toIso8601String(),
          'hora_reprogramada': formatTimeOfDay(cita.horareprogramada),
          'id_cita': cita.idcita,
        },
      );
      await conn.close();
      return true;
    } catch (e, st) {
      debugPrint('🔴 Error updateCitaDetalles: $e\n$st');
      return false;
    }
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

  static Future<List<CitasEntity>> getPorMedicoPaciente(int idMedico) async {
    final conn = await DatabaseService.connect();
    final result = await conn.execute(
      '''
    SELECT *
      FROM citas
     WHERE id_medico  = :id_medico
       AND id_usuario IS NOT NULL
    ''',
      {'id_medico': idMedico},
    );
    final citas =
        result.rows.map((r) => CitasEntity.fromMap(r.assoc())).toList();
    await conn.close();
    return citas;
  }

  // data/dao/citas_dao.dart
  static Future<List<PacienteCita>> getPacientesCitasPorMedico(
      int idMedico) async {
    final conn = await DatabaseService.connect();
    final result = await conn.execute(
      '''
    SELECT u.*, c.fecha AS cita_fecha, c.hora AS cita_hora
      FROM citas c
      JOIN usuarios u
        ON c.id_usuario = u.id_usuario
     WHERE c.id_medico = :med
       AND c.id_usuario IS NOT NULL
    ''',
      {'med': idMedico},
    );
    await conn.close();

    return result.rows.map((row) {
      final m = row.assoc();
      final paciente = UsuariosEntity.fromMap(m);
      final fecha = DateTime.parse(m['cita_fecha'] as String);
      // suponemos hora en formato "HH:mm:ss"
      final parts = (m['cita_hora'] as String).split(':');
      final hora =
          TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      return PacienteCita(paciente: paciente, fechaCita: fecha, horaCita: hora);
    }).toList();
  }

  // data/dao/citas_dao.dart
  static Future<List<CitasEntity>> getCitasPorUsuarioMedico(
      int idUsuario) async {
    final conn = await DatabaseService.connect();
    final result = await conn.execute(
      '''
    SELECT c.*
      FROM citas c
      JOIN medicos m
        ON c.id_medico = m.id_medico
     WHERE m.id_usuario = :uid
    ''',
      {'uid': idUsuario},
    );
    await conn.close();

    return result.rows.map((row) => CitasEntity.fromMap(row.assoc())).toList();
  }

  // data/dao/citas_dao.dart
  static Future<bool> updateObservaciones(int idCita, String obs) async {
    try {
      final conn = await DatabaseService.connect();
      await conn.execute(
        'UPDATE citas SET observaciones = :obs WHERE id_cita = :id',
        {'obs': obs, 'id': idCita},
      );
      await conn.close();
      return true;
    } catch (_) {
      return false;
    }
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
