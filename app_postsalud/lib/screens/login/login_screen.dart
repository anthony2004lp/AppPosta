import 'dart:developer';
import 'package:app_postsalud/data/dao/usuarios_dao.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/login/register_screen.dart';
// import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController dniController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedButton = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //Contiene a todos los widgets
      body: Container(
        color: Color.fromRGBO(218, 255, 249, 1),
        child: SizedBox(
          height: double.infinity, //Ocupa toda la altura
          width: double.infinity, //Ocupa todo el ancho
          child: Stack(
            //Conjunto de widgets, Uno encima de otro
            children: [
              headerlogin(size), //Encabezado del login
              // iconopersona(), //Icono
              loginForm(context), //Form de login
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    List<Widget> formFields = loginFields(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              // height: 250,
              margin: const EdgeInsets.symmetric(horizontal: 35),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    // offset: Offset(0, 2)
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Bienvenida(o) \n   a MiPosta ',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: formFields,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> loginFields(BuildContext context) {
    return [
      ingresarRegistrar(context),
      const SizedBox(height: 20),
      textFormFieldDni(),
      const SizedBox(height: 25),
      textFormFieldPassword(),
      const SizedBox(height: 20),
      buttonIngresar(context, dniController, passwordController),
      const SizedBox(height: 25),
      forgotPassword()
    ];
  }

  Container forgotPassword() {
    return Container(
      margin: EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Text(
            'Olvidaste tu contraseña?',
            style: TextStyle(fontSize: 10, color: Colors.black54),
          ),
          buttonForgotPassword(),
        ],
      ),
    );
  }

  Container ingresarRegistrar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16), // Espaciado interno
      child: ToggleButtons(
        borderRadius:
            BorderRadius.circular(20), // Bordes redondeados en los botones
        fillColor:
            Color.fromRGBO(40, 157, 137, 1), // Fondo del botón seleccionado
        selectedColor: Colors.white, // Color del texto del botón seleccionado
        color: Colors.black, // Color del texto cuando no está seleccionado
        borderColor: Colors.grey, // Borde del botón
        selectedBorderColor: Colors.green, // Borde del botón seleccionado
        isSelected: [
          selectedButton == 'Ingresar',
          selectedButton == 'Registrarse'
        ], // Estado de selección
        onPressed: (index) {
          setState(() {
            selectedButton = index == 0
                ? 'Ingresar'
                : 'Registrarse'; // Cambia el botón seleccionado
          });
          if (index == 1) {
            // Si el botón seleccionado es "Registrarse"
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ),
            );
          }
        },
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Ingresar"), // Texto del primer botón
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Registrarse"), // Texto del segundo botón
          ),
        ],
      ),
    );
  }

  TextButton buttonForgotPassword() {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'forgotpassword');
      },
      child: Text(
        'Ingresa aquí',
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }

  TextFormField textFormFieldDni() {
    return TextFormField(
      controller: dniController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'DNI',
        labelText: 'Usuario',
        icon: const Icon(Icons.badge_outlined),
      ),
    );
  }

  TextFormField textFormFieldPassword() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: '******',
        labelText: 'Contraseña',
        icon: const Icon(Icons.lock_open),
      ),
    );
  }

  MaterialButton buttonIngresar(
    BuildContext context,
    TextEditingController dniController,
    TextEditingController passwordController,
  ) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.amber,
      onPressed: () async {
        String dni = dniController.text.trim();
        String contrasena = passwordController.text.trim();

        log("DNI capturado antes de consulta: '$dni'");
        log("Contraseña capturada antes de consulta: '$contrasena'");

        if (dni.isEmpty || contrasena.isEmpty) {
          log("Error: Alguno de los campos está vacío.");
          _mostrarDialogoError(context, "Debes ingresar DNI y contraseña.");
          return;
        }

        try {
          final usuarios =
              await UsuariosDao.getUsuariosByCredentials(dni, contrasena);

          if (usuarios != null) {
            log("Usuario encontrado: ${usuarios.nombres}");
            int idRol = usuarios.idRol;

            switch (idRol) {
              case 1:
                Navigator.pushReplacementNamed(
                  context,
                  'homeuser',
                  arguments: usuarios.idUsuario,
                );
                break;
              case 2:
                Navigator.pushReplacementNamed(
                  context,
                  'homedoctor',
                  arguments: usuarios.idUsuario,
                );
                break;
              case 3:
                Navigator.pushReplacementNamed(
                  context,
                  'homeadmin',
                  arguments: usuarios.idUsuario,
                );
                break;
              default:
                log("Rol no reconocido: $idRol");
                _mostrarDialogoError(context, "Tu rol no está registrado.");
            }
          } else {
            log("Credenciales incorrectas");
            _mostrarDialogoError(context, "DNI o contraseña incorrectos.");
          }
        } catch (e, stackTrace) {
          log("🔴 Error inesperado en login: $e\n$stackTrace");
          _mostrarDialogoError(
              context, "Ha ocurrido un error. Intenta nuevamente.");
        }
      },
      color: const Color.fromRGBO(40, 157, 137, 1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: const Text(
          'Ingresar',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  void _mostrarDialogoError(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error de autenticación'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  SafeArea headerlogin(Size size) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/fondoLogin.png'),
                fit: BoxFit.fill)),
        width: double.infinity,
        height: size.height * 0.4,
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.1),
      ),
    );
  }
}
