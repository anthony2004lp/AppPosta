import 'package:app_postsalud/services/database_service.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';

class UsuariosController {
  Future<List<UsuariosEntity>> getUsuarios() async {
    var conn = await DatabaseService.connect();

    var result = await conn.execute("SELECT * FROM usuarios");

    List<UsuariosEntity> usuarios =
        result.rows.map((row) => UsuariosEntity.fromMap(row.assoc())).toList();

    await conn.close();
    return usuarios;
  }

  Future<void> agregarUsuario(UsuariosEntity usuario) async {
    var conn = await DatabaseService.connect();

    await conn.execute(
        "INSERT INTO usuarios (dni, email, contrasena, estado, fecha_registro) VALUES (?, ?, ?, ?, ?)",
        [
          usuario.dni,
          usuario.email,
          usuario.contrasena,
          // usuario.rol,
          usuario.estado ? 1 : 0,
          usuario.fechaRegistro.toIso8601String()
        ] as Map<String, dynamic>?);

    await conn.close();
  }
}
