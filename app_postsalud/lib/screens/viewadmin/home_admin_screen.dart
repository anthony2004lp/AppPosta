import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/custom_button.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAdmin(userName: 'Administrador'),
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
                  'Bienvenido Administrador',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    color: Color.fromRGBO(31, 214, 255, 1),
                    onPressed: () {},
                    imagePath: 'assets/img/fondoLogin.png', // Imagen modificada
                    text: 'Médicos', // Texto modificado
                  ),
                  SizedBox(height: 20), // Espacio entre botones
                  CustomButton(
                    color: Color.fromRGBO(51, 221, 8, 1),
                    onPressed: () {},
                    imagePath: 'assets/img/fondoLogin.png', // Imagen modificada
                    text: 'Pacientes', // Texto modificado
                  ),
                  SizedBox(height: 20), // Espacio entre botones
                  CustomButton(
                    color: Color.fromRGBO(133, 203, 191, 1),
                    onPressed: () {},
                    imagePath: 'assets/img/fondoLogin.png', // Imagen modificada
                    text: 'Citas', // Texto modificado
                  ),
                  SizedBox(height: 20), // Espacio entre botones
                  CustomButton(
                    color: Color.fromRGBO(255, 79, 79, 1),
                    onPressed: () {},
                    imagePath: 'assets/img/fondoLogin.png', // Imagen modificada
                    text: 'Usuarios médicos', // Texto modificado
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
