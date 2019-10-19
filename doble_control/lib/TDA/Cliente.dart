class Cliente {
  int idcliente;
  String nombre;
  String domicilio;
  int edad;
  String celular;
  String telefono;
  String email;

  Cliente(
      {this.idcliente,
      this.nombre,
      this.domicilio,
      this.edad,
      this.celular,
      this.telefono,
      this.email});

  Cliente.fromJson(Map<String, dynamic> json) {
    idcliente = json['idcliente'];
    nombre = json['nombre'];
    domicilio = json['domicilio'];
    edad = json['edad'];
    celular = json['celular'];
    telefono = json['telefono'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcliente'] = this.idcliente;
    data['nombre'] = this.nombre;
    data['domicilio'] = this.domicilio;
    data['edad'] = this.edad;
    data['celular'] = this.celular;
    data['telefono'] = this.telefono;
    data['email'] = this.email;
    return data;
  }
}
