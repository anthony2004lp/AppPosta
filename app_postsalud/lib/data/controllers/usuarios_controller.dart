import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/data/dao/usuarios_dao.dart';

class UsuariosController {
  static Future<List<UsuariosEntity>> obtenerUsuarios() async {
    return await UsuariosDao.getUsuarios();
  }

  static Future<void> actualizarUsuario(UsuariosEntity usuario) async {
    await UsuariosDao.updateUsuario(usuario);
  }
}
