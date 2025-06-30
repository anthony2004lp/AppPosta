import 'package:app_postsalud/data/controllers/medicos_controller.dart';
import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/medicos_entity.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListMedicosScreen extends StatefulWidget {
  const ListMedicosScreen({super.key});

  @override
  State<ListMedicosScreen> createState() => _ListMedicosScreenState();
}

class _ListMedicosScreenState extends State<ListMedicosScreen> {
  late Future<List<MedicosEntity>> _medicosFuture;
  String userName = 'Medico'; // Valor por defecto
  UsuariosEntity? usuarioMedico;

  @override
  void initState() {
    super.initState();
    cargarUsuarioAdmin(); // Llamar la función al iniciar
    _medicosFuture = MedicosController.obtenerMedicos();
  }

  void cargarUsuarioAdmin() async {
    List<UsuariosEntity> usuarios =
        await UsuariosController.obtenerUsuariosAdmin();
    if (usuarios.isNotEmpty) {
      setState(() {
        usuarioMedico =
            usuarios.first; // Tomar el primer usuario con idRol == 1
        userName = usuarioMedico!.nombres; // Actualizar userName
      });
    }
  }

  void mostrarFormularioRegistro(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController nombresController = TextEditingController();
    final TextEditingController apellidosController = TextEditingController();
    final TextEditingController dniController = TextEditingController();
    final TextEditingController correoController = TextEditingController();
    final TextEditingController telefonoController = TextEditingController();
    final TextEditingController direccionPersonalController =
        TextEditingController();
    final TextEditingController direccionConsultorioController =
        TextEditingController();
    final TextEditingController ciudadController = TextEditingController();
    final TextEditingController regionController = TextEditingController();
    final TextEditingController horarioAtencionController =
        TextEditingController();
    final TextEditingController fechaNacimientoController =
        TextEditingController();
    final TextEditingController idEspecialidadController =
        TextEditingController();
    final TextEditingController idPostaController = TextEditingController();

    String sexoControler = 'Masculino';
    // String fotoUrl = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registrar Médico'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(nombresController, 'Nombres'),
                  _buildTextField(apellidosController, 'Apellidos'),
                  _buildTextField(
                    dniController,
                    'DNI',
                  ),
                  _buildTextField(correoController, 'Correo'),
                  _buildTextField(telefonoController, 'Teléfono'),
                  _buildTextField(
                      direccionPersonalController, 'Dirección Personal'),
                  _buildTextField(
                      direccionConsultorioController, 'Dirección Consultorio'),
                  _buildTextField(ciudadController, 'Ciudad'),
                  _buildTextField(regionController, 'Región'),
                  _buildTextField(
                      horarioAtencionController, 'Horario de Atención'),
                  _buildTextField(idEspecialidadController, 'ID Especialidad',
                      keyboardType: TextInputType.number),
                  _buildTextField(idPostaController, 'ID Posta',
                      keyboardType: TextInputType.number),
                  _buildTextField(
                      fechaNacimientoController, 'Fecha de Nacimiento',
                      keyboardType: TextInputType.datetime),
                  DropdownButtonFormField(
                    value: sexoControler,
                    items: ['Masculino', 'Femenino']
                        .map((sexo) =>
                            DropdownMenuItem(value: sexo, child: Text(sexo)))
                        .toList(),
                    onChanged: (value) => sexoControler = value.toString(),
                    decoration: const InputDecoration(labelText: 'Sexo'),
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
                if (!_formKey.currentState!.validate()) return;
                MedicosEntity nuevoMedico = MedicosEntity(
                  nombres: nombresController.text,
                  apellidos: apellidosController.text,
                  dni: dniController.text,
                  correo: correoController.text,
                  telefono: telefonoController.text,
                  direccionPersonal: direccionPersonalController.text,
                  direccionConsultorio: direccionConsultorioController.text,
                  ciudad: ciudadController.text,
                  region: regionController.text,
                  horarioAtencion: horarioAtencionController.text,
                  // fotoUrl: fotoUrl,
                  fechaNacimiento:
                      DateTime.tryParse(fechaNacimientoController.text) ??
                          DateTime.now(),
                  sexo: sexoControler,
                  idEspecialidad:
                      int.tryParse(idEspecialidadController.text) ?? 0,
                  idPosta: int.tryParse(idPostaController.text) ?? 0,
                );

                MedicosController.agregarMedico(context, nuevoMedico, () {
                  Navigator.pop(context); // <- cierra el diálogo
                  setState(() {
                    _medicosFuture = MedicosController.obtenerMedicos();
                  });
                });
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
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(labelText: label),
      onTap: onTap,
      validator: (v) =>
          (v == null || v.isEmpty) ? 'Por favor selecciona una fecha' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAdmin(userName: userName, title: 'Lista Médicos'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              materialButtonsDoctor(context, mostrarFormularioRegistro),
              Text('Lista de Medicos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                            title: Text(
                                '${m.nombres} ${m.apellidos},${m.idMedico}'),
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
                                      'Fecha de nacimiento: ${DateFormat('yyyy-MM-dd').format(m.fechaNacimiento ?? DateTime.now())}')),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      final nombresController =
                                          TextEditingController(
                                              text:
                                                  medicos[index].nombres ?? '');
                                      final apellidosController =
                                          TextEditingController(
                                              text: medicos[index].apellidos ??
                                                  '');
                                      final dniController =
                                          TextEditingController(
                                              text: medicos[index].dni ?? '');
                                      final correoController =
                                          TextEditingController(
                                              text:
                                                  medicos[index].correo ?? '');
                                      final telefonoController =
                                          TextEditingController(
                                              text: medicos[index].telefono ??
                                                  '');
                                      final direccionPersonalController =
                                          TextEditingController(
                                              text: medicos[index]
                                                      .direccionPersonal ??
                                                  '');
                                      final direccionConsultorioController =
                                          TextEditingController(
                                              text: medicos[index]
                                                      .direccionConsultorio ??
                                                  '');
                                      final ciudadController =
                                          TextEditingController(
                                              text:
                                                  medicos[index].ciudad ?? '');
                                      final regionController =
                                          TextEditingController(
                                              text:
                                                  medicos[index].region ?? '');
                                      final fechaNacCtrl =
                                          TextEditingController(
                                        text: medicos[index].fechaNacimiento !=
                                                null
                                            ? DateFormat('yyyy-MM-dd').format(
                                                medicos[index].fechaNacimiento!)
                                            : '',
                                      );
                                      final horarioAtencionController =
                                          TextEditingController(
                                              text: medicos[index]
                                                      .horarioAtencion ??
                                                  '');
                                      // final fotoUrlController =
                                      //     TextEditingController(
                                      //         text: medicos[index].fotoUrl);
                                      final idEspecialidadController =
                                          TextEditingController(
                                              text: medicos[index]
                                                      .idEspecialidad
                                                      .toString() ??
                                                  '');
                                      final idPostaController =
                                          TextEditingController(
                                              text: medicos[index]
                                                      .idPosta
                                                      .toString() ??
                                                  '');
                                      String? sexoSeleccionado =
                                          medicos[index].sexo;

                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Editar Médico'),
                                          content: SingleChildScrollView(
                                            child: Form(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  _buildTextField(
                                                      nombresController,
                                                      'Nombres',
                                                      keyboardType:
                                                          TextInputType.text),
                                                  _buildTextField(
                                                      apellidosController,
                                                      'Apellidos',
                                                      keyboardType:
                                                          TextInputType.text),
                                                  _buildTextField(
                                                    dniController,
                                                    'DNI',
                                                    keyboardType:
                                                        TextInputType.text,
                                                  ),
                                                  _buildTextField(
                                                      correoController,
                                                      'Correo',
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress),
                                                  _buildTextField(
                                                      telefonoController,
                                                      'Teléfono',
                                                      keyboardType:
                                                          TextInputType.text),
                                                  _buildTextField(
                                                      direccionPersonalController,
                                                      'Dirección Personal',
                                                      keyboardType:
                                                          TextInputType.text),
                                                  _buildTextField(
                                                      direccionConsultorioController,
                                                      'Dirección Consultorio',
                                                      keyboardType:
                                                          TextInputType.text),
                                                  _buildTextField(
                                                      ciudadController,
                                                      'Ciudad',
                                                      keyboardType:
                                                          TextInputType.text),
                                                  _buildTextField(
                                                      regionController,
                                                      'Región',
                                                      keyboardType:
                                                          TextInputType.text),
                                                  _buildPickerField(
                                                    controller: fechaNacCtrl,
                                                    label:
                                                        'Fecha de Nacimiento',
                                                    onTap: () async {
                                                      // Asegurarte de que initialDate nunca sea null:
                                                      final initial = medicos[
                                                                  index]
                                                              .fechaNacimiento ??
                                                          DateTime.now();
                                                      final picked =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate: initial,
                                                        firstDate: DateTime
                                                                .now()
                                                            .subtract(
                                                                const Duration(
                                                                    days: 365)),
                                                        lastDate: DateTime.now()
                                                            .add(const Duration(
                                                                days: 365)),
                                                      );
                                                      if (picked != null) {
                                                        // Formateas y actualizas el controller:
                                                        fechaNacCtrl
                                                            .text = DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(picked);
                                                      }
                                                    },
                                                  ),
                                                  _buildTextField(
                                                    horarioAtencionController,
                                                    'Horario de Atención',
                                                  ),
                                                  _buildTextField(
                                                    idEspecialidadController,
                                                    'ID Especialidad',
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                  _buildTextField(
                                                    idPostaController,
                                                    'ID Posta',
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                  DropdownButtonFormField(
                                                    value: sexoSeleccionado,
                                                    items: [
                                                      'Masculino',
                                                      'Femenino',
                                                    ]
                                                        .map((sexo) =>
                                                            DropdownMenuItem(
                                                                value: sexo,
                                                                child:
                                                                    Text(sexo)))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      sexoSeleccionado =
                                                          value.toString();
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: 'Sexo'),
                                                  ),
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
                                                final medicoModificado =
                                                    MedicosEntity(
                                                  idMedico:
                                                      medicos[index].idMedico,
                                                  nombres:
                                                      nombresController.text,
                                                  apellidos:
                                                      apellidosController.text,
                                                  dni: dniController.text,
                                                  correo: correoController.text,
                                                  telefono:
                                                      telefonoController.text,
                                                  direccionPersonal:
                                                      direccionPersonalController
                                                          .text,
                                                  direccionConsultorio:
                                                      direccionConsultorioController
                                                          .text,
                                                  ciudad: ciudadController.text,
                                                  region: regionController.text,
                                                  horarioAtencion:
                                                      horarioAtencionController
                                                          .text,
                                                  // fotoUrl:
                                                  //     fotoUrlController.text,
                                                  fechaNacimiento:
                                                      DateTime.tryParse(
                                                          fechaNacCtrl.text),
                                                  sexo: sexoSeleccionado,
                                                  idEspecialidad: int.tryParse(
                                                          idEspecialidadController
                                                              .text) ??
                                                      0,
                                                  idPosta: int.tryParse(
                                                          idPostaController
                                                              .text) ??
                                                      0,
                                                );
                                                MedicosController
                                                        .actualizarMedico(
                                                            medicoModificado)
                                                    .then((_) {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _medicosFuture =
                                                        MedicosController
                                                            .obtenerMedicos();
                                                  });
                                                });
                                              },
                                              child: const Text('Guardar'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Editar'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      MedicosController.eliminarMedico(
                                        context,
                                        medicos[index].idMedico!,
                                        () {
                                          setState(() {
                                            _medicosFuture = MedicosController
                                                .obtenerMedicos(); // Recargar lista
                                          });
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                    label: const Text('Eliminar'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                  ),
                                ],
                              ),
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

Row materialButtonsDoctor(
    BuildContext context, void Function(BuildContext) onAgregarMedico) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      MaterialButton(
        onPressed: () {
          onAgregarMedico(context);
        },
        color: Colors.green,
        child: const Text('Agregar Medico',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      // MaterialButton(
      //   onPressed: () {},
      //   color: Colors.blue,
      //   child: const Text('Imprimir Lista',
      //       style: TextStyle(color: Colors.white, fontSize: 18)),
      // ),
    ],
  );
}
