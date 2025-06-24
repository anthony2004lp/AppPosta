import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/reusable_app_bar.dart';
import 'package:app_postsalud/widgets/reusable_popup_menu_item_app_bar.dart';

class AppBarDoctor extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String title;

  const AppBarDoctor({super.key, required this.userName, required this.title});

  @override
  Widget build(BuildContext context) {
    return ReusableAppBar(
      title: title,
      userName: userName,
      popupMenuItems: [
        ReusablePopupMenuItem(
          icon: Icons.person,
          text: 'Mi Perfil',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'myperfildoctor');
          },
        ),
        ReusablePopupMenuItem(
          icon: Icons.calendar_today,
          text: 'Citas',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'citasDoctor');
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
