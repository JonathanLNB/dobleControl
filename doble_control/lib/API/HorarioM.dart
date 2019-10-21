import 'package:doble_control/TDA/Horario.dart';

class HorarioM {
  List<Horario> horarios;
  int valid;

  HorarioM({
    this.horarios,
    this.valid,
  });

  factory HorarioM.fromJson(Map<String, dynamic> json) => HorarioM(
    horarios: List<Horario>.from(json["horarios"].map((x) => Horario.fromJson2(x))),
    valid: json["valid"],
  );

  Map<String, dynamic> toJson() => {
    "horarios": List<dynamic>.from(horarios.map((x) => x.toJson())),
    "valid": valid,
  };
}
