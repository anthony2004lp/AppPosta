import 'package:app_postsalud/data/controllers/medicos_controller.dart';
import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/dao/especialidades_dao.dart';
import 'package:app_postsalud/data/entity/medicos_entity.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewdoctor/widgetdoctor/app_bar_doctor.dart';
import 'package:flutter/material.dart';

class MyPerfilDoctorScreen extends StatefulWidget {
  const MyPerfilDoctorScreen({super.key});
  @override
  _MyPerfilDoctorScreenState createState() => _MyPerfilDoctorScreenState();
}

class _MyPerfilDoctorScreenState extends State<MyPerfilDoctorScreen> {
  int? idUsuario;
  late Future<MedicosEntity?> _futureMedico;
  Map<int, String> especialidadesMap = {};
  String userName = 'Doctor';
  UsuariosEntity? usuarioPaciente;

  @override
  void initState() {
    super.initState();
    _cargarEspecialidades(); // 1) Arranco la carga de todas las especialidades
    cargarUsuarioDoctor();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      idUsuario = ModalRoute.of(context)!.settings.arguments as int;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (idUsuario == null) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        idUsuario = args;
        _futureMedico = MedicosController.obtenerMedicoPorUsuario(idUsuario!);
      } else {
        // Si no vino el ID, podrías hacer un Navigator.pop(context) o mostrar un error
        debugPrint('⚠️ No llegó idUsuario a MyPerfilDoctorScreen');
      }
    }
  }

  void cargarUsuarioDoctor() async {
    final nombre = await UsuariosController.obtenerNombreMedico();
    if (nombre != null) {
      // úsalo directamente
      userName = nombre;
    }
  }

  Future<void> _cargarEspecialidades() async {
    final lista = await EspecialidadDao.getEspecialidades();
    setState(() {
      especialidadesMap = {for (var e in lista) e.idEspecialidad!: e.nombre};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDoctor(
        title: 'Mi Perfil',
        userName:
            userName, // si quieres, lo cargas igual vía UsuariosController
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(186, 237, 229, 1),
            borderRadius: BorderRadius.circular(10)),
        child: FutureBuilder<MedicosEntity?>(
          future: _futureMedico,
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError || snap.data == null) {
              return const Center(child: Text('No se encontró tu perfil'));
            }
            final m = snap.data!;
            final edad = m.fechaNacimiento != null
                ? DateTime.now().year - m.fechaNacimiento!.year
                : null;
            // 4) Busco el nombre de la especialidad en mi Map
            final nombreEspecialidad =
                especialidadesMap[m.idEspecialidad] ?? '---';

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${m.nombres} ${m.apellidos}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (edad != null)
                      Text('Edad: $edad años',
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    Text('DNI: ${m.dni}'),
                    Text('Teléfono: ${m.telefono}'),
                    Text('Especialidad: $nombreEspecialidad'),
                    Text('Consultorio: ${m.direccionConsultorio}'),
                    Text('Ciudad: ${m.ciudad} - ${m.region}'),
                    // Text('Horario: ${m.horarioAtencion}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
