import 'package:flutter/material.dart';
import 'package:app_postsalud/data/controllers/campania_salud_controller.dart';
import 'package:app_postsalud/data/entity/campania_salud_entity.dart';
import 'package:carousel_slider/carousel_slider.dart';

Container carruselHomePatient() {
  return Container(
    margin: const EdgeInsets.only(top: 10, bottom: 20),
    child: FutureBuilder<List<CampaniaSaludEntity>>(
      future: CampaniaSaludController.obtenerCampanias(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Indicador de carga
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text(
                  "No hay campañas disponibles")); // Mensaje si no hay registros
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: 250, // Aumenté el tamaño para incluir más datos
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: snapshot.data!.map((campania) {
            return Container(
              padding:
                  EdgeInsets.all(12), // Agregado para mejorar espaciado interno
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.blueAccent, // Color para mejorar la visibilidad
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    campania.titulo, // Título de la campaña
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8), // Espaciado
                  Text(
                    campania.descripcion, // Descripción de la campaña
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Desde: ${campania.fechaInicio.toLocal().toString().split(' ')[0]} - Hasta: ${campania.fechaFin.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    campania.urlInfo, // URL de información de la campaña
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.yellow,
                        fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    ),
  );
}
