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
    final TextEditingController idMedicoController = TextEditingController();
    final TextEditingController idEspecialidadController =
        TextEditingController();
    final TextEditingController fechaController = TextEditingController();
    final TextEditingController horaController = TextEditingController();
    final TextEditingController tipoCitaController = TextEditingController();
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
                    idcita: 0,
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

  Widget _buildPickerField({
    required TextEditingController controller,
    required String label,
    required VoidCallback onTap,
    TextInputType keyboardType = TextInputType.datetime,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: onTap,
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
                            'Usuario: ${c.idusuario} | Médico: ${c.idmedico} | Fecha: ${DateFormat('yyyy-MM-dd').format(c.fecha ?? DateTime.now())}',
                          ),
                          children: [
                            ListTile(
                                title: Text(
                                    'Hora: ${c.hora?.hour.toString().padLeft(2, '0')}:${c.hora?.minute.toString().padLeft(2, '0')}')),
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
                                    'Fecha Reprogramada: ${DateFormat('yyyy-MM-dd').format(c.fechareprogramada ?? DateTime.now())}')),
                            ListTile(
                                title: Text(
                                    'Hora Reprogramada: ${c.horareprogramada?.hour.toString().padLeft(2, '0')}:${c.horareprogramada?.minute.toString().padLeft(2, '0')}')),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    final idMedicoController =
                                        TextEditingController(
                                      text: citas[index].idmedico?.toString() ??
                                          '',
                                    );
                                    final idEspecialidadController =
                                        TextEditingController(
                                      text: citas[index]
                                              .idespecialidad
                                              ?.toString() ??
                                          '',
                                    );
                                    // Fecha cita en YYYY-MM-DD
                                    final fechaController =
                                        TextEditingController(
                                      text: citas[index].fecha != null
                                          ? DateFormat('yyyy-MM-dd').format(
                                              citas[index].fecha!.toLocal())
                                          : '',
                                    );
                                    // Hora cita en HH:mm (24 h)
                                    final horaController =
                                        TextEditingController(
                                      text: citas[index].hora != null
                                          ? '${citas[index].hora!.hour.toString().padLeft(2, '0')}:'
                                              '${citas[index].hora!.minute.toString().padLeft(2, '0')}'
                                          : '',
                                    );
                                    // Tipo de cita
                                    final tipoCitaController =
                                        TextEditingController(
                                      text: citas[index].tipocita ?? '',
                                    );
                                    // Fecha reprogramada en YYYY-MM-DD (puede ser null)
                                    final fechaReprogramadaController =
                                        TextEditingController(
                                      text:
                                          citas[index].fechareprogramada != null
                                              ? DateFormat('yyyy-MM-dd').format(
                                                  citas[index]
                                                      .fechareprogramada!
                                                      .toLocal())
                                              : '',
                                    );
                                    // Hora reprogramada en HH:mm (24 h, puede ser null)
                                    final horaReprogramadaController =
                                        TextEditingController(
                                      text: citas[index].horareprogramada !=
                                              null
                                          ? '${citas[index].horareprogramada!.hour.toString().padLeft(2, '0')}:'
                                              '${citas[index].horareprogramada!.minute.toString().padLeft(2, '0')}'
                                          : '',
                                    );

                                    String? estadoSeleccionado =
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
                                                          idMedicoController,
                                                          'ID Médico',
                                                          keyboardType:
                                                              TextInputType
                                                                  .number),
                                                      _buildTextField(
                                                          idEspecialidadController,
                                                          'ID Especialidad',
                                                          keyboardType:
                                                              TextInputType
                                                                  .number),
                                                      _buildPickerField(
                                                          controller:
                                                              fechaController,
                                                          label:
                                                              'Fecha (YYYY-MM-DD)',
                                                          onTap: () async {
                                                            final picked =
                                                                await showDatePicker(
                                                              context: context,
                                                              initialDate: citas[
                                                                          index]
                                                                      .fecha ??
                                                                  DateTime
                                                                      .now(),
                                                              firstDate: DateTime
                                                                      .now()
                                                                  .subtract(
                                                                      const Duration(
                                                                          days:
                                                                              365)),
                                                              lastDate: DateTime
                                                                      .now()
                                                                  .add(const Duration(
                                                                      days:
                                                                          365)),
                                                            );
                                                            if (picked !=
                                                                null) {
                                                              fechaController
                                                                  .text = DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(
                                                                      picked);
                                                            }
                                                          }),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      _buildPickerField(
                                                          controller:
                                                              horaController,
                                                          label: 'Hora (HH:mm)',
                                                          onTap: () async {
                                                            final picked =
                                                                await showTimePicker(
                                                              context: context,
                                                              initialTime: citas[
                                                                          index]
                                                                      .hora ??
                                                                  TimeOfDay
                                                                      .now(),
                                                            );
                                                            if (picked !=
                                                                null) {
                                                              horaController
                                                                      .text =
                                                                  picked.format(
                                                                      context);
                                                            }
                                                          }),
                                                      _buildTextField(
                                                          TextEditingController(
                                                            text: citas[index]
                                                                .tipocita,
                                                          ),
                                                          'Tipo de Cita'),
                                                      _buildTextField(
                                                          TextEditingController(
                                                            text: citas[index]
                                                                        .fechareprogramada !=
                                                                    null
                                                                ? DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(citas[
                                                                            index]
                                                                        .fechareprogramada!)
                                                                : '',
                                                          ),
                                                          'Fecha Reprogramada (YYYY-MM-DD)',
                                                          keyboardType:
                                                              TextInputType
                                                                  .datetime),
                                                      _buildTextField(
                                                        TextEditingController(
                                                          text:
                                                              '${citas[index].horareprogramada?.hour.toString().padLeft(2, '0')}:${citas[index].horareprogramada?.minute.toString().padLeft(2, '0')}',
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
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    // 1) Lee y asigna en tu objeto cita
                                                    citas[index].idmedico =
                                                        int.parse(
                                                            idMedicoController
                                                                .text);
                                                    citas[index]
                                                            .idespecialidad =
                                                        int.parse(
                                                            idEspecialidadController
                                                                .text);
                                                    citas[index].fecha =
                                                        DateTime.parse(
                                                            fechaController
                                                                .text);
                                                    final partsHora =
                                                        horaController.text
                                                            .split(':');
                                                    citas[index].hora =
                                                        TimeOfDay(
                                                      hour: int.parse(
                                                          partsHora[0]),
                                                      minute: int.parse(
                                                          partsHora[1]),
                                                    );
                                                    citas[index].tipocita =
                                                        tipoCitaController.text;
                                                    citas[index]
                                                            .fechareprogramada =
                                                        fechaReprogramadaController
                                                                .text.isEmpty
                                                            ? null
                                                            : DateTime.parse(
                                                                fechaReprogramadaController
                                                                    .text);
                                                    citas[index]
                                                            .horareprogramada =
                                                        horaReprogramadaController
                                                                .text.isEmpty
                                                            ? null
                                                            : TimeOfDay(
                                                                hour: int.parse(
                                                                    horaReprogramadaController
                                                                        .text
                                                                        .split(
                                                                            ':')[0]),
                                                                minute: int.parse(
                                                                    horaReprogramadaController
                                                                        .text
                                                                        .split(
                                                                            ':')[1]),
                                                              );
                                                    citas[index].estado =
                                                        estadoSeleccionado;

                                                    // 2) Llama al controller
                                                    final ok = await CitasController
                                                        .actualizarCitaDetalles(
                                                            citas[index]);

                                                    // 3) Cierra diálogo y notifica
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          ok
                                                              ? 'Cita actualizada correctamente'
                                                              : 'Error al actualizar cita',
                                                        ),
                                                      ),
                                                    );

                                                    // 4) Si salió todo OK, refresca la lista
                                                    if (ok && mounted) {
                                                      setState(() {
                                                        _citasFuture =
                                                            CitasController
                                                                .obtenerCitas();
                                                      });
                                                    }
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
                                        context, c.idcita!, () {
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
        child: const Text('Agregar Cita',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    ],
  );
}
