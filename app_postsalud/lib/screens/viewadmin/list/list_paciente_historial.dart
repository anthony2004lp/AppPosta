import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/login/login_screen.dart';

class ListPacienteHistorial extends StatefulWidget {
  const ListPacienteHistorial({super.key});

  @override
  State<ListPacienteHistorial> createState() => _ListPacienteHistorialState();
}

class _ListPacienteHistorialState extends State<ListPacienteHistorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAdmin(
        title: 'Historial P.',
        userName: 'Administrador',
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.blue,
              child: const Text('Imprimir Lista',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Cambiar por el número real de pacientes
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Paciente ${index + 1}'),
                      subtitle: Text('Detalles del paciente ${index + 1}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.info),
                        onPressed: () {
                          // Acción al presionar el botón de información
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
