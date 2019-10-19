import 'package:doble_control/TDA/Clase.dart';

class ClaseM {
  List<Clase> clases;
  int valid;

  ClaseM({this.clases, this.valid});

  ClaseM.fromJson(Map<String, dynamic> json) {
    clases = new List<Clase>();
    if (json['clases'] != null) {
      json['clases'].forEach((v) {
        clases.add(new Clase.fromJson(v));
      });
    }

    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clases != null) {
      data['clases'] = this.clases.map((v) => v.toJson()).toList();
    }
    data['valid'] = this.valid;
    return data;
  }
}
