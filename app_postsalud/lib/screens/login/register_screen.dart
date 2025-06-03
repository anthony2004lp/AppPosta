import 'package:flutter/material.dart';
import 'package:app_postsalud/widgets/input_decoration.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
      const SizedBox(height: 20),
      textFormFieldLastName(),
      const SizedBox(height: 20),
      textFormFieldDni(),
      const SizedBox(height: 20),
      textFormFieldPhone(),
      const SizedBox(height: 20),
      textFormFieldEmail(),
      const SizedBox(height: 25),
      textFormFieldPassword(),
      const SizedBox(height: 25),
      buttonRegistrarse(),
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
      decoration: InputDecorations.inputDecoration(
          hintText: "84848484", labelText: "DNI", icono: Icon(Icons.badge)),
    );
  }

  TextFormField textFormFieldLastName() {
    return TextFormField(
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
      keyboardType: TextInputType.name,
      autocorrect: false,
      decoration: InputDecorations.inputDecoration(
          hintText: "Nombre", labelText: "Nombre", icono: Icon(Icons.person)),
    );
  }

  TextButton buttonRegistrarse() {
    return TextButton(
      style: ButtonStyle(
          backgroundColor:
              WidgetStatePropertyAll(Color.fromRGBO(40, 157, 137, 1))),
      onPressed: () {},
      child: Text(
        'Registrarse',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
        ),
      ),
    );
  }

  TextFormField textFormFieldEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      //Habilita el arroba en el teclado
      validator: (value) {
        //AGREGAR VALIDADOR DE DNI
        return (value != null && value.length > 8) ? null : 'Dni invalido';
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
