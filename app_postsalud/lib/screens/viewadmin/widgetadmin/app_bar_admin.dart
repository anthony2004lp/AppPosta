import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/reusable_app_bar.dart';
import 'package:app_postsalud/widgets/reusable_popup_menu_item_app_bar.dart';

class AppBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  const AppBarAdmin({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return ReusableAppBar(
      title: 'Home Admin',
      userName: userName,
      popupMenuItems: [
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
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
