import 'package:flutter/material.dart';

class ReusablePerfil extends StatelessWidget {
  final Widget child;

  const ReusablePerfil({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(186, 237, 229, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: child, // Aquí se coloca el contenido dinámico
      ),
    );
  }
}
