import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';

class MyPerfilAdminScreen extends StatefulWidget {
  const MyPerfilAdminScreen({super.key});

  @override
  State<MyPerfilAdminScreen> createState() => _MyPerfilAdminScreenState();
}

class _MyPerfilAdminScreenState extends State<MyPerfilAdminScreen> {
  UsuariosEntity? usuarioAdmin;
  String userName = 'Administrador'; // Valor por defecto

  @override
  void initState() {
    super.initState();
    cargarUsuarioAdmin();
  }

  void cargarUsuarioAdmin() async {
    List<UsuariosEntity> usuarios =
        await UsuariosController.obtenerUsuariosAdmin();
    if (usuarios.isNotEmpty) {
      setState(() {
        usuarioAdmin = usuarios.first; // Tomar el primer usuario con idRol == 1
        userName = usuarioAdmin!.nombres; // Actualizar userName
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAdmin(title: 'Perfil Admin', userName: userName),
      body: usuarioAdmin == null
          ? Center(child: CircularProgressIndicator()) // Mientras carga
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(186, 237, 229, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Mi Perfil',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  'Nombres: ${usuarioAdmin!.nombres}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Apellidos: ${usuarioAdmin!.apellidos}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Edad: ${usuarioAdmin!.fechaNacimiento != null ? DateTime.now().year - usuarioAdmin!.fechaNacimiento!.year : "N/A"}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'DNI: ${usuarioAdmin!.dni}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Teléfono: ${usuarioAdmin!.telefono}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Email: ${usuarioAdmin!.email}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
