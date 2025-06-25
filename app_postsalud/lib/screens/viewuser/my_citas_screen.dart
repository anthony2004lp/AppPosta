import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/dao/citas_dao.dart';
import 'package:app_postsalud/data/dao/especialidades_dao.dart';
import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:flutter/material.dart';

class MyCitasScreen extends StatefulWidget {
  const MyCitasScreen({super.key});

  @override
  State<MyCitasScreen> createState() => _MyCitasScreenState();
}

class _MyCitasScreenState extends State<MyCitasScreen> {
  Future<List<CitasEntity>> _futureCitas = Future.value([]);
  String userName = 'Paciente'; // Valor por defecto
  UsuariosEntity? usuarioPaciente;
  Map<int, String> especialidadesMap = {};

  @override
  void initState() {
    super.initState();
    cargarEspecialidadesYCitas();
  }

  void cargarEspecialidadesYCitas() async {
    final lista = await EspecialidadDao.getEspecialidades();
    final usuarios = await UsuariosController.obtenerUsuariosPaciente();

    if (usuarios.isNotEmpty) {
      final user = usuarios.first;

      setState(() {
        usuarioPaciente = user;
        userName = user.nombres;
        especialidadesMap = {
          for (var esp in lista) esp.idEspecialidad!: esp.nombre
        };
        _futureCitas = CitasDao.getCitasPorUsuario(user.idUsuario!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(
        userName: userName,
        title: 'Mis citas',
      ),
      body: FutureBuilder<List<CitasEntity>>(
        future: _futureCitas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final citas = snapshot.data ?? [];
          if (citas.isEmpty) {
            return const Center(child: Text('No hay citas reservadas.'));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Hora')),
                DataColumn(label: Text('Médico')),
                // DataColumn(label: Text('Especialidad')),
                // DataColumn(label: Text('Estado')),
              ],
              rows: citas.map((cita) {
                return DataRow(
                  onSelectChanged: (_) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 16, top: 16, bottom: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Detalle de cita',
                                style: Theme.of(context).textTheme.titleLarge),
                            const Divider(),
                            Text(
                                'Fecha: ${cita.fecha!.toLocal().toIso8601String().split("T").first}'),
                            Text(
                                'Hora: ${cita.hora!.hour.toString().padLeft(2, '0')}:${cita.hora!.minute.toString().padLeft(2, '0')}'),
                            Text('Médico ID: ${cita.idmedico}'),
                            Text(
                              'ID ${cita.idespecialidad} - Especialidad: ${especialidadesMap[cita.idespecialidad] ?? 'Desconocida'}',
                            ),
                            Text('Tipo: ${cita.tipocita}'),
                            Text('Estado: ${cita.estado}'),
                            Text('Motivo: ${cita.motivo ?? '-'}'),
                            Text('Observaciones: ${cita.observaciones}'),
                            const SizedBox(height: 8),
                            Text(
                                'Reprogramada para: ${cita.fechareprogramada?.toLocal().toIso8601String().split("T").first ?? '-'} a las ${cita.horareprogramada?.hour.toString().padLeft(2, '0')}:${cita.horareprogramada?.minute.toString().padLeft(2, '0')}'),
                          ],
                        ),
                      ),
                    );
                  },
                  cells: [
                    DataCell(Text(cita.fecha!
                        .toLocal()
                        .toIso8601String()
                        .split('T')
                        .first)),
                    DataCell(Text(
                        '${cita.hora?.hour}:${cita.hora?.minute.toString().padLeft(2, '0')}')),
                    DataCell(Text('ID ${cita.idmedico}')),
                    // DataCell(Text('ID ')),
                    // DataCell(Text('.......')),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
