import 'package:app_postsalud/data/controllers/medicos_controller.dart';
import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/dao/medicos_dao.dart';
import 'package:app_postsalud/data/entity/medicos_entity.dart';
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
  late Future<List<MedicosEntity>> _medicosFuture;

  void _buscarMedicoPorNombre() async {
    final texto = _searchController.text.trim();
    if (texto.isEmpty) return;

    final partes = texto.split(' ');
    if (partes.length < 2) {
      print('Por favor ingresa nombre y apellido');
      return;
    }
    final medico = MedicosEntity(
      nombres: partes.sublist(0, partes.length - 1).join(' '),
      apellidos: partes.last,
    );

    try {
      final resultado = await MedicosDao.searchNameMedico(medico);
      print('Médico encontrado: ${resultado.nombres} ${resultado.apellidos}');
      // Aquí puedes usar setState o navegar a otra pantalla
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _medicosFuture = MedicosController.obtenerMedicosPorPosta(1);
    cargarUsuarioPaciente(); // Llamar la función al iniciar
  }

  void cargarUsuarioPaciente() async {
    List<UsuariosEntity> usuarios =
        await UsuariosController.obtenerUsuariosPaciente();
    if (usuarios.isNotEmpty) {
      setState(() {
        usuarioPaciente = usuarios.first;
        userName = usuarioPaciente!.nombres; // Actualizar userName
      });
    }
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
                    'Reservar Cita',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  )),
              const Text(
                'Sede: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 10),
              Text(
                'Nombre del Medico:',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Nombre y Apellido',
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (_) => _buscarMedicoPorNombre(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<MedicosEntity>>(
                  future: _medicosFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final medicos = snapshot.data ?? [];

                    if (medicos.isEmpty) {
                      return const Center(
                          child: Text('No hay médicos registrados.'));
                    }

                    return ListView.builder(
                      itemCount: medicos.length,
                      itemBuilder: (context, index) {
                        final m = medicos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ExpansionTile(
                            // leading: CircleAvatar(
                            //   backgroundImage: NetworkImage(m.fotoUrl),
                            // ),
                            title: Text('${m.nombres} ${m.apellidos}'),
                            subtitle: Text(
                                'DNI: ${m.dni} | Especialidad: ${m.idEspecialidad}'),
                            children: [
                              ListTile(title: Text('Correo: ${m.correo}')),
                              ListTile(title: Text('Teléfono: ${m.telefono}')),
                              ListTile(
                                  title: Text(
                                      'Dirección personal: ${m.direccionPersonal}')),
                              ListTile(
                                  title: Text(
                                      'Fecha de nacimiento: ${m.fechaNacimiento?.toLocal()}')),
                              ListTile(title: Text('Sexo: ${m.sexo}')),
                              ListTile(
                                  title: Text(
                                      'Dirección consultorio: ${m.direccionConsultorio}')),
                              ListTile(title: Text('Ciudad: ${m.ciudad}')),
                              ListTile(title: Text('Región: ${m.region}')),
                              ListTile(
                                  title: Text(
                                      'Horario de atención: ${m.horarioAtencion}')),
                              ListTile(title: Text('ID Posta: ${m.idPosta}')),
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
