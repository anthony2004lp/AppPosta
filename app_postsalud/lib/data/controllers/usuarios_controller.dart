import 'package:flutter/material.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/data/dao/usuarios_dao.dart';

class UsuariosController {
  // Obtener la lista de usuarios
  static Future<List<UsuariosEntity>> obtenerUsuarios() async {
    return await UsuariosDao.getUsuarios();
  }

  // Actualizar un usuario existente
  static Future<void> actualizarUsuario(UsuariosEntity usuario) async {
    await UsuariosDao.updateUsuario(usuario);
  }

  // Eliminar un usuario con manejo de UI
  static Future<void> eliminarUsuario(
      BuildContext context, int idUsuario, Function actualizarLista) async {
    try {
      await UsuariosDao.deleteUsuario(idUsuario);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario eliminado correctamente')),
      );

      actualizarLista(); // Llama la función para actualizar la lista en la UI
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar usuario: $error')),
      );
    }
  }

  // Agregar un usuario nuevo
  static Future<void> agregarUsuario(BuildContext context,
      UsuariosEntity usuario, Function actualizarLista) async {
    try {
      await UsuariosDao.insertUsuario(usuario);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Paciente registrado correctamente')),
      );

      actualizarLista(); // Refrescar la lista de usuarios después de la inserción
      Navigator.pop(context); // Cerrar la ventana flotante tras el registro
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar paciente: $error')),
      );
    }
  }

  static Future<List<UsuariosEntity>> obtenerUsuariosAdmin() async {
    List<UsuariosEntity> usuarios = await UsuariosDao.getUsuarios();
    return usuarios.where((user) => user.idRol == 3).toList();
  }

  static Future<String?> obtenerNombreAdmin() async {
    List<UsuariosEntity> usuarios = await UsuariosDao.getUsuarios();
    UsuariosEntity? admin = usuarios.firstWhere(
      (user) => user.idRol == 3,
      orElse: () => UsuariosEntity(
        nombres: "Administrador", // Valor por defecto si no se encuentra
        apellidos: "",
        dni: "",
        telefono: "",
        email: "",
        contrasena: "",
        direccion: "",
        sexo: "",
        fotoUrl: "",
        idRol: 1,
        estado: "activo",
      ),
    );
    return admin.nombres;
  }

  // static Future<List<UsuariosEntity>> obtenerUsuariosMedico(int idUsuario) async {
  //   List<UsuariosEntity> usuarios = await UsuariosDao.getUsuarios();
  //   return usuarios.where((user) => user.idRol == 2).toList();
  // }

  static Future<UsuariosEntity?> obtenerUsuarioPorId(int idUsuario) async {
    return await UsuariosDao.getUsuarioPorId(idUsuario);
  }

  static Future<String?> obtenerNombreMedico() async {
    List<UsuariosEntity> usuarios = await UsuariosDao.getUsuarios();
    UsuariosEntity? medico = usuarios.firstWhere(
      (user) => user.idRol == 2,
      orElse: () => UsuariosEntity(
        nombres: "Medico", // Valor por defecto si no se encuentra
        apellidos: "",
        dni: "",
        telefono: "",
        email: "",
        contrasena: "",
        direccion: "",
        sexo: "",
        fotoUrl: "",
        idRol: 2,
        estado: "activo",
      ),
    );
    return medico.nombres;
  }

  static Future<UsuariosEntity?> obtenerUsuarioMedicoId(int idUsuario) async {
    List<UsuariosEntity> usuarios = await UsuariosDao.getUsuarios();
    try {
      return usuarios.firstWhere(
        (u) => u.idRol == 2 && u.idUsuario == idUsuario,
      );
    } catch (_) {
      return null; // Si no lo encuentra, devolvemos null
    }
  }

  static Future<UsuariosEntity?> obtenerUsuarioPacienteId(int idUsuario) async {
    List<UsuariosEntity> usuarios = await UsuariosDao.getUsuarios();
    try {
      return usuarios.firstWhere(
        (u) => u.idRol == 1 && u.idUsuario == idUsuario,
      );
    } catch (_) {
      return null; // Si no lo encuentra, devolvemos null
    }
  }

  static Future<String?> obtenerNombrePaciente() async {
    List<UsuariosEntity> usuarios = await UsuariosDao.getUsuarios();
    UsuariosEntity? paciente = usuarios.firstWhere(
      (user) => user.idRol == 1,
      orElse: () => UsuariosEntity(
        nombres: "Paciente", // Valor por defecto si no se encuentra
        apellidos: "",
        dni: "",
        telefono: "",
        email: "",
        contrasena: "",
        direccion: "",
        sexo: "",
        fotoUrl: "",
        idRol: 1,
        estado: "activo",
      ),
    );
    return paciente.nombres;
  }
}
