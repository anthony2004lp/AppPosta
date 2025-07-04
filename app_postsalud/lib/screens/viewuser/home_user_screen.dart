import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/anuncios_user.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/options_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'Paciente'; // Valor por defecto
  UsuariosEntity? usuarioPaciente;
  int? idUsuario;
  bool _argsLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_argsLoaded) return;
    _argsLoaded = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        idUsuario = args;
        _loadUsuario(); // Ahora sí, con idUsuario inicializado
      } else {
        debugPrint('⚠️ No llegó idUsuario en arguments');
      }
    });
  }

  Future<void> _loadUsuario() async {
    if (idUsuario == null) return;
    try {
      final usuario =
          await UsuariosController.obtenerUsuarioPacienteId(idUsuario!);
      if (usuario != null) {
        setState(() => userName = usuario.nombres);
      }
    } catch (e) {
      debugPrint('Error cargando usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(
          userName: userName, title: 'Home Paciente, id: $idUsuario'),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(218, 255, 249, 1),
          child: Column(
            children: [
              carruselHomePatient(),
              Container(
                child: const Text(
                  'InformateMás',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
              ),
              optionsHomeUser(context),
              Container(
                margin: EdgeInsets.all(20),
                height: 200,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/img/medicos.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
