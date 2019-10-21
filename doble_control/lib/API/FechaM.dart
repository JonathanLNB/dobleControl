import 'package:doble_control/TDA/Fecha.dart';

class FechasM {
  List<Fecha> fechas;
  int valid;

  FechasM({
    this.fechas,
    this.valid,
  });

  factory FechasM.fromJson(Map<String, dynamic> json) => FechasM(
    fechas: List<Fecha>.from(json["fechas"].map((x) => Fecha.fromJson(x))),
    valid: json["valid"],
  );

  Map<String, dynamic> toJson() => {
    "fechas": List<dynamic>.from(fechas.map((x) => x.toJson())),
    "valid": valid,
  };
}