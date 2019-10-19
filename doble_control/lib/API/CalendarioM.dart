import 'package:doble_control/TDA/Clase.dart';

class CalendarioM {
  List<List<Clase>> clases;
  int valid;

  CalendarioM({
    this.clases,
    this.valid,
  });

  factory CalendarioM.fromJson(Map<String, dynamic> json) => CalendarioM(
    clases: List<List<Clase>>.from(json["clases"].map((x) => List<Clase>.from(x.map((x) => Clase.fromJson(x))))),
    valid: json["valid"],
  );

  Map<String, dynamic> toJson() => {
    "clases": List<dynamic>.from(clases.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "valid": valid,
  };
}