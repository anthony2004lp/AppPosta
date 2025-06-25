import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewdoctor/widgetdoctor/app_bar_doctor.dart';
import 'package:flutter/material.dart';

class MisPacientesScreen extends StatefulWidget {
  const MisPacientesScreen({super.key});

  @override
  State<MisPacientesScreen> createState() => _MisPacientesScreenState();
}

class _MisPacientesScreenState extends State<MisPacientesScreen> {
  final String userName = 'Doctor';
  UsuariosEntity? usuarioMedico;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDoctor(
        userName: 'Doctor', // Aquí puedes obtener el nombre del doctor
        title: 'Mis Pacientes',
      ),
      body: const Center(
        child: Text('Esta pantalla mostrará los pacientes del doctor.'),
      ),
    );
  }
}
