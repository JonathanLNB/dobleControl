import 'package:doble_control/TDA/Dia.dart';

class DiaM {
  List<Dia> fechas;
  int valid;

  DiaM({this.fechas, this.valid});

  DiaM.fromJson(Map<String, dynamic> json) {
    fechas = new List<Dia>();
    if (json['fechas'] != null) {
      json['fechas'].forEach((v) {
        fechas.add(new Dia.fromJson(v));
      });
    }
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fechas != null) {
      data['fechas'] = this.fechas.map((v) => v.toJson()).toList();
    }
    data['valid'] = this.valid;
    return data;
  }
}
