class Fecha {
  int iddia;
  int idmes;
  String mes;
  String dia;

  Fecha({
    this.iddia,
    this.idmes,
    this.mes,
    this.dia,
  });

  factory Fecha.fromJson(Map<String, dynamic> json) => Fecha(
        iddia: json["iddia"],
        idmes: json["idmes"],
        mes: json["mes"],
        dia: json["dia"],
      );

  Map<String, dynamic> toJson() => {
        "iddia": iddia,
        "idmes": idmes,
        "mes": mes,
        "dia": dia,
      };
}
