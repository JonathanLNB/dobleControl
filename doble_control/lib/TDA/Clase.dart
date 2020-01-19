import 'Cliente.dart';
import 'Instructor.dart';

class Clase {
  int idcalendario;
  Instructor instructor;
  Cliente cliente;
  int idInstructorH;
  String horario;
  int idtipoauto;
  String curso;
  String fechaR;
  bool pagado;
  bool asistio;

  Clase(
      {this.idcalendario,
        this.instructor,
        this.cliente,
        this.horario,
        this.idtipoauto,
        this.idInstructorH,
        this.curso,
        this.pagado,
        this.asistio});

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
    pagado = json['pagado'];
    asistio = json['asistio'];
    idInstructorH = json['idinstructorh'];
    fechaR = json['fechar'];
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