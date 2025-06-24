import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/services/database_service.dart';

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
        cita.fecha.toIso8601String(),
        '${cita.hora.hour.toString().padLeft(2, '0')}:${cita.hora.minute.toString().padLeft(2, '0')}',
        cita.tipocita,
        cita.estado,
        cita.motivo,
        cita.observaciones,
        cita.fechareprogramada.toIso8601String(),
        '${cita.horareprogramada.hour.toString().padLeft(2, '0')}:${cita.horareprogramada.minute.toString().padLeft(2, '0')}',
      ] as Map<String, dynamic>?,
    );
    await conn.close();
  }

  static Future<void> updateCitas(CitasEntity cita) async {
    var conn = await DatabaseService.connect();
    await conn.execute(
      '''
        UPDATE citas SET 
          id_usuario=?, id_medico=?, id_especialidad=?, fecha=?, hora=?, tipo_cita=?, 
          estado=?, motivo=?, observaciones=?, fecha_reprogramada=?, hora_reprogramada=?
        WHERE id_cita=?
        ''',
      [
        cita.idusuario,
        cita.idmedico,
        cita.idespecialidad,
        cita.fecha.toIso8601String(),
        '${cita.hora.hour.toString().padLeft(2, '0')}:${cita.hora.minute.toString().padLeft(2, '0')}',
        cita.tipocita,
        cita.estado,
        cita.motivo,
        cita.observaciones,
        cita.fechareprogramada.toIso8601String(),
        '${cita.horareprogramada.hour.toString().padLeft(2, '0')}:${cita.horareprogramada.minute.toString().padLeft(2, '0')}',
        cita.idcita,
      ] as Map<String, dynamic>?,
    );
    await conn.close();
  }

  static Future<void> eliminarCita(int idCita) async {
    var conn = await DatabaseService.connect();
    await conn.execute("DELETE FROM citas WHERE id_cita = ?",
        [idCita] as Map<String, dynamic>?);
    await conn.close();
  }
}
