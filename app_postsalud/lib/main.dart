import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/home_screen.dart';
import 'package:app_postsalud/screens/login_screen.dart';
import 'package:app_postsalud/screens/register_screen.dart';
import 'package:app_postsalud/screens/forgotpassword_screen.dart';

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
        'home': (_) => const HomeScreen(),
        'register': (_) => const RegisterScreen(),
        'forgotpassword': (_) => const ForgotpasswordScreen(),
      },
      initialRoute: 'login', //Llama a 'login'
    );
  }
}
