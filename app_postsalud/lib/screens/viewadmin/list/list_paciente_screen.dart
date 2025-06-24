import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/screens/viewadmin/list/image_field.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewadmin/widgetadmin/app_bar_admin.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';

class ListPacienteScreen extends StatefulWidget {
  const ListPacienteScreen({super.key});

  @override
  State<ListPacienteScreen> createState() => _ListPacienteScreenState();
}

class _ListPacienteScreenState extends State<ListPacienteScreen> {
  late Future<List<UsuariosEntity>> _usuariosFuture;
  String userName = 'Administrador'; // Valor por defecto
  UsuariosEntity? usuarioAdmin;

  @override
  void initState() {
    super.initState();
    cargarUsuarioAdmin(); // Llamar la función al iniciar
    _usuariosFuture = UsuariosController.obtenerUsuarios(); // Usar controlador
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

  // Método para mostrar el formulario de registro de pacientes
  void mostrarFormularioRegistro(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nombresController = TextEditingController();
    final TextEditingController apellidosController = TextEditingController();
    final TextEditingController dniController = TextEditingController();
    final TextEditingController telefonoController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController contrasenaController = TextEditingController();
    final TextEditingController direccionController = TextEditingController();
    final TextEditingController fechaNacimientoController =
        TextEditingController();
    String sexoSeleccionado = 'Masculino';
    String estadoSeleccionado = 'activo';
    String fotoUrl = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registrar Paciente'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ImageField(
                  //   imageDefault: '',
                  //   onSelectedImage: (path) {
                  //     setState(() {
                  //       fotoUrl =
                  //           path; // Guardar la ruta de la imagen en fotoUrl
                  //     });
                  //   },
                  // ),
                  _buildTextField(nombresController, 'Nombres'),
                  _buildTextField(apellidosController, 'Apellidos'),
                  _buildTextField(dniController, 'DNI'),
                  _buildTextField(telefonoController, 'Teléfono'),
                  _buildTextField(emailController, 'Email'),
                  _buildTextField(contrasenaController, 'Contraseña',
                      obscureText: true),
                  _buildTextField(direccionController, 'Dirección'),
                  _buildTextField(
                      fechaNacimientoController, 'Fecha de Nacimiento',
                      keyboardType: TextInputType.datetime),
                  DropdownButtonFormField(
                    value: sexoSeleccionado,
                    items: ['Masculino', 'Femenino']
                        .map((sexo) =>
                            DropdownMenuItem(value: sexo, child: Text(sexo)))
                        .toList(),
                    onChanged: (value) => sexoSeleccionado = value.toString(),
                    decoration: const InputDecoration(labelText: 'Sexo'),
                  ),
                  DropdownButtonFormField(
                    value: estadoSeleccionado,
                    items: ['activo', 'inactivo']
                        .map((estado) => DropdownMenuItem(
                            value: estado, child: Text(estado)))
                        .toList(),
                    onChanged: (value) => estadoSeleccionado = value.toString(),
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
                  UsuariosEntity nuevoUsuario = UsuariosEntity(
                    nombres: nombresController.text,
                    apellidos: apellidosController.text,
                    dni: dniController.text,
                    telefono: telefonoController.text,
                    email: emailController.text,
                    contrasena: contrasenaController.text,
                    direccion: direccionController.text,
                    fechaNacimiento:
                        DateTime.tryParse(fechaNacimientoController.text) ??
                            DateTime.now(),
                    sexo: sexoSeleccionado,
                    fotoUrl: fotoUrl, // Guardamos la foto en el modelo
                    idRol: 1,
                    fechaRegistro: DateTime.now(),
                    estado: estadoSeleccionado,
                  );

                  UsuariosController.agregarUsuario(context, nuevoUsuario, () {
                    setState(() {
                      _usuariosFuture = UsuariosController
                          .obtenerUsuarios(); // Recargar lista
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
      appBar: AppBarAdmin(title: 'Lista Pacientes', userName: userName),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            materialButtonsPaciente(context),
            const SizedBox(height: 20),
            Text('Lista de Pacientes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: FutureBuilder<List<UsuariosEntity>>(
                future: _usuariosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay pacientes registrados.'));
                  }

                  List<UsuariosEntity> usuarios =
                      snapshot.data!.where((user) => user.idRol == 1).toList();

                  return ListView.builder(
                    itemCount: usuarios.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ExpansionTile(
                          title: Text(
                              '${usuarios[index].nombres} ${usuarios[index].apellidos}'),
                          subtitle: Text('DNI: ${usuarios[index].dni}'),
                          children: [
                            Text('Teléfono: ${usuarios[index].telefono}'),
                            Text('Email: ${usuarios[index].email}'),
                            Text('Dirección: ${usuarios[index].direccion}'),
                            Text(
                                'Fecha de Nacimiento: ${usuarios[index].fechaNacimiento?.toLocal()}'),
                            Text('Sexo: ${usuarios[index].sexo}'),
                            // Text('Foto URL: ${usuarios[index].fotoUrl}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Editar Paciente'),
                                        content: SingleChildScrollView(
                                          child: Form(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                _buildTextField(
                                                  TextEditingController(
                                                      text: usuarios[index]
                                                          .nombres),
                                                  'Nombres',
                                                ),
                                                _buildTextField(
                                                  TextEditingController(
                                                      text: usuarios[index]
                                                          .apellidos),
                                                  'Apellidos',
                                                ),
                                                _buildTextField(
                                                  TextEditingController(
                                                      text:
                                                          usuarios[index].dni),
                                                  'DNI',
                                                ),
                                                _buildTextField(
                                                  TextEditingController(
                                                      text: usuarios[index]
                                                          .telefono),
                                                  'Teléfono',
                                                ),
                                                _buildTextField(
                                                  TextEditingController(
                                                      text: usuarios[index]
                                                          .email),
                                                  'Email',
                                                ),
                                                _buildTextField(
                                                  TextEditingController(
                                                      text: usuarios[index]
                                                          .direccion),
                                                  'Dirección',
                                                ),
                                                _buildTextField(
                                                  TextEditingController(
                                                      text: usuarios[index]
                                                              .fechaNacimiento
                                                              ?.toLocal()
                                                              .toString() ??
                                                          ''),
                                                  'Fecha de Nacimiento',
                                                  keyboardType:
                                                      TextInputType.datetime,
                                                ),
                                                DropdownButtonFormField(
                                                  value: usuarios[index].sexo ??
                                                      '',
                                                  items: [
                                                    'Masculino',
                                                    'Femenino'
                                                  ]
                                                      .map((sexo) =>
                                                          DropdownMenuItem(
                                                              value: sexo,
                                                              child:
                                                                  Text(sexo)))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    // Actualizar el sexo
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Sexo',
                                                  ),
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
                                            onPressed: () =>
                                                Navigator.pop(context),
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
                                    UsuariosController.eliminarUsuario(
                                        context, usuarios[index].idUsuario!,
                                        () {
                                      setState(() {
                                        _usuariosFuture = UsuariosController
                                            .obtenerUsuarios(); // Recargar lista
                                      });
                                    });
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
    );
  }

  Row materialButtonsPaciente(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MaterialButton(
          onPressed: () {
            mostrarFormularioRegistro(context);
          },
          color: Colors.green,
          child: const Text('Agregar Paciente',
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
}
