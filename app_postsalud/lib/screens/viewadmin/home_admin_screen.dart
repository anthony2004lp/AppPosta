import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/options_home.dart';

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
              OptionsHome(),
            ],
          ),
        ),
      ),
    );
  }
}
