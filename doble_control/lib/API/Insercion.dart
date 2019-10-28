class Insercion {
  int valid;

  Insercion({
    this.valid,
  });

  factory Insercion.fromJson(Map<String, dynamic> json) => Insercion(
    valid: json["valid"],
  );

  Map<String, dynamic> toJson() => {
    "valid": valid,
  };
}