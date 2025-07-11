import 'package:app_postsalud/data/controllers/citas_controller.dart';
import 'package:app_postsalud/data/controllers/postas_medicas_controller.dart';
import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/dao/especialidades_dao.dart';
import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:flutter/material.dart';

class ReservaCitaScreen extends StatefulWidget {
  const ReservaCitaScreen({super.key});

  @override
  State<ReservaCitaScreen> createState() => _ReservaCitaScreenState();
}

class _ReservaCitaScreenState extends State<ReservaCitaScreen> {
  String userName = 'Paciente'; // Valor por defecto
  UsuariosEntity? usuarioPaciente;
  final TextEditingController _searchController = TextEditingController();
  late Future<List<CitasEntity>> _citasFuture;
  Map<int, String> especialidadesMap = {};
  List<CitasEntity> _todasLasCitas = [];
  List<CitasEntity> _citasFiltradas = [];
  late int idPosta;
  String nombrePosta = '';
  String sede = '';
  late int idUsuario;

  bool _argsProcessed = false;

  @override
  void initState() {
    super.initState();
    cargarEspecialidades();
    // Iniciamos con un Future vacío hasta procesar args
    _citasFuture = Future.value([]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_argsProcessed) return;
    _argsProcessed = true;

    // 1) Leemos argumentos una sola vez
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) {
      // Este int es el idPosta que nos enviaste desde el mapa
      idPosta = args;

      // 2) Cargamos info de la posta y ajustamos citas
      _cargarPostaYElegirCitas();
    } else {
      // Si no vino ningún idPosta, mostramos "Todas las postas"
      setState(() {
        nombrePosta = 'Todas las postas';
        sede = '-';
        _citasFuture = CitasController.obtenerCitas();
      });
    }

    // 3) Cargar además el usuario logueado (usa otro argumento)
    //    Asegúrate de que quien navega hacia aquí pase también idUsuario
    final userArgs = ModalRoute.of(context)?.settings.arguments;
    if (userArgs is int) {
      idUsuario = userArgs;
      _loadUserName();
    }
  }

  Future<void> _cargarPostaYElegirCitas() async {
    final posta =
        await PostasMedicasController.obtenerPostaMedicaPorId(idPosta);
    if (posta != null) {
      setState(() {
        nombrePosta = posta.nombre ?? '';
        sede = posta.sede ?? '';
        _citasFuture = CitasController.obtenerCitasPorIdPosta(idPosta);
      });
    } else {
      setState(() {
        nombrePosta = 'Todas las postas';
        sede = '-';
        _citasFuture = CitasController.obtenerCitas();
      });
    }
  }

  Future<void> _loadUserName() async {
    final usuario =
        await UsuariosController.obtenerUsuarioPacienteId(idUsuario);
    if (usuario != null) {
      setState(() {
        userName = usuario.nombres;
      });
    }
  }

  void cargarEspecialidades() async {
    final lista = await EspecialidadDao.getEspecialidades();
    setState(() {
      especialidadesMap = {for (var e in lista) e.idEspecialidad!: e.nombre};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(userName: userName, title: 'Reservar Cita'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
          color: Color.fromRGBO(218, 255, 249, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  color: Color.fromRGBO(218, 255, 249, 1),
                  child: const Text(
                    'Reservar Cita: ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  )),
              Text(
                'Posta: $nombrePosta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              Text(
                'Sede: $sede',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 10),
              Text(
                'Nombre de Especialidad:',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar especialidad',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  setState(() {
                    _citasFiltradas = _todasLasCitas.where((cita) {
                      final nombreEspecialidad =
                          especialidadesMap[cita.idespecialidad]
                                  ?.toLowerCase() ??
                              '';
                      return nombreEspecialidad.contains(query.toLowerCase());
                    }).toList();
                  });
                },
              ),
              SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<CitasEntity>>(
                  future: _citasFuture,
                  builder: (context, snapshot) {
                    if (_todasLasCitas.isEmpty) {
                      final todas = snapshot.data ?? [];
                      _todasLasCitas = todas
                          .where((cita) =>
                              cita.idusuario == null || cita.idusuario == 0)
                          .toList();
                      _citasFiltradas = List.from(_todasLasCitas);
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final citas = _citasFiltradas;

                    if (citas.isEmpty) {
                      return const Center(
                          child: Text('No hay médicos registrados.'));
                    }

                    return ListView.builder(
                      itemCount: citas.length,
                      itemBuilder: (context, index) {
                        final c = citas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ExpansionTile(
                            // leading: CircleAvatar(
                            //   backgroundImage: NetworkImage(m.fotoUrl),
                            // ),
                            title: Text(
                                'Especialidad: ${especialidadesMap[c.idespecialidad] ?? 'No disponible'}'),
                            subtitle: Text(
                              'Fecha: ${c.fecha != null ? "${c.fecha!.day.toString().padLeft(2, '0')}/${c.fecha!.month.toString().padLeft(2, '0')}/${c.fecha!.year}" : "Sin fecha"}'
                              ' | Hora: ${c.hora != null ? "${c.hora!.hour.toString().padLeft(2, '0')}:${c.hora!.minute.toString().padLeft(2, '0')}" : "Sin hora"}',
                            ),
                            children: [
                              // ListTile(title: Text('Estado: ${c.estado}')),
                              ListTile(title: Text('Tipo: ${c.tipocita}')),
                              ListTile(
                                title: Text('Id Posta: ${c.idposta}'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final citaReservada = CitasEntity(
                                    idcita: c.idcita,
                                    idusuario: usuarioPaciente!.idUsuario ?? 0,
                                    idmedico: c.idmedico,
                                    idespecialidad: c.idespecialidad,
                                    fecha: c.fecha,
                                    hora: c.hora,
                                    tipocita: 'Presencial',
                                    estado:
                                        'confirmada', // asegúrate que sea un valor válido del ENUM
                                    motivo: c.motivo,
                                    observaciones: c.observaciones,
                                    fechareprogramada: c.fechareprogramada,
                                    horareprogramada: c.horareprogramada,
                                  );

                                  await CitasController.actualizarCita(
                                    context,
                                    citaReservada,
                                    () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '¡Cita reservada con ID ${c.idcita}!'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text('Confirmar Reserva'),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
