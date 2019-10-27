class Curso {
  int idcurso;
  String curso;

  Curso({
    this.idcurso,
    this.curso,
  });

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
    idcurso: json["idcurso"],
    curso: json["curso"],
  );

  Map<String, dynamic> toJson() => {
    "idcurso": idcurso,
    "curso": curso,
  };
}
