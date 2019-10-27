class Auto {
  int idtipoauto;
  String tipoauto;

  Auto({
    this.idtipoauto,
    this.tipoauto,
  });

  factory Auto.fromJson(Map<String, dynamic> json) => Auto(
        idtipoauto: json["idtipoauto"],
        tipoauto: json["tipoauto"],
      );

  Map<String, dynamic> toJson() => {
        "idtipoauto": idtipoauto,
        "tipoauto": tipoauto,
      };
}
