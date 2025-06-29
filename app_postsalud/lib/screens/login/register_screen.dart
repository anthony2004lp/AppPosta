import 'dart:developer';

import 'package:app_postsalud/data/dao/usuarios_dao.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/input_decoration.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  String sexoSeleccionado = 'Masculino';

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
    List<Widget> formFields = registerFields(context);
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

  List<Widget> registerFields(BuildContext context) {
    return [
      textFormFieldName(),
      const SizedBox(height: 10),
      textFormFieldLastName(),
      const SizedBox(height: 10),
      textFormFieldDni(),
      const SizedBox(height: 10),
      textFormFieldPhone(),
      const SizedBox(height: 10),
      textFormFieldEmail(),
      const SizedBox(height: 10),
      textFormFieldDireccion(),
      const SizedBox(height: 10),
      textFormFieldFechaNacimiento(),
      const SizedBox(height: 10),
      dropdownSexo(),
      const SizedBox(height: 10),
      // textFormFieldFoto(),
      textFormFieldPassword(),
      const SizedBox(height: 10),
      buttonRegistrarse(context),
      const SizedBox(
        height: 10,
      ),
      MaterialButton(
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Color.fromRGBO(193, 193, 192, 1),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'login');
        },
        child: Text(
          'Volver',
        ),
      )
    ];
  }

  TextFormField textFormFieldPhone() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.name,
      autocorrect: false,
      decoration: InputDecorations.inputDecoration(
          hintText: "945487582",
          labelText: "Telefono",
          icono: Icon(Icons.phone)),
    );
  }

  TextFormField textFormFieldDni() {
    return TextFormField(
      keyboardType: TextInputType.number,
      autocorrect: false,
      controller: dniController,
      validator: (value) {
        //AGREGAR VALIDADOR DE DNI
        return (value != null && value.length > 8) ? null : 'Dni invalido';
      },
      decoration: InputDecorations.inputDecoration(
          hintText: "84848484", labelText: "DNI", icono: Icon(Icons.badge)),
    );
  }

  TextFormField textFormFieldLastName() {
    return TextFormField(
      controller: lastNameController,
      keyboardType: TextInputType.name,
      autocorrect: false,
      decoration: InputDecorations.inputDecoration(
          hintText: "Apellido",
          labelText: "Apellido",
          icono: Icon(Icons.person)),
    );
  }

  TextFormField textFormFieldName() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecorations.inputDecoration(
        hintText: "Nombre",
        labelText: "Nombre",
        icono: Icon(Icons.person),
      ),
    );
  }

  TextFormField textFormFieldFechaNacimiento() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.datetime,
      decoration: InputDecorations.inputDecoration(
        hintText: "DD/MM/AAAA",
        labelText: "Fecha de Nacimiento",
        icono: Icon(Icons.location_on),
      ),
    );
  }

  TextFormField textFormFieldDireccion() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecorations.inputDecoration(
        hintText: "Av. Siempre Viva 123",
        labelText: "Direccion",
        icono: Icon(Icons.location_on),
      ),
    );
  }

  DropdownButtonFormField<String> dropdownSexo() {
    return DropdownButtonFormField<String>(
        value: sexoSeleccionado,
        items: const [
          DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
          DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
          DropdownMenuItem(value: 'Otro', child: Text('Otro')),
        ],
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              sexoSeleccionado = newValue;
            });
          }
        },
        decoration: InputDecorations.inputDecoration(
            labelText: 'Sexo',
            icono: const Icon(Icons.male),
            hintText: 'jjjn'));
  }

  // Automatizar la fecha de registro de los usuarios

  TextFormField textFormFieldEmail() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //Habilita el arroba en el teclado
      validator: (value) {
        //Validacion de email
        return (value != null && value.contains('@'))
            ? null
            : 'El email debe contener un @';
      },
      autocorrect: false,
      decoration: InputDecorations.inputDecoration(
        hintText: 'example@gmail.com',
        labelText: 'Email',
        icono: const Icon(Icons.email),
      ),
    );
  }

  TextFormField textFormFieldPassword() {
    return TextFormField(
      controller: passwordController,
      validator: (value) {
        //Validacion de contra
        return (value != null && value.length >= 6)
            ? null
            : 'La contraseña debe ser mas de 5 caracteres';
      },
      autocorrect: false,
      decoration: InputDecorations.inputDecoration(
        hintText: '******',
        labelText: 'Contraseña',
        icono: const Icon(Icons.password),
      ),
    );
  }

  TextButton buttonRegistrarse(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(Color.fromRGBO(40, 157, 137, 1)),
      ),
      onPressed: () async {
        UsuariosEntity nuevoUsuario = UsuariosEntity(
          nombres: nameController.text.trim(),
          apellidos: lastNameController.text.trim(),
          dni: dniController.text.trim(),
          telefono: phoneController.text.trim(),
          email: emailController.text.trim(),
          contrasena: passwordController.text.trim(),
          direccion: direccionController.text
              .trim(), // Puedes agregar un campo de dirección si lo necesitas
          fechaNacimiento: DateTime.now(), // Ajusta según tu lógica
          sexo: sexoSeleccionado, // Puedes agregar un campo de selección
          fotoUrl: "",
          idRol: 1, // Define el rol según tu lógica
          estado: "Activo", // Estado activo
          fechaRegistro: DateTime.now(), // Estado activo
        );

        await UsuariosDao.insertUsuario(nuevoUsuario);
        log("Usuario registrado correctamente: ${nuevoUsuario.fechaRegistro}");

        // Redirigir al usuario después del registro
        Navigator.pushReplacementNamed(context, 'login');
      },
      child: Text(
        'Registrarse',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
        ),
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
}
