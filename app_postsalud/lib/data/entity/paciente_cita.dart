import 'package:app_postsalud/data/entity/usuarios_entity.dart';
import 'package:flutter/material.dart';

class PacienteCita {
  final UsuariosEntity paciente;
  final DateTime fechaCita;
  final TimeOfDay horaCita;
  PacienteCita(
      {required this.paciente,
      required this.fechaCita,
      required this.horaCita});
}
