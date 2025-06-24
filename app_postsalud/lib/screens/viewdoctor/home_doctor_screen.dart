import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewdoctor/widgetdoctor/custom_button.dart';
import 'package:app_postsalud/screens/viewdoctor/widgetdoctor/app_bar_doctor.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  String userName = 'Medico'; // Valor por defecto
  UsuariosEntity? usuarioMedico;

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
        usuarioMedico =
            usuarios.first; // Tomar el primer usuario con idRol == 1
        userName = usuarioMedico!.nombres; // Actualizar userName
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDoctor(userName: userName, title: 'Home Doctor'),
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
                child: const Text(
                  'Bienvenido, \nMedico General',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onPressed: () {},
                      imagePath:
                          'assets/img/fondoLogin.png', // Imagen modificada
                      text: 'Mis\nPacientes', // Texto modificado
                    ),
                    SizedBox(height: 20), // Espacio entre botones
                    CustomButton(
                      onPressed: () {},
                      imagePath:
                          'assets/img/fondoLogin.png', // Imagen modificada
                      text: 'Ver\nReportes', // Texto modificado
                    ),
                    SizedBox(height: 20), // Espacio entre botones
                    CustomButton(
                      onPressed: () {},
                      imagePath:
                          'assets/img/fondoLogin.png', // Imagen modificada
                      text: 'Notas\nMédicas', // Texto modificado
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
