import 'package:doble_control/TDA/Reservacion.dart';

class ReservacionM {
  List<Reservacion> reservaciones;
  int valid;

  ReservacionM({this.reservaciones, this.valid});

  ReservacionM.fromJson(Map<String, dynamic> json) {
    if (json['reservaciones'] != null) {
      reservaciones = new List<Reservacion>();
      json['reservaciones'].forEach((v) {
        reservaciones.add(new Reservacion.fromJson(v));
      });
    }
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservaciones != null) {
      data['reservaciones'] =
          this.reservaciones.map((v) => v.toJson()).toList();
    }
    data['valid'] = this.valid;
    return data;
  }
}
