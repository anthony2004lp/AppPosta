import 'package:flutter/material.dart';
import 'package:app_postsalud/screens/viewuser/widgetuser/app_bar_user.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

class MapUser extends StatelessWidget {
  const MapUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarUser(userName: 'paciente'),
        body: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(-12.0464, -77.0428),
            initialZoom: 13.0,
          ),
          children: [
            TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': 'mapbox/streets-v12',
                })
          ],
        ));
  }
}
