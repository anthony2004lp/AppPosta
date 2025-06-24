import 'package:app_postsalud/data/dao/postas_medicas_dao.dart';
import 'package:app_postsalud/data/entity/postas_medicas_entity.dart';

class PostasMedicasController {
  static Future<List<PostasMedicasEntity>> obtenerPostasMedicas() async {
    List<PostasMedicasEntity> postas = await PostasMedicasDao.getPostas();
    return postas;
  }
}
