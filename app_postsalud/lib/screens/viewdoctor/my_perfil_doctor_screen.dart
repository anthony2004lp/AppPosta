import 'package:app_postsalud/widgets/reusable_perfil.dart';
import 'package:app_postsalud/widgets/reusable_perfil_item.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/reusable_app_bar.dart';
import 'package:app_postsalud/widgets/reusable_popup_menu_item_app_bar.dart';

class MyPerfilDoctorScreen extends StatelessWidget {
  const MyPerfilDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: 'Mi Perfil',
        userName: 'Doctor',
        popupMenuItems: [
          ReusablePopupMenuItem(
            icon: Icons.person,
            text: 'Mi Perfil',
            onTap: () {
              Navigator.pushReplacementNamed(context, 'myPerfilDoctor');
            },
          ),
          ReusablePopupMenuItem(
            icon: Icons.logout,
            text: 'Cerrar Sesión',
            onTap: () {
              // Lógica para cerrar sesión
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Acción para las notificaciones
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ReusablePerfil(
            child: UserProfileWidget(
              imageUrl: 'assets/img/fondoLogin.png',
              title: 'Mi Perfil',
              nombres: 'Anthony',
              apellidos: 'Laura',
              edad: '34 años',
              dni: '12345678',
              telefono: '987654321',
              email: 'anthony@example.com',
            ),
          ),
        ],
      ),
    );
  }
}
