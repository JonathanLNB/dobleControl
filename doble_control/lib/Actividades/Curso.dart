import 'dart:convert';
import 'dart:io';

import 'package:doble_control/API/HorarioM.dart';
import 'package:doble_control/API/InstructorM.dart';
import 'package:doble_control/Herramientas/Progress.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:doble_control/TDA/Auto.dart';
import 'package:doble_control/TDA/Cliente.dart';
import 'package:doble_control/TDA/Horario.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:doble_control/TDA/Curso.dart' as CursoTDA;
import 'package:doble_control/TDA/Instructor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Curso extends StatefulWidget {
  Cliente cliente;

  Curso(this.cliente);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Curso(cliente);
  }
}

class _Curso extends State<Curso> {
  Cliente cliente;
  List<CursoTDA.Curso> _cursos = new List<CursoTDA.Curso>();
  List<Instructor> _instructores = new List<Instructor>();
  List<Auto> _autos = new List<Auto>();
  List<Horario> _horarios = new List<Horario>();
  List<String> _fechas = [
    Strings.iFecha,
    Strings.iFecha,
    Strings.iFecha,
    Strings.iFecha,
    Strings.iFecha,
    Strings.iFecha,
    Strings.iFecha,
    Strings.iFecha,
    Strings.iFecha,
    Strings.iFecha
  ];
  TextEditingController fechaIC = new TextEditingController();
  TextEditingController fechaFC = new TextEditingController();
  Instructor _instructor;
  Horario _horario;
  CursoTDA.Curso _curso;
  Auto _auto;
  String instructor, horario, curso, auto;

  bool fechaIE, fechaFE, especial;

  _Curso(this.cliente);

