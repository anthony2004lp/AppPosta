import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/anuncios_user.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/options_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(userName: 'Paciente'),
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
              optionsHomeUser(),
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
