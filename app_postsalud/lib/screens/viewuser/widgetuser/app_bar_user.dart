import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/reusable_app_bar.dart';
import 'package:app_postsalud/widgets/reusable_popup_menu_item_app_bar.dart';

class AppBarUser extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  const AppBarUser({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return ReusableAppBar(
      title: 'Home Usuario',
      userName: userName,
      popupMenuItems: [
        ReusablePopupMenuItem(
          icon: Icons.home,
          text: 'Inicio',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'homeuser');
          },
        ),
        ReusablePopupMenuItem(
          icon: Icons.person,
          text: 'Mi Perfil',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'myperfiluser');
          },
        ),
        ReusablePopupMenuItem(
          icon: Icons.calendar_today,
          text: 'Citas',
          onTap: () {
            // Lógica para navegar a la pantalla de citas
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
