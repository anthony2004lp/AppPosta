import 'package:app_postsalud/data/controllers/citas_controller.dart';
import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/citas_entity.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ListCitasScreen extends StatefulWidget {
  const ListCitasScreen({super.key});

  @override
  State<ListCitasScreen> createState() => _ListCitasScreenState();
}

class _ListCitasScreenState extends State<ListCitasScreen> {
  late Future<List<CitasEntity>> _citasFuture;
  String userName = 'Administrador'; // Valor por defecto
  UsuariosEntity? usuarioAdmin;

  @override
  void initState() {
    super.initState();
    cargarUsuarioAdmin(); // Llamar la función al iniciar
    _citasFuture = CitasController.obtenerCitas(); // Usar controlador
  }

  void cargarUsuarioAdmin() async {
    List<UsuariosEntity> usuarios =
        await UsuariosController.obtenerUsuariosAdmin();
    if (usuarios.isNotEmpty) {
      setState(() {
        usuarioAdmin = usuarios.first; // Tomar el primer usuario con idRol == 1
        userName = usuarioAdmin!.nombres; // Actualizar userName
      });
    }
  }

  void mostrarFormularioRegistroCita(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController idUsuarioController = TextEditingController();
    final TextEditingController idMedicoController = TextEditingController();
    final TextEditingController idEspecialidadController =
        TextEditingController();
    final TextEditingController fechaController = TextEditingController();
    final TextEditingController horaController = TextEditingController();
    final TextEditingController tipoCitaController = TextEditingController();
    final TextEditingController motivoController = TextEditingController();
    final TextEditingController observacionesController =
        TextEditingController();
    final TextEditingController fechaReprogramadaController =
        TextEditingController();
    final TextEditingController horaReprogramadaController =
        TextEditingController();
    String estadoController = 'pendiente'; // Estado por defecto

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registrar Cita'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(idUsuarioController, 'ID Usuario',
                      keyboardType: TextInputType.number),
                  _buildTextField(idMedicoController, 'ID Médico',
                      keyboardType: TextInputType.number),
                  _buildTextField(idEspecialidadController, 'ID Especialidad',
                      keyboardType: TextInputType.number),
                  _buildTextField(fechaController, 'Fecha (YYYY-MM-DD)',
                      keyboardType: TextInputType.datetime),
                  _buildTextField(horaController, 'Hora (HH:mm)',
                      keyboardType: TextInputType.datetime),
                  _buildTextField(tipoCitaController, 'Tipo de Cita'),
                  DropdownButtonFormField(
                    value: estadoController,
                    items: ['pendiente', 'confirmada', 'cancelada', 'atendida']
                        .map((estado) => DropdownMenuItem(
                            value: estado, child: Text(estado)))
                        .toList(),
                    onChanged: (value) => estadoController = value.toString(),
                    decoration: const InputDecoration(labelText: 'Estado'),
                  ),
                  _buildTextField(motivoController, 'Motivo'),
                  _buildTextField(observacionesController, 'Observaciones'),
                  _buildTextField(fechaReprogramadaController,
                      'Fecha Reprogramada (YYYY-MM-DD)',
                      keyboardType: TextInputType.datetime),
                  _buildTextField(
                      horaReprogramadaController, 'Hora Reprogramada (HH:mm)',
                      keyboardType: TextInputType.datetime),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  CitasEntity nuevaCita = CitasEntity(
                    idcita:
                        0, // Se genera automáticamente en la BD si es AUTO_INCREMENT
                    idusuario: int.tryParse(idUsuarioController.text) ?? 0,
                    idmedico: int.tryParse(idMedicoController.text) ?? 0,
                    idespecialidad:
                        int.tryParse(idEspecialidadController.text) ?? 0,
                    fecha: DateTime.tryParse(fechaController.text) ??
                        DateTime.now(),
                    hora: TimeOfDay(
                      hour:
                          int.tryParse(horaController.text.split(':')[0]) ?? 0,
                      minute:
                          int.tryParse(horaController.text.split(':')[1]) ?? 0,
                    ),
                    tipocita: tipoCitaController.text,
                    estado: estadoController,
                    motivo: motivoController.text,
                    observaciones: observacionesController.text,
                    fechareprogramada:
                        DateTime.tryParse(fechaReprogramadaController.text) ??
                            DateTime.now(),
                    horareprogramada: TimeOfDay(
                      hour: int.tryParse(
                              horaReprogramadaController.text.split(':')[0]) ??
                          0,
                      minute: int.tryParse(
                              horaReprogramadaController.text.split(':')[1]) ??
                          0,
                    ),
                  );

