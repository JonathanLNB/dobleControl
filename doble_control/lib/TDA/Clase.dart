import 'package:doble_control/TDA/Auto.dart';
import 'package:doble_control/TDA/Cliente.dart';
import 'package:doble_control/TDA/Curso.dart';
import 'package:doble_control/TDA/Dia.dart';
import 'package:doble_control/TDA/Instructor.dart';

class Clase {
  List<Dia> dias;
  Cliente cliente;
  Instructor instructor;
  Auto auto;
  Curso curso;
  String horaInicio;
  String horaFin;

  Clase(this.dias, this.cliente, this.instructor, this.auto, this.curso,
      this.horaInicio, this.horaFin);
}
