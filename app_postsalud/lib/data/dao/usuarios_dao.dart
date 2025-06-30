import 'package:app_postsalud/services/database_service.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';

class UsuariosDao {
  // Obtener todos los usuarios
  static Future<List<UsuariosEntity>> getUsuarios() async {
    var conn = await DatabaseService.connect();

    var result = await conn.execute("SELECT * FROM usuarios");

    List<UsuariosEntity> usuarios =
        result.rows.map((row) => UsuariosEntity.fromMap(row.assoc())).toList();

    await conn.close();
    return usuarios;
  }

  static Future<UsuariosEntity?> getUsuariosByCredentials(
    String dni,
    String contrasena,
  ) async {
    var conn;
    try {
      conn = await DatabaseService.connect();
      final result = await conn.execute(
        'SELECT * FROM usuarios WHERE dni = :dni AND contrasena = :contrasena',
        {'dni': dni, 'contrasena': contrasena},
      );

      if (result.isNotEmpty) {
        return UsuariosEntity.fromMap(result.rows.first.assoc());
      }
      return null;
    } catch (e, st) {
      // Loguea el error para debugging
      print('🔴 Error en getUsuariosByCredentials: $e\n$st');
      return null;
    } finally {
      // Cierra la conexión siempre, incluso si hubo excepción
      if (conn != null) {
        await conn.close();
      }
    }
  }

  // Insertar un usuario nuevo
  static Future<void> insertUsuario(UsuariosEntity usuario) async {
    var conn = await DatabaseService.connect();

    await conn.execute(
      "INSERT INTO usuarios (nombres, apellidos, dni, telefono, email, contrasena, direccion, fecha_nacimiento, sexo, foto_url, id_rol, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [
        usuario.nombres,
        usuario.apellidos,
        usuario.dni,
        usuario.telefono,
        usuario.email,
        usuario.contrasena,
        usuario.direccion,
        usuario.fechaNacimiento?.toIso8601String(),
        usuario.sexo,
        usuario.fotoUrl,
        usuario.idRol,
        usuario.estado,
      ] as Map<String, dynamic>?,
    );

    await conn.close();
  }

  // Actualizar un usuario existente
  static Future<void> updateUsuario(UsuariosEntity usuario) async {
    var conn = await DatabaseService.connect();

    await conn.execute(
      "UPDATE usuarios SET nombres = ?, apellidos = ?, dni = ?, telefono = ?, email = ?, contrasena = ?, direccion = ?, fecha_nacimiento = ?, sexo = ?, foto_url = ?, id_rol = ?, estado = ? WHERE id_usuario = ?",
      [
        usuario.nombres,
        usuario.apellidos,
        usuario.dni,
        usuario.telefono,
        usuario.email,
        usuario.contrasena,
        usuario.direccion,
        usuario.fechaNacimiento?.toIso8601String(),
        usuario.sexo,
        usuario.fotoUrl,
        usuario.idRol,
        usuario.estado,
        usuario.idUsuario,
      ] as Map<String, dynamic>?,
    );

    await conn.close();
  }

  // data/dao/usuarios_dao.dart
  static Future<UsuariosEntity?> getUsuarioPorId(int id) async {
    final conn = await DatabaseService.connect();
    final result = await conn.execute(
      'SELECT * FROM usuarios WHERE id_usuario = :id',
      {'id': id},
    );
    await conn.close();
    if (result.isNotEmpty) {
      return UsuariosEntity.fromMap(result.rows.first.assoc());
    }
    return null;
  }

  // Eliminar un usuario por ID
  static Future<void> deleteUsuario(int idUsuario) async {
    var conn = await DatabaseService.connect();

    await conn.execute("DELETE FROM usuarios WHERE id_usuario = ?",
        [idUsuario] as Map<String, dynamic>?);

    await conn.close();
  }
}