                  CitasController.agregarCita(context, nuevaCita, () {
                    setState(() {
                      _citasFuture = CitasController
                          .obtenerCitas(); // Recargar lista de citas
                    });
                  });
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ingrese $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAdmin(userName: userName, title: 'Lista Citas'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            materialButtonsCitas(context, mostrarFormularioRegistroCita),
            Text('Lista de Citas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: FutureBuilder<List<CitasEntity>>(
                future: _citasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final citas = snapshot.data ?? [];

                  if (citas.isEmpty) {
                    return const Center(
                        child: Text('No hay citas registradas.'));
                  }

                  return ListView.builder(
                    itemCount: citas.length,
                    itemBuilder: (context, index) {
                      final c = citas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ExpansionTile(
                          title: Text('Cita ID: ${c.idcita}'),
                          subtitle: Text(
                            'Usuario: ${c.idusuario} | Médico: ${c.idmedico} | Fecha: ${DateFormat('yyyy-MM-dd').format(c.fecha)}',
                          ),
                          children: [
                            ListTile(
                                title: Text(
                                    'Hora: ${c.hora.hour.toString().padLeft(2, '0')}:${c.hora.minute.toString().padLeft(2, '0')}')),
                            ListTile(
                                title: Text(
                                    'Especialidad ID: ${c.idespecialidad}')),
                            ListTile(
                                title: Text('Tipo de Cita: ${c.tipocita}')),
                            ListTile(title: Text('Estado: ${c.estado}')),
                            ListTile(title: Text('Motivo: ${c.motivo}')),
                            ListTile(
                                title:
                                    Text('Observaciones: ${c.observaciones}')),
                            ListTile(
                                title: Text(
                                    'Fecha Reprogramada: ${DateFormat('yyyy-MM-dd').format(c.fechareprogramada)}')),
                            ListTile(
                                title: Text(
                                    'Hora Reprogramada: ${c.horareprogramada.hour.toString().padLeft(2, '0')}:${c.horareprogramada.minute.toString().padLeft(2, '0')}')),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    final fechaController =
                                        TextEditingController(
                                            text: citas[index]
                                                .fecha
                                                .toLocal()
                                                .toString()
                                                .split('T')
                                                .first);
                                    final horaController =
                                        TextEditingController(
                                            text: citas[index]
                                                .hora
                                                .format(context));
                                    final tipoCitaController =
                                        TextEditingController(
                                            text: citas[index].tipocita);
                                    final motivoController =
                                        TextEditingController(
                                            text: citas[index].motivo);
                                    final observacionesController =
                                        TextEditingController(
                                            text: citas[index].observaciones);
                                    final fechaReprogramadaController =
                                        TextEditingController(
                                            text: citas[index]
                                                .fechareprogramada
                                                .toLocal()
                                                .toString()
                                                .split('T')
                                                .first);
                                    final horaReprogramadaController =
                                        TextEditingController(
                                            text:
                                                '${citas[index].horareprogramada.hour.toString().padLeft(2, '0')}:${citas[index].horareprogramada.minute.toString().padLeft(2, '0')}');
                                    String estadoSeleccionado =
                                        citas[index].estado;
                                    showDialog(
                                        context: context,
                                        builder: (builder) => AlertDialog(
                                              title: Text('Editar Cita'),
                                              content: SingleChildScrollView(
                                                child: Form(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      _buildTextField(
                                                          TextEditingController(
                                                            text: citas[index]
                                                                .fecha
                                                                .toLocal()
                                                                .toString()
                                                                .split('T')
                                                                .first,
                                                          ),
                                                          'Fecha (YYYY-MM-DD)',
                                                          keyboardType:
                                                              TextInputType
                                                                  .datetime),
                                                      _buildTextField(
                                                          TextEditingController(
                                                            text: citas[index]
                                                                .hora
                                                                .format(
                                                                    context),
                                                          ),
                                                          'Hora (HH:mm)',
                                                          keyboardType:
                                                              TextInputType
                                                                  .datetime),
                                                      _buildTextField(
                                                          TextEditingController(
                                                            text: citas[index]
                                                                .tipocita,
                                                          ),
                                                          'Tipo de Cita'),
                                                      _buildTextField(
                                                          TextEditingController(
                                                            text: citas[index]
                                                                .motivo,
                                                          ),
                                                          'Motivo'),
                                                      _buildTextField(
                                                          TextEditingController(
                                                            text: citas[index]
                                                                .observaciones,
                                                          ),
                                                          'Observaciones'),
                                                      _buildTextField(
                                                          TextEditingController(
                                                            text: citas[index]
                                                                .fechareprogramada
                                                                .toLocal()
                                                                .toString()
                                                                .split('T')
                                                                .first,
                                                          ),
                                                          'Fecha Reprogramada (YYYY-MM-DD)',
                                                          keyboardType:
                                                              TextInputType
                                                                  .datetime),
                                                      _buildTextField(
                                                        TextEditingController(
                                                          text:
                                                              '${citas[index].horareprogramada.hour.toString().padLeft(2, '0')}:${citas[index].horareprogramada.minute.toString().padLeft(2, '0')}',
                                                        ),
                                                        'Hora Reprogramada (HH:mm)',
                                                        keyboardType:
                                                            TextInputType
                                                                .datetime,
                                                      ),
                                                      DropdownButtonFormField(
                                                          value: citas[index]
                                                              .estado,
                                                          items: [
                                                            'pendiente',
                                                            'confirmada',
                                                            'cancelada',
                                                            'atendida'
                                                          ]
                                                              .map((estado) =>
                                                                  DropdownMenuItem(
                                                                      value:
                                                                          estado,
                                                                      child: Text(
                                                                          estado)))
                                                              .toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              citas[index]
                                                                      .estado =
                                                                  value
                                                                      .toString();
                                                            });
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'Estado')),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Cancelar'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      citas[index].fecha =
                                                          DateTime.parse(
                                                              fechaController
                                                                  .text);
                                                      final horaPartes =
                                                          horaController.text
                                                              .trim()
                                                              .split(':');
                                                      citas[index].hora =
                                                          TimeOfDay(
                                                        hour: int.parse(
                                                            horaPartes[0]),
                                                        minute: int.parse(
                                                            horaPartes[1]),
                                                      );

                                                      citas[index].tipocita =
                                                          tipoCitaController
                                                              .text;
                                                      citas[index].motivo =
                                                          motivoController.text;
                                                      citas[index]
                                                              .observaciones =
                                                          observacionesController
                                                              .text;
                                                      citas[index]
                                                              .fechareprogramada =
                                                          DateTime.parse(
                                                              fechaReprogramadaController
                                                                  .text);
                                                      final horaRepPartes =
                                                          horaReprogramadaController
                                                              .text
                                                              .split(':');
                                                      citas[index]
                                                              .horareprogramada =
                                                          TimeOfDay(
                                                              hour: int.parse(
                                                                  horaRepPartes[
                                                                      0]),
                                                              minute: int.parse(
                                                                  horaRepPartes[
                                                                      1]));
                                                      citas[index].estado =
                                                          estadoSeleccionado;
                                                    });

                                                    Navigator.pop(
                                                        context); // Cierra el diálogo solo después de actualizar
                                                  },
                                                  child: const Text('Guardar'),
                                                ),
                                              ],
                                            ));
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: Text('editar'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    CitasController.eliminarCita(
                                        context, c.idcita, () {
                                      setState(() {
                                        _citasFuture = CitasController
                                            .obtenerCitas(); // Recargar lista de citas
                                      });
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: Text('Eliminar'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                ),
                              ],
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
      )),
    );
  }
}

Row materialButtonsCitas(
    BuildContext context, void Function(BuildContext) onAgregarCita) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      MaterialButton(
        onPressed: () {
          onAgregarCita(context);
        },
        color: Colors.green,
        child: const Text('Agregar Doctor',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      MaterialButton(
        onPressed: () {},
        color: Colors.blue,
        child: const Text('Imprimir Lista',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    ],
  );
}
