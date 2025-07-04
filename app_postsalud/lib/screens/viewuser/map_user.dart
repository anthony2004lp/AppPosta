import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/dao/postas_medicas_dao.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/data/entity/postas_medicas_entity.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUser extends StatefulWidget {
  const MapUser({super.key});

  @override
  State<MapUser> createState() => _MapUserState();
}

class _MapUserState extends State<MapUser> {
  GoogleMapController? _controller;
  String userName = 'Paciente';
  UsuariosEntity? usuarioPaciente;
  PostasMedicasEntity? postaMedica;
  int? idUsuario;

  final _initialPostion = const CameraPosition(
    target: LatLng(-11.953115, -77.070309),
    zoom: 17,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        idUsuario = args;
        cargarUsuarioPaciente();
        cargarPosta();
      } else {
        debugPrint('⚠️ No llegó idUsuario en arguments');
      }
    });
  }

  Future<void> cargarPosta() async {
    final posta = await PostasMedicasDao.getPostaById(1);
    if (posta != null) {
      setState(() {
        postaMedica = posta;
      });
    }
  }

  Future<void> cargarUsuarioPaciente() async {
    // protección: no llamar si sigue null
    if (idUsuario == null) return;

    try {
      final usuario =
          await UsuariosController.obtenerUsuarioPacienteId(idUsuario!);
      if (usuario != null) {
        setState(() {
          userName = usuario.nombres;
        });
      }
    } catch (e) {
      debugPrint('Error cargando usuario: $e');
    }
  }

  Set<Marker> _crearMarcadores() {
    if (postaMedica == null) return {};

    return {
      Marker(
        markerId: MarkerId('posta_${postaMedica!.idPosta}'),
        position: LatLng(postaMedica!.latitud!, postaMedica!.longitud!),
        infoWindow: InfoWindow(title: postaMedica!.nombre ?? ''),
        onTap: _mostrarMenuFlotante,
      ),
    };
  }

  void _mostrarMenuFlotante() {
    if (postaMedica == null) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(bottom: 20),
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postaMedica!.nombre ?? 'Posta Médica',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
                'Direccion: ${postaMedica!.direccion}, ${postaMedica!.distrito}'),
            Text('Sede: ${postaMedica!.sede}'),
            const SizedBox(height: 6),
            Text('📞 ${postaMedica!.telefono}'),
            Text('🕒 ${postaMedica!.horarioAtencion}'),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                    context,
                    'reservacita',
                    arguments: postaMedica!.idPosta,
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Reservar Cita'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(
        userName: userName,
        title: 'Mapa',
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPostion,
        onMapCreated: (controller) => _controller = controller,
        markers: _crearMarcadores(),
        myLocationButtonEnabled: true,
      ),
    );
  }
}
