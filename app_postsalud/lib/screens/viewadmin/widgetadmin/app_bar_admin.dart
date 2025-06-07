import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/reusable_app_bar.dart';
import 'package:app_postsalud/widgets/reusable_popup_menu_item_app_bar.dart';

class AppBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String title;

  const AppBarAdmin({super.key, required this.userName, required this.title});

  @override
  Widget build(BuildContext context) {
    return ReusableAppBar(
      title: title,
      userName: userName,
      popupMenuItems: [
        ReusablePopupMenuItem(
          icon: Icons.person,
          text: 'Home admin',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'homeadmin');
          },
        ),
        ReusablePopupMenuItem(
          icon: Icons.person,
          text: 'Mi Perfil',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'myperfiladmin');
          },
        ),
        ReusablePopupMenuItem(
          icon: Icons.calendar_today,
          text: 'Pacientes',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'vistapacientes');
          },
        ),
        ReusablePopupMenuItem(
          icon: Icons.calendar_today,
          text: 'Doctores',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'vistadoctores');
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
