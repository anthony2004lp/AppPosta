import 'package:app_postsalud/data/dao/especialidades_dao.dart';

class EspecialidadesController {
  static Future<String> obtenerNombreEspecialidadPorId(
      int idEspecialidad) async {
    final especialidades = await EspecialidadDao.getNombreforId(idEspecialidad);
    if (especialidades.isNotEmpty) {
      return especialidades.first.nombre ?? 'Sin nombre';
    }
    return 'No encontrada';
  }
}
