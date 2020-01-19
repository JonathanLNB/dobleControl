import 'Clase.dart';

class Reservacion {
  int idcliente;
  String fechar;
  Clase clase;

  Reservacion({this.idcliente, this.fechar, this.clase});

  Reservacion.fromJson(Map<String, dynamic> json) {
    idcliente = json['idcliente'];
    fechar = json['fechar'];
    clase = json['clase'] != null ? new Clase.fromJson(json['clase']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcliente'] = this.idcliente;
    data['fechar'] = this.fechar;
    if (this.clase != null) {
      data['clase'] = this.clase.toJson();
    }
    return data;
  }
}