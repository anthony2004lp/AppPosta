import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/informacion_user_perfil.dart';

class MyPerfilUserScreen extends StatefulWidget {
  const MyPerfilUserScreen({super.key});

  @override
  State<MyPerfilUserScreen> createState() => _MyPerfilUserScreenState();
}

class _MyPerfilUserScreenState extends State<MyPerfilUserScreen> {
  String userName = 'Administrador'; // Valor por defecto
  UsuariosEntity? usuarioPaciente;
  late int idUsuario;

  void initState() {
    super.initState();
    cargarUsuarioPaciente(); // Llamar la función al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      idUsuario = ModalRoute.of(context)!.settings.arguments as int;
    });
  }

  void cargarUsuarioPaciente() async {
    UsuariosEntity? usuario =
        await UsuariosController.obtenerUsuarioPacienteId(idUsuario);
    if (usuario != null) {
      // úsalo directamente
      userName = usuario.nombres;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(userName: userName, title: 'Mi Perfil'),
      body: Column(
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
                  ClipOval(
                    child: Image.asset(
                      'assets/img/fondoLogin.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InformacionUserPerfil(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
