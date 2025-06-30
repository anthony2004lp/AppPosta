import 'package:app_postsalud/data/dao/medicos_dao.dart';
import 'package:app_postsalud/data/entity/medicos_entity.dart';
import 'package:app_postsalud/services/database_service.dart';
import 'package:flutter/material.dart';

class MedicosController {
  static Future<List<MedicosEntity>> obtenerMedicos() async {
    return await MedicosDao.getMedicos();
  }

  // Actualizar un usuario existente
  static Future<void> actualizarMedico(MedicosEntity medico) async {
    await MedicosDao.updateMedico(medico);
  }

  static Future<MedicosEntity?> obtenerMedicoPorUsuario(int idUsuario) async {
    return await MedicosDao.getMedicoPorUsuario(idUsuario);
  }

  static Future<void> agregarMedico(
      BuildContext context, MedicosEntity medico, Function onSuccess) async {
    try {
      await MedicosDao.insertMedico(medico);
      onSuccess(); // Recarga datos tras inserción
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Médico agregado exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar médico: $e')),
      );
    }
  }

  static Future<void> buscarMedico(MedicosEntity medico) async {
    return await MedicosDao.updateMedico(medico);
  }

  static Future<List<MedicosEntity>> obtenerMedicosPorPosta(int idPosta) async {
    return await MedicosDao.obtenerMedicosPorPosta(idPosta);
  }

  static Future<int?> obtenerIdMedicoPorUsuario(int idUsuario) async {
    final conn = await DatabaseService.connect();
    final result = await conn.execute(
      'SELECT id_medico FROM medicos WHERE id_usuario = :id',
      {'id': idUsuario},
    );
    await conn.close();
    if (result.isNotEmpty) {
      return int.tryParse(result.rows.first.assoc()['id_medico'].toString());
    }
    return null;
  }

  static Future<void> eliminarMedico(
      BuildContext context, int idMedico, Function onSuccess) async {
    try {
      await MedicosDao.deleteMedico(idMedico);
      onSuccess(); // Recarga datos tras eliminación
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Médico eliminado exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar médico: $e')),
      );
    }
  }
}
