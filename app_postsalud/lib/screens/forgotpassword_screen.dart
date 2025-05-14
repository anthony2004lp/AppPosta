import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/input_decoration.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Contiene a todos los widgets
      body: Container(
        color: Color.fromRGBO(218, 255, 249, 1),
        child: SizedBox(
          height: double.infinity, //Ocupa toda la altura
          width: double.infinity, //Ocupa todo el ancho
          child: Stack(
            //Conjunto de widgets, Uno encima de otro
            children: [
              for (final posicion in posicionesIzquierda)
                Positioned(
                  left: posicion.dx,
                  top: posicion.dy,
                  child: burbuja(),
                ),
              for (final posicion in posicionesDerecha)
                Positioned(
                  right: posicion.dx,
                  bottom: posicion.dy,
                  child: burbuja(),
                ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            children: [
                              Form(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Olvido su contraseña',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color:
                                                Color.fromRGBO(0, 11, 83, 1)),
                                      ),
                                    ),
                                    textFormFieldEmail(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      padding: EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          top: 15,
                                          bottom: 15),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      color: Color.fromRGBO(39, 157, 137, 1),
                                      onPressed: () {},
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    buttonBackLogin(context)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField textFormFieldEmail() {
    return TextFormField(
      decoration: InputDecorations.inputDecoration(
        hintText: 'example@gmail.com',
        labelText: 'Email',
        icono: Icon(Icons.password_rounded),
      ),
      keyboardType: TextInputType.text,
    );
  }

  MaterialButton buttonBackLogin(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Color.fromRGBO(193, 193, 192, 1),
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'login');
      },
      child: Text(
        'Volver',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
    );
  }
}

// Posiciones para las burbujas de la parte superior izquierda
List<Offset> posicionesIzquierda = [
  Offset(80, 50),
  Offset(40, 50),
  Offset(0, 50),
  Offset(80, 80),
  Offset(40, 80),
  Offset(0, 80),
  Offset(80, 110),
  Offset(40, 110),
  Offset(0, 110),
];

// Posiciones para las burbujas de la parte inferior derecha
List<Offset> posicionesDerecha = [
  Offset(80, 50),
  Offset(40, 50),
  Offset(0, 50),
  Offset(80, 80),
  Offset(40, 80),
  Offset(0, 80),
  Offset(80, 110),
  Offset(40, 110),
  Offset(0, 110),
];

Container burbuja() {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: const Color.fromRGBO(40, 157, 137, 1),
    ),
  );
}
