import 'package:app_postsalud/data/dao/citas_dao.dart';
import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/data/entity/paciente_cita.dart';
import 'package:app_postsalud/services/database_service.dart';
import 'package:flutter/material.dart';

class CitasController {
  static Future<List<CitasEntity>> obtenerCitas() async {
    try {
      return await CitasDao.getCitas();
    } catch (e) {
      return Future.error("Error al obtener las citas: $e");
    }
  }

  // data/controllers/citas_controller.dart
  static Future<List<CitasEntity>> obtenerCitasPorUsuarioMedico(int idUsuario) {
    return CitasDao.getCitasPorUsuarioMedico(idUsuario);
  }

  static Future<bool> guardarObservaciones(int idCita, String obs) {
    return CitasDao.updateObservaciones(idCita, obs);
  }

  static Future<bool> actualizarCitaDetalles(CitasEntity cita) {
    return CitasDao.updateCitaDetalles(cita);
  }

  static Future<void> agregarCita(
      BuildContext context, CitasEntity cita, Function onSuccess) async {
    try {
      await CitasDao.insertarCita(cita);
      onSuccess();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cita registrada exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar cita: $e')),
      );
    }
  }

  static Future<void> actualizarCita(
      BuildContext context, CitasEntity cita, Function onSuccess) async {
    try {
      await CitasDao.updateCitas(cita);
      onSuccess();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cita actualizada correctamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la cita: $e')),
      );
    }
  }

  static Future<void> eliminarCita(
      BuildContext context, int idCita, Function onSuccess) async {
    try {
      await CitasDao.eliminarCita(idCita);
      onSuccess();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cita eliminada con éxito')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar la cita: $e')),
      );
    }
  }

  static Future<List<CitasEntity>> getCitasPorMedico(int idMedico) async {
    var conn = await DatabaseService.connect();
    var result = await conn.execute(
      "SELECT * FROM citas "
      "WHERE id_medico = :id_medico "
      "AND id_usuario IS NOT NULL",
      {'id_medico': idMedico},
    );
    List<CitasEntity> citas =
        result.rows.map((row) => CitasEntity.fromMap(row.assoc())).toList();
    await conn.close();
    return citas;
  }

  static Future<List<PacienteCita>> obtenerPacientesCitasPorMedico(
      int idMedico) {
    return CitasDao.getPacientesCitasPorMedico(idMedico);
  }

  static Future<List<CitasEntity>> obtenerCitasPorIdPosta(int idPosta) async {
    return await CitasDao.getCitasPorIdPosta(idPosta);
  }
}
