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
        '''SELECT * FROM usuarios WHERE dni = :dni AND contrasena = :contrasena''',
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

  static Future<void> insertUsuario(UsuariosEntity usuario) async {
    var conn = await DatabaseService.connect();

    await conn.execute(
      '''
    INSERT INTO usuarios 
      (nombres, apellidos, dni, telefono, email, contrasena, direccion, fecha_nacimiento, sexo, id_rol, estado) 
    VALUES 
      (:nombres, :apellidos, :dni, :telefono, :email, :contrasena, :direccion, :fecha_nacimiento, :sexo, :id_rol, :estado)
    ''',
      {
        'nombres': usuario.nombres,
        'apellidos': usuario.apellidos,
        'dni': usuario.dni,
        'telefono': usuario.telefono,
        'email': usuario.email,
        'contrasena': usuario.contrasena,
        'direccion': usuario.direccion,
        'fecha_nacimiento':
            usuario.fechaNacimiento?.toIso8601String().split('T').first,
        'sexo': usuario.sexo,
        'id_rol': usuario.idRol,
        'estado': usuario.estado,
      },
    );

    await conn.close();
  }

  static Future<void> updateUsuario(UsuariosEntity usuario) async {
    final conn = await DatabaseService.connect();

    await conn.execute(
      '''
    UPDATE usuarios SET
      nombres          = :nombres,
      apellidos        = :apellidos,
      dni              = :dni,
      telefono         = :telefono,
      email            = :email,
      contrasena       = :contrasena,
      direccion        = :direccion,
      fecha_nacimiento = :fecha_nacimiento,
      sexo             = :sexo,
      id_rol           = :id_rol,
      estado           = :estado
    WHERE id_usuario = :id_usuario
    ''',
      {
        'nombres': usuario.nombres,
        'apellidos': usuario.apellidos,
        'dni': usuario.dni,
        'telefono': usuario.telefono,
        'email': usuario.email,
        'contrasena': usuario.contrasena,
        'direccion': usuario.direccion,
        'fecha_nacimiento':
            usuario.fechaNacimiento?.toIso8601String().split('T').first,
        'sexo': usuario.sexo,
        'id_rol': usuario.idRol,
        'estado': usuario.estado,
        'id_usuario': usuario.idUsuario,
      },
    );

    await conn.close();
  }

  // data/dao/usuarios_dao.dart
  static Future<UsuariosEntity?> getUsuarioPorId(int id) async {
    final conn = await DatabaseService.connect();
    final result = await conn.execute(
      '''SELECT * FROM usuarios WHERE id_usuario = :id''',
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

    await conn.execute(
        '''DELETE FROM usuarios WHERE id_usuario = :id_usuario''',
        {'id_usuario': idUsuario});

    await conn.close();
  }
}
