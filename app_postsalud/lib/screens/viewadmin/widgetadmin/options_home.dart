import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/custom_button.dart';

class OptionsHome extends StatefulWidget {
  const OptionsHome({super.key});

  @override
  State<OptionsHome> createState() => _OptionsHomeState();
}

class _OptionsHomeState extends State<OptionsHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButton(
          color: Color.fromRGBO(31, 214, 255, 1),
          onPressed: () {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final Offset offset = renderBox.localToGlobal(Offset.zero);
            final Size size = renderBox.size;
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                offset.dx +
                    size.width * 0.4, // Mueve el menú ligeramente a la derecha
                offset.dy +
                    size.height * 0.1, // Baja el menú para centrarlo mejor
                offset.dx + size.width, // Ajusta la posición derecha del menú
                offset.dy + size.height,
              ),
              items: [
                PopupMenuItem(
                  child: Text('Medicos'),
                  onTap: () {
                    // Acción para Opción 1
                  },
                ),
                PopupMenuItem(
                  child: Text('Historial medico'),
                  onTap: () {
                    // Acción para Opción 2
                  },
                ),
              ],
            );
          },
          imagePath: 'assets/img/fondoLogin.png',
          text: 'Médicos',
        ),
        SizedBox(height: 20), // Espacio entre botones
        CustomButton(
          color: Color.fromRGBO(51, 221, 8, 1),
          onPressed: () {
            // Acción al presionar el botón
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final Offset offset = renderBox.localToGlobal(Offset.zero);
            final Size size = renderBox.size;
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                offset.dx +
                    size.width * 0.4, // Mueve el menú ligeramente a la derecha
                offset.dy +
                    size.height * 0.35, // Baja el menú para centrarlo mejor
                offset.dx + size.width, // Ajusta la posición derecha del menú
                offset.dy + size.height,
              ),
              items: [
                PopupMenuItem(
                  child: Text('Pacientes'),
                  onTap: () {
                    // Acción para Opción 1
                    Navigator.pushNamed(context, '/listPaciente');
                  },
                ),
                PopupMenuItem(
                  child: Text('Historial paciente'),
                  onTap: () {
                    // Acción para Opción 2
                  },
                ),
              ],
            );
          },
          imagePath: 'assets/img/fondoLogin.png', // Imagen modificada
          text: 'Pacientes', // Texto modificado
        ),
        SizedBox(height: 20), // Espacio entre botones
        CustomButton(
          color: Color.fromRGBO(133, 203, 191, 1),
          onPressed: () {},
          imagePath: 'assets/img/fondoLogin.png', // Imagen modificada
          text: 'Citas', // Texto modificado
        ),
        SizedBox(height: 20), // Espacio entre botones
        CustomButton(
          color: Color.fromRGBO(255, 79, 79, 1),
          onPressed: () {},
          imagePath: 'assets/img/fondoLogin.png', // Imagen modificada
          text: 'Usuarios médicos', // Texto modificado
        ),
      ],
    );
  }
}
