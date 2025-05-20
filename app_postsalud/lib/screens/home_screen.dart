import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(40, 157, 137, 1),
        title: Row(
          children: [
            SizedBox(
              width: 20,
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showMenu(
                    menuPadding: EdgeInsets.symmetric(horizontal: 0),
                    color: Color.fromRGBO(40, 157, 137, 1),
                    context: context,
                    position: const RelativeRect.fromLTRB(0, 110, 0, 50),
                    items: [
                      PopupMenuItem(
                        value: 1,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black, width: 2), // Borde negro
                            borderRadius:
                                BorderRadius.circular(10), // Bordes redondeados
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          margin: const EdgeInsets.only(bottom: 5),
                          // Espacio entre los elementos
                          child: Row(
                            children: [
                              Icon(Icons.house, color: Colors.black),
                              SizedBox(width: 10),
                              Text('Inicio'),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, 'myperfil');
                        },
                        value: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          margin: const EdgeInsets.only(bottom: 5),
                          // Espacio entre los elementos
                          child: Row(
                            children: [
                              Icon(Icons.account_circle_outlined,
                                  color: Colors.black),
                              SizedBox(width: 10),
                              Text('Mi perfil'),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Icon(Icons.exit_to_app_outlined,
                                  color: Colors.black),
                              SizedBox(width: 10),
                              Text('Cerrar sesión'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).then((value) {
                    return value != null ? null : 'Opción seleccionada: $value';
                  });
                },
                child: const Icon(Icons.menu, size: 20),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'BIENVENIDO',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(218, 255, 249, 1),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: [Colors.red, Colors.green, Colors.blue].map((color) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      width: double.infinity,
                      child: Center(
                          child: Text("holaaaaaaaaaaaa",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black))),
                    );
                  }).toList(),
                ),
              ),
              Container(
                child: const Text(
                  'InformateMás',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // Distribuye los elementos uniformemente
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/img/fondoLogin.png',
                              fit: BoxFit.cover,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Espacio entre imagen y texto
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Consulta\nMédica',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/img/fondoLogin.png',
                              fit: BoxFit.cover,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: const Text(
                              'Geolocalizador',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/img/fondoLogin.png',
                              fit: BoxFit.cover,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Reservar\nCita',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape
                                .circle, // Hace que el contenedor sea circular
                            border: Border.all(
                                color: Colors.black, width: 3), // Borde azul
                          ),
                          child: ClipOval(
                            // Recorta la imagen en forma circular
                            child: Image.asset(
                              'assets/img/fondoLogin.png',
                              fit: BoxFit.cover,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Consulta\nMédica',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(20),
                height: 200,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/img/fondoLogin.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
                color: Colors.pink,
                child: const Text(
                  'Regresar a Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