  @override
  void initState() {
    instructor = Strings.iInstructor;
    horario = Strings.iHorario2;
    curso = Strings.iCurso;
    auto = Strings.auto;
    fechaIE = false;
    fechaFE = false;
    especial = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100, bottom: 20),
                  alignment: Alignment.center,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 5.0,
                    color: Colors.white,
                    child: Container(
                        width: 300,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            getTitulo(context, Strings.instructor2),
                            getInstructor(context),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            getTitulo(context, Strings.horario2),
                            getHorario(context),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            getTitulo(context, Strings.fechaI),
                            getFechaInicio(context),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            getTitulo(context, Strings.curso2),
                            getCurso(context),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            getTitulo(context, Strings.auto),
                            getAuto(context),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            getTitulo(context, Strings.cursoEspecial),
                            Transform.scale(
                              scale: 2.0,
                              child: new Switch(
                                value: especial,
                                onChanged: (bool value) {
                                  setState(() {
                                    especial = value;
                                  });
                                },
                                activeColor: AppColors.green,
                                activeTrackColor: AppColors.green,
                                activeThumbImage:
                                    AssetImage('assets/images/check.png'),
                                inactiveTrackColor: AppColors.red,
                                inactiveThumbColor: AppColors.red,
                                inactiveThumbImage:
                                    AssetImage('assets/images/close.png'),
                              ),
                            ),
                            especial ? mostrarDias(context) : Container(),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            getTitulo(context, Strings.fechaF),
                            getFechaFin(context),
                          ],
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
        NavigationBar(false),
        Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.only(left: 15, top: 40, right: 10)
              : EdgeInsets.only(left: 15, top: 50, right: 10),
          child: Text(
            Strings.nuevoCurso,
            style: TextStyle(
                color: AppColors.colorAccent,
                fontSize: 30.0,
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }

  Widget getFechaInicio(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5))),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: fechaIC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "",
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: fechaIE ? Strings.campovacio : null,
                suffixIcon: Icon(
                  Icons.date_range,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getFechaFin(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5))),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: fechaFC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "",
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: fechaFE ? Strings.campovacio : null,
                suffixIcon: Icon(
                  Icons.date_range,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getInstructor(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Material(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5))),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                instructor,
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _showInstructor(context);
      },
    );
  }

  _showInstructor(BuildContext context) {
    ListView getLista(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return new SimpleDialogOption(
            child: Text(
              _instructores[index].nombre,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              setState(() {
                instructor = _instructores[index].nombre;
                _instructor = _instructores[index];
              });
              Navigator.pop(context);
            },
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: _instructores.length,
        addAutomaticKeepAlives: true,
      );
    }

    AlertDialog dialog = AlertDialog(
        title: Text(
          Strings.iInstructor,
          style: TextStyle(
              fontSize: 18,
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 300,
          child: getLista(context),
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Widget getHorario(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Material(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5))),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                horario,
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _showHorario(context);
      },
    );
  }

  _showHorario(BuildContext context) {
    ListView getLista(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return new SimpleDialogOption(
            child: Text(
              _horarios[index].horario,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              setState(() {
                horario = _horarios[index].horario;
                _horario = _horarios[index];
              });
              Navigator.pop(context);
            },
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: _instructores.length,
        addAutomaticKeepAlives: true,
      );
    }

    AlertDialog dialog = AlertDialog(
        title: Text(
          Strings.iHorario2,
          style: TextStyle(
              fontSize: 18,
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 300,
          child: getLista(context),
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Widget getCurso(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Material(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5))),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                curso,
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _showCurso(context);
      },
    );
  }

  _showCurso(BuildContext context) {
    ListView getLista(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return new SimpleDialogOption(
            child: Text(
              _cursos[index].curso,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              setState(() {
                curso = _cursos[index].curso;
                _curso = _cursos[index];
              });
              Navigator.pop(context);
            },
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: _instructores.length,
        addAutomaticKeepAlives: true,
      );
    }

    AlertDialog dialog = AlertDialog(
        title: Text(
          Strings.iCurso,
          style: TextStyle(
              fontSize: 18,
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 300,
          child: getLista(context),
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Widget getAuto(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Material(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5))),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                auto,
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _showAuto(context);
      },
    );
  }

  _showAuto(BuildContext context) {
    ListView getLista(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return new SimpleDialogOption(
            child: Text(
              _autos[index].descripcion,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              setState(() {
                auto = _autos[index].descripcion;
                _auto = _autos[index];
              });
              Navigator.pop(context);
            },
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: _instructores.length,
        addAutomaticKeepAlives: true,
      );
    }

    AlertDialog dialog = AlertDialog(
        title: Text(
          Strings.iAuto,
          style: TextStyle(
              fontSize: 18,
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 300,
          child: getLista(context),
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Widget getFecha(BuildContext context, int index) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Material(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5))),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                _fechas[index],
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _selectDate(index);
      },
    );
  }

  Future _selectDate(int index) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1930),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        _fechas[index] = new DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  Widget getTitulo(BuildContext context, String titulo) {
    return Text(
      titulo,
      style: TextStyle(
          fontSize: 18,
          fontFamily: "GoogleSans",
          fontWeight: FontWeight.bold,
          color: AppColors.yellowDark),
      textAlign: TextAlign.center,
    );
  }

  Widget mostrarDias(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        String aux = _fechas[index];
        return Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            children: <Widget>[
              getTitulo(context, "${Strings.fecha} Día ${(index + 1)}"),
              getFecha(context, index)
            ],
          ),
        );
      },
      scrollDirection: Axis.vertical,
      itemCount: _fechas.length,
      shrinkWrap: true,
    );
  }

  _getInstructores() {
    String server = "${Strings.server}empleados";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        //Navigator.pop(context);
        InstructorM modelo =
            new InstructorM.fromJson(jsonDecode(response.body));
        setState(() {
          _instructores = modelo.instructores;
        });
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }

    getData();
  }

  _getHorarios() {
    String server = "${Strings.server}horarios/${_instructor}";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        //Navigator.pop(context);
        HorarioM modelo = new HorarioM.fromJson(jsonDecode(response.body));
        setState(() {
          _horarios = modelo.horarios;
        });
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }

    getData();
  }

  _getFechas() {
    String server =
        "${Strings.server}horarios/${_horario.idhorario}/${_auto.idAuto}/${DateTime.now().month}";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        //Navigator.pop(context);
        HorarioM modelo = new HorarioM.fromJson(jsonDecode(response.body));
        setState(() {
          _horarios = modelo.horarios;
        });
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }

    getData();
  }

  _onLoading(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ColorLoader3(
          radius: 20,
          dotRadius: 8,
        )
      ],
    );
  }
}
