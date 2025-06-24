class PostasMedicasEntity {
  int? idPosta;
  String? nombre;
  String? direccion;
  String? distrito;
  String? sede;
  double? latitud;
  double? longitud;
  String? telefono;
  String? horarioAtencion;
  String? imagenUrl;

  PostasMedicasEntity({
    this.idPosta,
    this.nombre,
    this.direccion,
    this.distrito,
    this.sede,
    this.latitud,
    this.longitud,
    this.telefono,
    this.horarioAtencion,
    this.imagenUrl,
  });

  factory PostasMedicasEntity.fromMap(Map<String, dynamic> map) {
    return PostasMedicasEntity(
      idPosta: map['id_posta'] != null
          ? int.tryParse(map['id_posta'].toString())
          : null,
      nombre: map['nombre'] ?? '',
      direccion: map['direccion'] ?? '',
      distrito: map['distrito'] ?? '',
      sede: map['sede'] ?? '',
      latitud: map['latitud'] != null
          ? double.tryParse(map['latitud'].toString())
          : null,
      longitud: map['longitud'] != null
          ? double.tryParse(map['longitud'].toString())
          : null,
      telefono: map['telefono'] ?? '',
      horarioAtencion: map['horario_atencion'] ?? '',
      imagenUrl: map['imagen_url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_posta': idPosta,
      'nombre': nombre,
      'direccion': direccion,
      'distrito': distrito,
      'sede': sede,
      'latitud': latitud,
      'longitud': longitud,
      'telefono': telefono,
      'horario_atencion': horarioAtencion,
      'imagen_url': imagenUrl,
    };
  }
}
