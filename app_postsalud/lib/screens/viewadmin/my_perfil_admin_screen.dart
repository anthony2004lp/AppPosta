import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';

class MyPerfilAdminScreen extends StatefulWidget {
  const MyPerfilAdminScreen({super.key});

  @override
  State<MyPerfilAdminScreen> createState() => _MyPerfilAdminScreenState();
}

class _MyPerfilAdminScreenState extends State<MyPerfilAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAdmin(userName: 'Administrador'),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(186, 237, 229, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/img/fondoLogin.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Mi Perfil',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Nombres: ', // Colocar una variable con el nombre del usuario obtenido desde la BD
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Apellidos: ', // Colocar una variable con el apellido del usuario obtenido desde la BD
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Edad: ', // Colocar una variable con el correo del usuario obtenido desde la BD
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'DNI: ', // Colocar una variable con el correo del usuario obtenido desde la BD
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Teléfono: ', // Colocar una variable con el correo del usuario obtenido desde la BD
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Email: ', // Colocar una variable con el correo del usuario obtenido desde la BD
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(186, 237, 229, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            ' Datos Personales',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Dirección',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Fecha de Nacimiento',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Contacto de Emergencia',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Información medica',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Grupo Sanguíneo',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Alergias',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Enfermedades',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Discapacidades',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
