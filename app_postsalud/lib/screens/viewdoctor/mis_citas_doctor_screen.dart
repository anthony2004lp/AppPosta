import 'package:app_postsalud/data/controllers/citas_controller.dart';
import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/dao/especialidades_dao.dart';
import 'package:app_postsalud/data/dao/postas_medicas_dao.dart';
import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/data/entity/especialidades_entity.dart';
import 'package:app_postsalud/data/entity/postas_medicas_entity.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewdoctor/widgetdoctor/app_bar_doctor.dart';
import 'package:flutter/material.dart';

class MisCitasDoctorScreen extends StatefulWidget {
  const MisCitasDoctorScreen({super.key});
  @override
  State<MisCitasDoctorScreen> createState() => _MisCitasDoctorScreenState();
}

class _MisCitasDoctorScreenState extends State<MisCitasDoctorScreen> {
  int? idUsuario;
  late Future<List<CitasEntity>> _futureCitas;
  String userName = 'Médico';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (idUsuario == null) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        idUsuario = args;
        // Aquí ya pasas tu id_usuario, el JOIN hace el resto
        _futureCitas = CitasController.obtenerCitasPorUsuarioMedico(idUsuario!);

        // Opcional: carga nombre del doctor
        UsuariosController.obtenerUsuarioPorId(idUsuario!).then((u) {
          if (u != null && mounted) {
            setState(() {
              userName = u.nombres;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDoctor(userName: userName, title: 'Mis Citas'),
      body: FutureBuilder<List<CitasEntity>>(
        future: _futureCitas,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final citas = snap.data!;
          if (citas.isEmpty) {
            return const Center(child: Text('No tienes citas asignadas.'));
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Hora')),
                DataColumn(label: Text('Paciente')),
                DataColumn(label: Text('Estado')),
              ],
              rows: citas.map((c) {
                return DataRow(
                    onSelectChanged: (_) {
                      _mostrarDetalleCita(context, c);
                    },
                    cells: [
                      DataCell(Text(c.idcita.toString())),
                      DataCell(Text(c.fecha!
                          .toLocal()
                          .toIso8601String()
                          .split('T')
                          .first)),
                      DataCell(Text(c.hora!.format(context))),
                      DataCell(Text(c.idusuario.toString())),
                      DataCell(Text(c.estado ?? '-')),
                    ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }

// Dentro de tu State:
  void _mostrarDetalleCita(BuildContext ctx, CitasEntity cita) {
    final obsController = TextEditingController(text: cita.observaciones ?? '');

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([
            UsuariosController.obtenerUsuarioPorId(
                cita.idusuario!), // [0] paciente
            EspecialidadDao.getNombreforId(
                cita.idespecialidad!), // [1] lista con la especialidad
            PostasMedicasDao.getPostaById(cita.idposta!), // [2] posta
          ]),
          builder: (c, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            // Extraemos resultados
            final paciente = snap.data![0] as UsuariosEntity?;
            final espList = snap.data![1] as List<EspecialidadEntity>;
            final espec = espList.isNotEmpty ? espList.first : null;
            final posta = snap.data![2] as PostasMedicasEntity?;

            String fmtDate(DateTime? d) => d == null
                ? '-'
                : d.toLocal().toIso8601String().split('T').first;
            String fmtTime(TimeOfDay? t) => t == null ? '-' : t.format(ctx);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Detalle de la cita',
                      style: Theme.of(ctx).textTheme.titleLarge),
                  const Divider(),
                  _fila('ID cita', '${cita.idcita ?? '-'}'),
                  _fila(
                      'Paciente',
                      paciente != null
                          ? '${paciente.nombres} ${paciente.apellidos}'
                          : '-'),
                  _fila('Especialidad', espec?.nombre ?? '-'),
                  _fila('Posta', posta?.nombre ?? '-'),
                  _fila('Fecha', fmtDate(cita.fecha)),
                  _fila('Hora', fmtTime(cita.hora)),
                  _fila('Tipo de cita', cita.tipocita ?? '-'),
                  _fila('Estado', cita.estado ?? '-'),
                  _fila('Motivo', cita.motivo ?? '-'),
                  const SizedBox(height: 12),
                  const Text('Observaciones',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  TextField(
                    controller: obsController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Agrega o edita observaciones...',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final nuevo = obsController.text.trim();
                          final ok = await CitasController.guardarObservaciones(
                              cita.idcita!, nuevo);
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(ok
                                  ? 'Observaciones guardadas'
                                  : 'Error al guardar'),
                            ),
                          );
                          if (ok && mounted) {
                            setState(() {
                              // refresca la lista de citas
                              _futureCitas =
                                  CitasController.obtenerCitasPorUsuarioMedico(
                                      idUsuario!);
                            });
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _fila(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$etiqueta: ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(valor)),
        ],
      ),
    );
  }
}
