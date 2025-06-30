import 'package:app_postsalud/data/controllers/citas_controller.dart';
import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/controllers/medicos_controller.dart';
import 'package:app_postsalud/data/entity/paciente_cita.dart';
import 'package:app_postsalud/screens/viewdoctor/widgetdoctor/app_bar_doctor.dart';
import 'package:flutter/material.dart';

class MisPacientesScreen extends StatefulWidget {
  const MisPacientesScreen({super.key});
  @override
  State<MisPacientesScreen> createState() => _MisPacientesScreenState();
}

class _MisPacientesScreenState extends State<MisPacientesScreen> {
  int? idUsuario;
  Future<List<PacienteCita>>? _futurePacientesCitas;
  String userName = 'Doctor';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (idUsuario == null) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        idUsuario = args;

        // Obtener el id_medico correspondiente al usuario logueado
        MedicosController.obtenerIdMedicoPorUsuario(idUsuario!)
            .then((idMedico) {
          if (idMedico != null && mounted) {
            setState(() {
              _futurePacientesCitas =
                  CitasController.obtenerPacientesCitasPorMedico(idMedico);
            });
          }
        });

        // Cargar nombre del usuario para el AppBar
        UsuariosController.obtenerUsuarioPorId(idUsuario!).then((u) {
          if (u != null && mounted) {
            setState(() => userName = u.nombres);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDoctor(userName: userName, title: 'Mis Pacientes'),
      body: FutureBuilder<List<PacienteCita>>(
        future: _futurePacientesCitas,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final lista = snap.data ?? [];
          if (lista.isEmpty) {
            return const Center(child: Text('No tienes pacientes asignados.'));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID Paciente')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Apellido')),
                DataColumn(label: Text('DNI')),
                DataColumn(label: Text('Sexo')),
                DataColumn(label: Text('Edad')),
                DataColumn(label: Text('Fecha Cita')),
                DataColumn(label: Text('Hora Cita')),
                DataColumn(label: Text('Teléfono')),
              ],
              rows: lista.map((pc) {
                final p = pc.paciente;
                final edad = p.fechaNacimiento != null
                    ? DateTime.now().year - p.fechaNacimiento!.year
                    : null;

                return DataRow(
                  onSelectChanged: (_) => _mostrarDetalle(pc),
                  cells: [
                    DataCell(Text(p.idUsuario.toString())),
                    DataCell(Text(p.nombres)),
                    DataCell(Text(p.apellidos)),
                    DataCell(Text(p.dni)),
                    DataCell(Text(p.sexo)),
                    DataCell(Text(edad?.toString() ?? '-')),
                    DataCell(Text(pc.fechaCita
                        .toLocal()
                        .toIso8601String()
                        .split('T')
                        .first)),
                    DataCell(Text(pc.horaCita.format(context))),
                    DataCell(Text(p.telefono)),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  void _mostrarDetalle(PacienteCita pc) {
    final p = pc.paciente;
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${p.nombres} ${p.apellidos}',
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            Text('DNI: ${p.dni}'),
            Text('Sexo: ${p.sexo}'),
            if (p.fechaNacimiento != null)
              Text(
                  'Edad: ${DateTime.now().year - p.fechaNacimiento!.year} años'),
            Text('Teléfono: ${p.telefono}'),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
