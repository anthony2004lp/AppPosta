import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';

class InformacionUserPerfil extends StatefulWidget {
  const InformacionUserPerfil({super.key});

  @override
  State<InformacionUserPerfil> createState() => _InformacionUserPerfilState();
}

class _InformacionUserPerfilState extends State<InformacionUserPerfil> {
  int _calcularEdad(DateTime fechaNacimiento) {
    DateTime hoy = DateTime.now();
    int edad = hoy.year - fechaNacimiento.year;
    if (hoy.month < fechaNacimiento.month ||
        (hoy.month == fechaNacimiento.month && hoy.day < fechaNacimiento.day)) {
      edad--;
    }
    return edad;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: FutureBuilder<List<UsuariosEntity>>(
        future: UsuariosController.obtenerUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Indicador de carga
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
                    "No hay usuarios registrados")); // Manejo si no hay datos
          }

          // BORRAR es ejemplo
          // Tomamos el primer usuario como ejemplo
          UsuariosEntity usuario = snapshot.data!.first;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Mi Perfil',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w800),
              ),
              Text(
                'Nombres: ${usuario.nombres}',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                'Apellidos: ${usuario.apellidos}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              ),
              Text(
                'Edad: ${_calcularEdad(usuario.fechaNacimiento)} años', // Ahora la función está dentro de _InformacionUserPerfilState
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              ),
              Text(
                'DNI: ${usuario.dni}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              ),
              Text(
                'Teléfono: ${usuario.telefono}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              ),
              Text(
                'Email: ${usuario.email}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              ),
            ],
          );
        },
      ),
    );
  }
}
