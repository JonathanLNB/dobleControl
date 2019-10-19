import 'package:doble_control/TDA/Instructor.dart';

class InstructorM {
  List<Instructor> instructores;
  int valid;

  InstructorM({this.instructores, this.valid});

  InstructorM.fromJson(Map<String, dynamic> json) {
    instructores = new List<Instructor>();
    if (json['instructores'] != null) {
      json['instructores'].forEach((v) {
        instructores.add(new Instructor.fromJson(v));
      });
    }
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.instructores != null) {
      data['instructores'] = this.instructores.map((v) => v.toJson()).toList();
    }
    data['valid'] = this.valid;
    return data;
  }
}
