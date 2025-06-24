import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/anuncios_user.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/options_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'Paciente'; // Valor por defecto
  UsuariosEntity? usuarioPaciente;
  @override
  void initState() {
    super.initState();
    cargarUsuarioPaciente(); // Llamar la función al iniciar
  }

  void cargarUsuarioPaciente() async {
    List<UsuariosEntity> usuarios =
        await UsuariosController.obtenerUsuariosPaciente();
    if (usuarios.isNotEmpty) {
      setState(() {
        usuarioPaciente =
            usuarios.first; // Tomar el primer usuario con idRol == 1
        userName = usuarioPaciente!.nombres; // Actualizar userName
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(userName: userName, title: 'Home Paciente'),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(218, 255, 249, 1),
          child: Column(
            children: [
              carruselHomePatient(),
              Container(
                child: const Text(
                  'InformateMás',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
              ),
              optionsHomeUser(context),
              Container(
                margin: EdgeInsets.all(20),
                height: 200,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/img/fondoLogin.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
