class Horario {
  int idhorario;
  String horario;

  Horario({
    this.idhorario,
    this.horario,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
    idhorario: json["idhorario"],
    horario: json["horario"],
  );

  factory Horario.fromJson2(Map<String, dynamic> json) => Horario(
    idhorario: json["idinstructorh"],
    horario: json["horario"],
  );

  Map<String, dynamic> toJson() => {
    "idhorario": idhorario,
    "horario": horario,
  };

  @override
  String toString() {
    // TODO: implement toString
    return horario;
  }
}
