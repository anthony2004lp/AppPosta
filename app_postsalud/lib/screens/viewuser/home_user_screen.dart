import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(userName: 'Paciente'),
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
