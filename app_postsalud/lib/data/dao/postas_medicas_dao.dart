import 'package:app_postsalud/data/entity/postas_medicas_entity.dart';
import 'package:app_postsalud/services/database_service.dart';

class PostasMedicasDao {
  static Future<List<PostasMedicasEntity>> getPostas() async {
    var conn = await DatabaseService.connect();
    var result = await conn.execute("SELECT * FROM postas_medicas");
    List<PostasMedicasEntity> postas = result.rows
        .map((row) => PostasMedicasEntity.fromMap(row.assoc()))
        .toList();
    await conn.close();
    return postas;
  }
}
