import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/reusable_app_bar.dart';
import 'package:app_postsalud/widgets/reusable_popup_menu_item_app_bar.dart';

class AppBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String title;

  const AppBarAdmin({super.key, required this.userName, required this.title});

  @override
  Widget build(BuildContext context) {
    final idUsuario = ModalRoute.of(context)?.settings.arguments as int?;
    return Builder(builder: (_) {
      try {
        return ReusableAppBar(
          title: title,
          userName: userName,
          popupMenuItems: [
            ReusablePopupMenuItem(
              icon: Icons.person,
              text: 'Home admin',
              onTap: () {
                Navigator.pushReplacementNamed(context, 'homeadmin',
                    arguments: idUsuario);
              },
            ),
            ReusablePopupMenuItem(
              icon: Icons.person,
              text: 'Mi Perfil',
              onTap: () {
                Navigator.pushReplacementNamed(context, 'myperfiladmin',
                    arguments: idUsuario);
              },
            ),
            ReusablePopupMenuItem(
              icon: Icons.list_alt,
              text: 'Pacientes',
              onTap: () {
                Navigator.pushReplacementNamed(context, 'listPaciente',
                    arguments: idUsuario);
              },
            ),
            ReusablePopupMenuItem(
              icon: Icons.list_alt,
              text: 'Doctores',
              onTap: () {
                Navigator.pushReplacementNamed(context, 'listadoctor',
                    arguments: idUsuario);
              },
            ),
            ReusablePopupMenuItem(
              icon: Icons.list_alt,
              text: 'Citas',
              onTap: () {
                Navigator.pushReplacementNamed(context, 'listacitas',
                    arguments: idUsuario);
              },
            ),
            ReusablePopupMenuItem(
              icon: Icons.logout,
              text: 'Cerrar Sesión',
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'login',
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      } catch (e, st) {
        log('Error');
        return Center(
          child: Text('Ha ocurrido un problema'),
        );
      }
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
