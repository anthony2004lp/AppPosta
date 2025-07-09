import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class RequestAddress {

  static const platform = MethodChannel('com.tuapp.api');

  static Future<String?> obtenerApiKeyDesdeAndroid() async {
    try {
      final apiKey = await platform.invokeMethod('getApiKey');
      return apiKey;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, double>?> solicitarUbicacion() async {
    bool servicioActivo = await Geolocator.isLocationServiceEnabled();
    if (!servicioActivo) {
      return null;
    }

    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        return null;
      }
    }

    if (permiso == LocationPermission.deniedForever) {
      return null;
    }

    try {
      Position posicion = await Geolocator.getCurrentPosition();
      return {
        'latitud': posicion.latitude,
        'longitud': posicion.longitude,
      };
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, String>> obtenerDireccionGoogle(double lat, double lng) async {
    String? apiKey = await RequestAddress.obtenerApiKeyDesdeAndroid();
    log(apiKey.toString());
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey'
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      log(response.toString());
      log(data.toString());
      if (response.statusCode == 200 && data['status'] == 'OK') {
        final resultados = data['results'];
        if (resultados.isNotEmpty) {
          final direccion = resultados[0]['formatted_address'];
          final components = resultados[0]['address_components'];

          String? distrito, ciudad, provincia, pais, postal;

          for (var comp in components) {
            final tipos = comp['types'];
            if (tipos.contains('locality')) ciudad = comp['long_name'];
            if (tipos.contains('sublocality') || tipos.contains('administrative_area_level_2')) distrito = comp['long_name'];
            if (tipos.contains('administrative_area_level_1')) provincia = comp['long_name'];
            if (tipos.contains('country')) pais = comp['long_name'];
            if (tipos.contains('postal_code')) postal = comp['long_name'];
          }

          return {
            'direccion': direccion,
            'distrito': distrito ?? '',
            'ciudad': ciudad ?? '',
            'provincia': provincia ?? '',
            'pais': pais ?? '',
            'postal': postal ?? '',
          };
        }
      }
      return {'error': 'No se encontró dirección para esas coordenadas.'};
    } catch (e) {
      return {'error': 'Error al conectar con Google Maps: $e'};
    }
  }
}