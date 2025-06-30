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
  String userName = 'Médico';
  UsuariosEntity? usuarioMedico;
  int? idUsuario;

  @override
  void initState() {
    super.initState();

    // Esperar que el contexto esté disponible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      idUsuario = ModalRoute.of(context)!.settings.arguments as int;
      cargarNombreMedico();
    });
  }

  void cargarNombreMedico() async {
    final nombre = await UsuariosController.obtenerNombreMedico();
    if (nombre != null) {
      setState(() {
        userName = nombre;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDoctor(
        userName: userName,
        title: 'Home Doctor, ID: $idUsuario',
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(218, 255, 249, 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Bienvenido, \nMédico General',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onPressed: () async {
                        try {
                          if (idUsuario != null) {
                            Navigator.pushReplacementNamed(
                              context,
                              'mispacientes',
                              arguments: idUsuario,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'No se pudo obtener ID del usuario')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Error al abrir "Mis Pacientes": $e')),
                          );
                        }
                      },
                      imagePath: 'assets/img/fondoLogin.png',
                      text: 'Mis\nPacientes',
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: () async {
                        try {
                          if (idUsuario != null) {
                            Navigator.pushReplacementNamed(
                              context,
                              'miscitasdoctor',
                              arguments: idUsuario,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'No se pudo obtener ID del usuario')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Error al abrir "Mis Citas": $e')),
                          );
                        }
                      },
                      imagePath: 'assets/img/fondoLogin.png',
                      text: 'Mis citas',
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: () async {
                        try {
                          // Navegación futura aquí
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Funcionalidad en desarrollo')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Error al abrir "Notas Médicas": $e')),
                          );
                        }
                      },
                      imagePath: 'assets/img/fondoLogin.png',
                      text: 'Notas\nMédicas',
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
