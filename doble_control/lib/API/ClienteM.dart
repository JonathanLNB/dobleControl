import 'package:doble_control/TDA/Cliente.dart';

class ClienteM {
  List<Cliente> clientes;
  int valid;

  ClienteM({this.clientes, this.valid});

  ClienteM.fromJson(Map<String, dynamic> json) {
    clientes = new List<Cliente>();
    if (json['clientes'] != null) {
      json['clientes'].forEach((v) {
        clientes.add(new Cliente.fromJson(v));
      });
    }
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientes != null) {
      data['clientes'] = this.clientes.map((v) => v.toJson()).toList();
    }
    data['valid'] = this.valid;
    return data;
  }
}
