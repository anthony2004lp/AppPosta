import 'package:app_postsalud/screens/viewadmin/list/list_citas_screen.dart';
import 'package:app_postsalud/screens/viewadmin/list/list_medicos_screen.dart';
import 'package:app_postsalud/screens/viewadmin/list/list_paciente_historial_screen.dart';
import 'package:app_postsalud/screens/viewdoctor/mis_pacientes_screen.dart';
import 'package:app_postsalud/screens/viewdoctor/my_perfil_doctor_screen.dart';
import 'package:app_postsalud/screens/viewuser/my_citas_screen.dart';
import 'package:app_postsalud/screens/viewuser/reserva_cita_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewuser/home_user_screen.dart';
import 'package:app_postsalud/screens/login/login_screen.dart';
import 'package:app_postsalud/screens/login/register_screen.dart';
import 'package:app_postsalud/screens/login/forgot_password_screen.dart';
import 'package:app_postsalud/screens/viewuser/my_perfil_user_screen.dart';
import 'package:app_postsalud/screens/viewdoctor/home_doctor_screen.dart';
import 'package:app_postsalud/screens/viewdoctor/citas_doctor_screen.dart';
import 'package:app_postsalud/screens/viewadmin/home_admin_screen.dart';
import 'package:app_postsalud/screens/viewadmin/my_perfil_admin_screen.dart';
import 'package:app_postsalud/screens/viewuser/map_user.dart';
import 'package:app_postsalud/screens/viewadmin/list/list_paciente_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Contiene toda la aplicacion
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: {
        //Asignacion de un nombre a LoginScreen para llamarlo
        'login': (_) => const LoginScreen(),
        'homeuser': (_) => const HomeScreen(),
        'register': (_) => const RegisterScreen(),
        'forgotpassword': (_) => const ForgotpasswordScreen(),
        'myperfiluser': (_) => const MyPerfilUserScreen(),
        'homedoctor': (_) => const HomeDoctorScreen(),
        'myperfildoctor': (_) => const MyPerfilDoctorScreen(),
        'citasdoctor': (_) => const CitasDoctorScreen(),
        'homeadmin': (_) => const HomeAdminScreen(),
        'myperfiladmin': (_) => const MyPerfilAdminScreen(),
        'mapuser': (_) => const MapUser(),
        'listPaciente': (_) => const ListPacienteScreen(),
        'listpacientehistorial': (_) => const ListPacienteHistorial(),
        'listadoctor': (_) => const ListMedicosScreen(),
        'listacitas': (_) => const ListCitasScreen(),
        'reservacita': (_) => const ReservaCitaScreen(),
        'miscitas': (_) => const MyCitasScreen(),
        'mispacientes': (_) => const MisPacientesScreen(),
      },
      initialRoute: 'login', //Llama a 'login'
    );
  }
}
