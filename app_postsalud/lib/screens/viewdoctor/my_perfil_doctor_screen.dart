import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/widgets/reusable_perfil.dart';
import 'package:app_postsalud/widgets/reusable_perfil_item.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/reusable_app_bar.dart';
import 'package:app_postsalud/widgets/reusable_popup_menu_item_app_bar.dart';

class MyPerfilDoctorScreen extends StatefulWidget {
  const MyPerfilDoctorScreen({super.key});

  @override
  State<MyPerfilDoctorScreen> createState() => _MyPerfilDoctorScreenState();
}

class _MyPerfilDoctorScreenState extends State<MyPerfilDoctorScreen> {
  String userName = 'Medico'; // Valor por defecto
  UsuariosEntity? usuarioPaciente;

  @override
  void initState() {
    super.initState();
    cargarUsuarioAdmin(); // Llamar la función al iniciar
  }

  void cargarUsuarioAdmin() async {
    List<UsuariosEntity> usuarios =
        await UsuariosController.obtenerUsuariosAdmin();
    if (usuarios.isNotEmpty) {
      setState(() {
        usuarioPaciente = usuarios.first;
        userName = usuarioPaciente!.nombres; // Actualizar userName
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: 'Mi Perfil',
        userName: userName,
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
