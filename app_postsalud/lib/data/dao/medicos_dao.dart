import 'package:app_postsalud/data/entity/medicos_entity.dart';
import 'package:app_postsalud/services/database_service.dart';

class MedicosDao {
  static Future<List<MedicosEntity>> getMedicos() async {
    var conn = await DatabaseService.connect();

    var result = await conn.execute("SELECT * FROM medicos");

    List<MedicosEntity> medicos =
        result.rows.map((row) => MedicosEntity.fromMap(row.assoc())).toList();

    await conn.close();
    return medicos;
  }

  static Future<void> insertMedico(MedicosEntity medico) async {
    var conn = await DatabaseService.connect();

    await conn.execute(
      "INSERT INTO medicos (apellidos, nombres, dni, correo, telefono, direccion_personal, fecha_nacimiento, sexo, id_especialidad, direccion_consultorio, ciudad, region, horario_atencion, foto_url, id_posta) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
      [
        medico.apellidos,
        medico.nombres,
        medico.dni,
        medico.correo,
        medico.telefono,
        medico.direccionPersonal,
        medico.fechaNacimiento
            ?.toLocal()
            .toIso8601String()
            .split('T')[0], // Formato correcto para DATE
        medico.sexo,
        medico.idEspecialidad,
        medico.direccionConsultorio,
        medico.ciudad,
        medico.region,
        medico.horarioAtencion,
        medico.fotoUrl,
        medico.idPosta,
      ] as Map<String, dynamic>?,
    );
  }

  static Future<List<MedicosEntity>> obtenerMedicosPorPosta(int idPosta) async {
    final conn = await DatabaseService.connect();
    final result = await conn.execute(
      'SELECT * FROM medicos WHERE id_posta = :idPosta',
      {'idPosta': idPosta},
    );
    return result.rows
        .map((row) => MedicosEntity.fromMap(row.assoc()))
        .toList();
  }

  static Future<void> updateMedico(MedicosEntity medico) async {
    var conn = await DatabaseService.connect();

    await conn.execute(
        "UPDATE medicos SET apellidos=  :apellidos, nombres= :nombres, dni= :dni , correo= :correo, telefono= :telefono, direccion_personal= :direccion_personal, fecha_nacimiento= :fecha_nacimiento, sexo= :sexo, id_especialidad= :id_especialidad, direccion_consultorio= :direccion_consultorio, ciudad= :ciudad, region= :region, horario_atencion= :horario_atencion, foto_url= :foto_url, id_posta= :id_posta WHERE id_medico= :id_medico",
        {
          'apellidos': medico.apellidos,
          'nombres': medico.nombres,
          'dni': medico.dni,
          'correo': medico.correo,
          'telefono': medico.telefono,
          'direccion_personal': medico.direccionPersonal,
          'fecha_nacimiento':
              medico.fechaNacimiento?.toLocal().toIso8601String().split('T')[0],
          'sexo': medico.sexo,
          'id_especialidad': medico.idEspecialidad,
          'direccion_consultorio': medico.direccionConsultorio,
          'ciudad': medico.ciudad,
          'region': medico.region,
          'horario_atencion': medico.horarioAtencion,
          'foto_url': medico.fotoUrl,
          'id_posta': medico.idPosta,
          'id_medico': medico.idMedico
        });
  }

  static Future<MedicosEntity> searchNameMedico(MedicosEntity medico) async {
    var conn = await DatabaseService.connect();

    var result = await conn.execute(
        "SELECT * FROM medicos WHERE nombres = :nombres and apellidos = :apellidos",
        {'nombres': medico.nombres, 'apellidos': medico.apellidos});

    if (result.rows.isNotEmpty) {
      return MedicosEntity.fromMap(result.rows.first.assoc());
    } else {
      throw Exception("No se encontró el médico con ese nombre");
    }
  }

  // Eliminar un medico por ID
  static Future<void> deleteMedico(int idMedico) async {
    var conn = await DatabaseService.connect();

    await conn.execute("DELETE FROM medicos WHERE id_medico = :id_medico",
        {'id_medico': idMedico});
    await conn.close();
  }
}
