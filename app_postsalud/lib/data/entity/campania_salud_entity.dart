class CampaniaSaludEntity {
  int? idCampania;
  String titulo;
  String descripcion;
  DateTime fechaInicio;
  DateTime fechaFin;
  String urlInfo;

  CampaniaSaludEntity({
    this.idCampania,
    required this.titulo,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.urlInfo,
  });

  // Convertir desde Map (para obtener datos desde la BD)
  factory CampaniaSaludEntity.fromMap(Map<String, dynamic> map) {
    return CampaniaSaludEntity(
      idCampania: map['id_campania'] != null
          ? int.tryParse(map['id_campania'].toString())
          : null,
      titulo: map['titulo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      fechaInicio:
          DateTime.tryParse(map['fecha_inicio'].toString()) ?? DateTime.now(),
      fechaFin:
          DateTime.tryParse(map['fecha_fin'].toString()) ?? DateTime.now(),
      urlInfo: map['url_info'] ?? '',
    );
  }

  // Convertir a Map (para insertar en la BD)
  Map<String, dynamic> toMap() {
    return {
      'id_campania': idCampania,
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha_inicio': fechaInicio.toIso8601String(),
      'fecha_fin': fechaFin.toIso8601String(),
      'url_info': urlInfo,
    };
  }
}
