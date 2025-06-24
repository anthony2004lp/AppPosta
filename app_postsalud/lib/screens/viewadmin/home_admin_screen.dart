import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/options_home.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  String userName = 'Administrador'; // Valor por defecto
  UsuariosEntity? usuarioAdmin;

  @override
  void initState() {
    super.initState();
    cargarUsuarioAdmin(); // Llamar la función al iniciar
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
      appBar: AppBarAdmin(title: 'Home Admin', userName: userName),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(218, 255, 249, 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Bienvenido $userName', // Usa el nombre dinámico
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              OptionsHome(),
            ],
          ),
        ),
      ),
    );
  }
}
