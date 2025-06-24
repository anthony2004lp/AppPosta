import 'package:app_postsalud/data/dao/citas_dao.dart';
import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:flutter/material.dart';

class CitasController {
  static Future<List<CitasEntity>> obtenerCitas() async {
    try {
      return await CitasDao.getCitas();
    } catch (e) {
      return Future.error("Error al obtener las citas: $e");
    }
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
}
