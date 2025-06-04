import 'package:app_postsalud/services/database_service.dart';
import 'package:app_postsalud/data/entity/campania_salud_entity.dart';

class CampaniaSaludDao {
  // Obtener todas las campañas de salud
  static Future<List<CampaniaSaludEntity>> getCampanias() async {
    var conn = await DatabaseService.connect();

    try {
      var result = await conn.execute("SELECT * FROM campanias_salud");

      List<CampaniaSaludEntity> campanias = result.rows
          .map((row) => CampaniaSaludEntity.fromMap(row.assoc()))
          .toList();

      return campanias;
    } catch (e) {
      print("Error al obtener campañas: $e");
      return [];
    } finally {
      await conn.close();
    }
  }
}
