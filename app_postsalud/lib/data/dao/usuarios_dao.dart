import 'package:app_postsalud/services/database_service.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';

class UsuariosDao {
  static Future<List<UsuariosEntity>> getUsuarios() async {
    var conn = await DatabaseService.connect(); // Conectar correctamente

    var result = await conn
        .execute("SELECT * FROM usuarios"); // Consulta a la tabla correcta

    List<UsuariosEntity> usuarios =
        result.rows.map((row) => UsuariosEntity.fromMap(row.assoc())).toList();

    await conn.close(); // Cerrar conexión después de ejecutar

    return usuarios;
  }
}
