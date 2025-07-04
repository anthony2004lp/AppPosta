import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/reusable_app_bar.dart';
import 'package:app_postsalud/widgets/reusable_popup_menu_item_app_bar.dart';

class AppBarUser extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String title;
  final int? idPosta;

  const AppBarUser(
      {super.key, required this.userName, required this.title, this.idPosta});

  @override
  Widget build(BuildContext context) {
    final idUsuario = ModalRoute.of(context)?.settings.arguments as int?;

    return ReusableAppBar(
      userName: userName,
      popupMenuItems: [
        ReusablePopupMenuItem(
          icon: Icons.home,
          text: 'Inicio',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'homeuser',
                arguments: idUsuario);
          },
        ),
        ReusablePopupMenuItem(
          icon: Icons.person,
          text: 'Mi Perfil',
          onTap: () {
            Navigator.pushReplacementNamed(context, 'myperfiluser',
                arguments: idUsuario);
          },
        ),
        ReusablePopupMenuItem(
            icon: Icons.calendar_today,
            text: 'Citas',
            onTap: () {
              Navigator.pushReplacementNamed(context, 'miscitas',
                  arguments: idUsuario);
            }),
        ReusablePopupMenuItem(
          icon: Icons.logout,
          text: 'Cerrar Sesión',
          onTap: () {
            // Lógica para cerrar sesión
            Navigator.pushNamedAndRemoveUntil(
              context,
              'login',
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
