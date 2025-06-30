import 'package:app_postsalud/data/controllers/postas_medicas_controller.dart';
import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/dao/citas_dao.dart';
import 'package:app_postsalud/data/dao/especialidades_dao.dart';
import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:flutter/material.dart';

class MyCitasScreen extends StatefulWidget {
  const MyCitasScreen({super.key});

  @override
  State<MyCitasScreen> createState() => _MyCitasScreenState();
}

class _MyCitasScreenState extends State<MyCitasScreen> {
  late int idUsuario;
  Future<List<CitasEntity>> _futureCitas = Future.value([]);
  String userName = 'Paciente';
  UsuariosEntity? usuarioPaciente;
  Map<int, String> especialidadesMap = {};
  String nombrePosta = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      idUsuario = ModalRoute.of(context)!.settings.arguments as int;
      cargarEspecialidadesYCitas(idUsuario);
    });
  }

  void cargarEspecialidadesYCitas(int idUsuario) async {
    final lista = await EspecialidadDao.getEspecialidades();
    final posta = await PostasMedicasController.obtenerPostaMedicaPorId(1);
    UsuariosEntity? user =
        await UsuariosController.obtenerUsuarioPacienteId(idUsuario);
    if (user != null) {
      // úsalo directamente
      userName = user.nombres;
    }

    setState(() {
      especialidadesMap = {
        for (var esp in lista) esp.idEspecialidad!: esp.nombre,
      };
      _futureCitas = CitasDao.getCitasPorUsuario(user?.idUsuario ?? 0);
    });

    if (posta != null) {
      setState(() {
        nombrePosta = posta.nombre ?? 'Posta Médica';
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
              ],
              rows: citas.map((cita) {
                return DataRow(
                  onSelectChanged: (_) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Detalle de cita',
                                style: Theme.of(context).textTheme.titleLarge),
                            const Divider(),
                            Text('Posta Médica: $nombrePosta',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(
                                'Fecha: ${cita.fecha!.toLocal().toIso8601String().split("T").first}'),
                            Text(
                                'Hora: ${cita.hora!.hour.toString().padLeft(2, '0')}:${cita.hora!.minute.toString().padLeft(2, '0')}'),
                            Text('Médico ID: ${cita.idmedico}'),
                            Text(
                                'ID ${cita.idespecialidad} - Especialidad: ${especialidadesMap[cita.idespecialidad] ?? 'Desconocida'}'),
                            Text('Tipo: ${cita.tipocita}'),
                            Text('Estado: ${cita.estado}'),
                            const SizedBox(height: 8),
                            Text(
                              'Reprogramada para: ${cita.fechareprogramada?.toLocal().toIso8601String().split("T").first ?? '-'} a las ${cita.horareprogramada?.hour.toString().padLeft(2, '0')}:${cita.horareprogramada?.minute.toString().padLeft(2, '0')}',
                            ),
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
