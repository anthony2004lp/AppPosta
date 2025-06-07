import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/services/database_service.dart';

class CitasDao {
  // Obtener todos los usuarios
  static Future<List<CitasEntity>> getUsuarios() async {
    var conn = await DatabaseService.connect();

    var result = await conn.execute("SELECT * FROM citas");

    List<CitasEntity> citas =
        result.rows.map((row) => CitasEntity.fromMap(row.assoc())).toList();

    await conn.close();
    return citas;
  }
}
