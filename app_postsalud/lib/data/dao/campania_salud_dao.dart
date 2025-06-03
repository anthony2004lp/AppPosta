import 'package:app_postsalud/services/database_service.dart';
import 'package:app_postsalud/data/entity/campania_salud_entity.dart';

class CampaniaSaludDao {
  // Obtener todas las campañas de salud
  static Future<List<CampaniaSaludEntity>> getCampanias() async {
    var conn = await DatabaseService.connect(); // Conectar a la BD

    var result =
        await conn.execute("SELECT * FROM campanias_salud"); // Consulta

    List<CampaniaSaludEntity> campanias = result.rows
        .map((row) => CampaniaSaludEntity.fromMap(row.assoc()))
        .toList();

    await conn.close(); // Cerrar conexión

    return campanias;
  }

  // Insertar nueva campaña
  static Future<void> insertCampania(CampaniaSaludEntity campania) async {
    var conn = await DatabaseService.connect();

    await conn.execute(
        "INSERT INTO campanias_salud (titulo, descripcion, fecha_inicio, fecha_fin, url_info) "
        "VALUES (?, ?, ?, ?, ?)",
        [
          campania.titulo,
          campania.descripcion,
          campania.fechaInicio,
          campania.fechaFin,
          campania.urlInfo
        ] as Map<String, dynamic>?);

    await conn.close();
  }

  // Actualizar campaña existente
  static Future<void> updateCampania(CampaniaSaludEntity campania) async {
    var conn = await DatabaseService.connect();

    await conn.execute(
        "UPDATE campanias_salud SET titulo = ?, descripcion = ?, fecha_inicio = ?, fecha_fin = ?, url_info = ? "
        "WHERE id_campania = ?",
        [
          campania.titulo,
          campania.descripcion,
          campania.fechaInicio,
          campania.fechaFin,
          campania.urlInfo,
          campania.idCampania
        ] as Map<String, dynamic>?);

    await conn.close();
  }

  // Eliminar campaña por ID
  static Future<void> deleteCampania(int idCampania) async {
    var conn = await DatabaseService.connect();

    await conn.execute("DELETE FROM campanias_salud WHERE id_campania = ?",
        [idCampania] as Map<String, dynamic>?);

    await conn.close();
  }
}
