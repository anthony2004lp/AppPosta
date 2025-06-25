import 'package:app_postsalud/data/entity/especialidades_entity.dart';
import 'package:app_postsalud/services/database_service.dart';

class EspecialidadDao {
  static Future<List<EspecialidadEntity>> getEspecialidades() async {
    var conn = await DatabaseService.connect();
    var result = await conn.execute('SELECT * FROM especialidades');
    List<EspecialidadEntity> especialidades = result.rows
        .map((row) => EspecialidadEntity.fromMap(row.assoc()))
        .toList();
    await conn.close();
    return especialidades;
  }

  static Future<List<EspecialidadEntity>> buscarPorNombre(String texto) async {
    var conn = await DatabaseService.connect();
    var result = await conn.execute(
      'SELECT * FROM especialidades WHERE nombre LIKE :nombre',
      {'nombre': '%$texto%'},
    );
    List<EspecialidadEntity> especialidades = result.rows
        .map((row) => EspecialidadEntity.fromMap(row.assoc()))
        .toList();
    await conn.close();
    return especialidades;
  }
}
