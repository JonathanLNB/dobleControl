class Dia {
  int iddia;
  int idmes;
  String mes;
  String dia;

  Dia({this.iddia, this.idmes, this.mes, this.dia});

  Dia.fromJson(Map<String, dynamic> json) {
    iddia = json['iddia'];
    idmes = json['idmes'];
    mes = json['mes'];
    dia = json['dia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iddia'] = this.iddia;
    data['idmes'] = this.idmes;
    data['mes'] = this.mes;
    data['dia'] = this.dia;
    return data;
  }
}
