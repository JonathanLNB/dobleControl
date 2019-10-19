import 'Cliente.dart';
import 'Instructor.dart';

class Clase {
  int idcalendario;
  Instructor instructor;
  Cliente cliente;
  String horario;
  int idtipoauto;
  String curso;

  Clase(
      {this.idcalendario,
        this.instructor,
        this.cliente,
        this.horario,
        this.idtipoauto,
        this.curso});

  Clase.fromJson(Map<String, dynamic> json) {
    idcalendario = json['idcalendario'];
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
    cliente =
    json['cliente'] != null ? new Cliente.fromJson(json['cliente']) : null;
    horario = json['horario'];
    idtipoauto = json['idtipoauto'];
    curso = json['curso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcalendario'] = this.idcalendario;
    if (this.instructor != null) {
      data['instructor'] = this.instructor.toJson();
    }
    if (this.cliente != null) {
      data['cliente'] = this.cliente.toJson();
    }
    data['horario'] = this.horario;
    data['idtipoauto'] = this.idtipoauto;
    data['curso'] = this.curso;
    return data;
  }
}