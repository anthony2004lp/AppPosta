import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewdoctor/widgetdoctor/app_bar_doctor.dart';
import 'package:flutter/material.dart';

class MisCitasDoctorScreen extends StatefulWidget {
  const MisCitasDoctorScreen({super.key});

  @override
  State<MisCitasDoctorScreen> createState() => _MisCitasDoctorScreenState();
}

class _MisCitasDoctorScreenState extends State<MisCitasDoctorScreen> {
  late String userName =
      'Doctor'; // Valor por defecto, puedes cambiarlo según sea necesario
  UsuariosEntity?
      usuarioMedico; // Si necesitas usar el usuario del doctor, descomenta esta línea

  @override
  void initState() {
    super.initState();

    cargarUsuarioDoctor();
  }

  void cargarUsuarioDoctor() async {
    List<UsuariosEntity> usuarios =
        await UsuariosController.obtenerUsuariosMedico();
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
        appBar: AppBarDoctor(
          userName: userName, // Aquí puedes obtener el nombre del doctor
          title: 'Mis Citas',
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(218, 255, 249, 1),
            ),
            child: const Center(
              child: Text(
                'Esta pantalla mostrará las citas del doctor.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ));
  }
}
