import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/informacion_user_perfil.dart';

class MyPerfilUserScreen extends StatefulWidget {
  const MyPerfilUserScreen({super.key});

  @override
  State<MyPerfilUserScreen> createState() => _MyPerfilUserScreenState();
}

class _MyPerfilUserScreenState extends State<MyPerfilUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(userName: 'paciente'),
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
