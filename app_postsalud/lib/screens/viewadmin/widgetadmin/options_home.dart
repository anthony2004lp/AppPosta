import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/custom_button.dart';

class OptionsHome extends StatefulWidget {
  const OptionsHome({super.key});

  @override
  State<OptionsHome> createState() => _OptionsHomeState();
}

class _OptionsHomeState extends State<OptionsHome> {
  void _showError(Object e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('¡Ups! Ocurrió un error: $e')));
  }

  void _openMenu({
    required Offset position,
    required List<PopupMenuEntry> items,
  }) {
    try {
      showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            position.dx,
            position.dy,
            position.dx,
            position.dy,
          ),
          items: items);
    } catch (e) {
      _showError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButton(
          color: const Color.fromRGBO(31, 214, 255, 1),
          text: 'Médicos',
          imagePath: 'assets/img/fondoLogin.png',
          onPressed: () {
            try {
              final box = context.findRenderObject() as RenderBox;
              final pos = box.localToGlobal(Offset.zero);
              _openMenu(
                position: Offset(
                  pos.dx + box.size.width * 0.4,
                  pos.dy + box.size.height * 0.1,
                ),
                items: [
                  PopupMenuItem(
                    child: const Text('Medicos'),
                    onTap: () {
                      try {
                        Navigator.pushReplacementNamed(context, 'listadoctor');
                      } catch (e) {
                        _showError(e);
                      }
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Historial medico'),
                    onTap: () {
                      try {
                        // aquí podrías poner tu navegación
                      } catch (e) {
                        _showError(e);
                      }
                    },
                  ),
                ],
              );
            } catch (e) {
              _showError(e);
            }
          },
        ),
        const SizedBox(height: 20),
        CustomButton(
          color: const Color.fromRGBO(51, 221, 8, 1),
          text: 'Pacientes',
          imagePath: 'assets/img/fondoLogin.png',
          onPressed: () {
            try {
              final box = context.findRenderObject() as RenderBox;
              final pos = box.localToGlobal(Offset.zero);
              _openMenu(
                position: Offset(
                  pos.dx + box.size.width * 0.4,
                  pos.dy + box.size.height * 0.35,
                ),
                items: [
                  PopupMenuItem(
                    child: const Text('Pacientes'),
                    onTap: () {
                      try {
                        Navigator.pushNamed(context, 'listPaciente');
                      } catch (e) {
                        _showError(e);
                      }
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Historial paciente'),
                    onTap: () {
                      try {
                        Navigator.popAndPushNamed(
                            context, 'listpacientehistorial');
                      } catch (e) {
                        _showError(e);
                      }
                    },
                  ),
                ],
              );
            } catch (e) {
              _showError(e);
            }
          },
        ),
        const SizedBox(height: 20),
        CustomButton(
          color: const Color.fromRGBO(133, 203, 191, 1),
          text: 'Citas',
          imagePath: 'assets/img/fondoLogin.png',
          onPressed: () {
            try {
              Navigator.pushReplacementNamed(context, 'listacitas');
            } catch (e) {
              _showError(e);
            }
          },
        ),
        const SizedBox(height: 20),
        CustomButton(
          color: const Color.fromRGBO(255, 79, 79, 1),
          text: 'Usuarios médicos',
          imagePath: 'assets/img/fondoLogin.png',
          onPressed: () {
            try {
              // Acción o navegación que corresponda
            } catch (e) {
              _showError(e);
            }
          },
        ),
      ],
    );
  }
}
