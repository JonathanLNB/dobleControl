import 'package:doble_control/TDA/Dia.dart';

class Instructor {
  String nombre;
  String domicilio;
  String edad;
  String ciudad;
  String telefono;
  String celular;
  String email;
  List<Dia> dias;

  Instructor(this.nombre, this.domicilio, this.edad, this.ciudad, this.telefono,
      this.celular, this.email, this.dias);
}