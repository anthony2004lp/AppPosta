import 'package:app_postsalud/data/entity/campania_salud_entity.dart';
import 'package:app_postsalud/data/dao/campania_salud_dao.dart';

class CampaniaSaludController {
  static Future<List<CampaniaSaludEntity>> obtenerCampanias() async {
    return await CampaniaSaludDao.getCampanias();
  }
}
