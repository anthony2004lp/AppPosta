import 'package:app_postsalud/data/controllers/usuarios_controller.dart';
import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapUser extends StatefulWidget {
  const MapUser({super.key});

  @override
  State<MapUser> createState() => _MapUserState();
}

class _MapUserState extends State<MapUser> {
  GoogleMapController? _controller;

  String userName = 'Paciente'; // Valor por defecto
  UsuariosEntity? usuarioPaciente;

  @override
  void initState() {
    super.initState();
    cargarUsuarioPaciente(); // Llamar la función al iniciar
    _irAMiUbicacion(); // Opcional: centrar al iniciar
  }

  void cargarUsuarioPaciente() async {
    List<UsuariosEntity> usuarios =
        await UsuariosController.obtenerUsuariosPaciente();
    if (usuarios.isNotEmpty) {
      setState(() {
        usuarioPaciente =
            usuarios.first; // Tomar el primer usuario con idRol == 1
        userName = usuarioPaciente!.nombres; // Actualizar userName
      });
    }
  }

  final Set<Marker> _markers = {};
  LatLng _defaultPosition = const LatLng(-12.038268, -77.126306);
  // Eliminado: método duplicado initState()

  Future<void> _irAMiUbicacion() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _mostrarMensaje("Activa los servicios de ubicación");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _mostrarMensaje("Permiso de ubicación denegado");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _mostrarMensaje("Permiso de ubicación denegado permanentemente");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      final LatLng currentLatLng =
          LatLng(position.latitude, position.longitude);

      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLatLng, zoom: 16),
        ),
      );

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId("ubicacion_actual"),
            position: currentLatLng,
            infoWindow: const InfoWindow(title: "Estás aquí"),
          ),
        );
      });
    } catch (e) {
      _mostrarMensaje("Error al obtener ubicación: $e");
    }
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(
        title: 'Mapa Posta',
        userName: userName,
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _defaultPosition, zoom: 12),
        onMapCreated: (controller) {
          _controller = controller;
        },
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _irAMiUbicacion,
        icon: const Icon(Icons.my_location),
        label: const Text("Mi ubicación"),
      ),
    );
  }
}
