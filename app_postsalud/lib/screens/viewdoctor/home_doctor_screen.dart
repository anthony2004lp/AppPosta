import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewdoctor/widgetdoctor/custom_button.dart';
import 'package:app_postsalud/screens/viewdoctor/widgetdoctor/app_bar_doctor.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDoctor(userName: 'Doctor'),
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
