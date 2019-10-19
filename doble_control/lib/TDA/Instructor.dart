class Instructor {
  int idinstructor;
  String nombre;
  String domicilio;
  int edad;
  String celular;
  String telefono;
  String email;

  Instructor(
      {this.idinstructor,
        this.nombre,
        this.domicilio,
        this.edad,
        this.celular,
        this.telefono,
        this.email});

  Instructor.fromJson(Map<String, dynamic> json) {
    idinstructor = json['idinstructor'];
    nombre = json['nombre'];
    domicilio = json['domicilio'];
    edad = json['edad'];
    celular = json['celular'];
    telefono = json['telefono'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idinstructor'] = this.idinstructor;
    data['nombre'] = this.nombre;
    data['domicilio'] = this.domicilio;
    data['edad'] = this.edad;
    data['celular'] = this.celular;
    data['telefono'] = this.telefono;
    data['email'] = this.email;
    return data;
  }
}