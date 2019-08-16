import 'dart:io';
import 'package:doble_control/Actividades/Calendario.dart';
import 'package:doble_control/Adaptadores/ClienteAdapter.dart';
import 'package:doble_control/Dialogos/AdminDialog.dart';
import 'package:doble_control/Herramientas/InteractiveCalendar/CalendarScreen.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:doble_control/TDA/Clase.dart';
import 'package:doble_control/TDA/Instructor.dart';
import 'package:doble_control/TDA/Curso.dart';
import 'package:doble_control/TDA/Auto.dart';
import 'package:doble_control/TDA/Cliente.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Principal();
  }
}

class _Principal extends State<Principal> {
  List<Clase> clases = [];

  @override
  Widget build(BuildContext context) {
    clases.add(new Clase(
        null,
        new Cliente("Jonathan", "San Isidro Culiacan",
            "12", "Culiacan", "555", "55", "hoal@gmail.com"),
        new Instructor("JP", "San Isidro Culiacan", "12", "Culiacan", "555",
            "55", "hoal@gmail.com", null),
        new Auto(1, "Automatico"),
        new Curso(1, "Curso 1"),
        "10:20",
        "11:20"));
    clases.add(new Clase(
        null,
        new Cliente("Leonardo", "San Isidro Culiacan", "12", "Culiacan", "555",
            "55", "hoal@gmail.com"),
        new Instructor("JP", "San Isidro Culiacan", "12", "Culiacan", "555",
            "55", "hoal@gmail.com", null),
        new Auto(2, "Estandar"),
        new Curso(1, "Curso 2"),
        "10:20",
        "11:20"));
    clases.add(new Clase(
        null,
        new Cliente("Pedro", "San Isidro Culiacan", "12", "Culiacan", "555",
            "55", "hoal@gmail.com"),
        new Instructor("JP", "San Isidro Culiacan", "12", "Culiacan", "555",
            "55", "hoal@gmail.com", null),
        new Auto(3, "Dos"),
        new Curso(1, "Curso 3"),
        "10:20",
        "11:20"));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/fondo.png"),
                  fit: BoxFit.none,
                  repeat: ImageRepeat.repeat),
            ),
          ),
          clases.length > 0 ? getLista(context) : getEmpty(),
          NavigationBar(false),
          Padding(
            padding: Platform.isAndroid
                ? EdgeInsets.only(left: 15, top: 40, right: 10)
                : EdgeInsets.only(left: 15, top: 50, right: 10),
            child: Text(
              Strings.pendientesHoy,
              style: TextStyle(
                  color: AppColors.colorAccent,
                  fontSize: 30.0,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold),
            ),
          ),
          new Padding(
            padding: Platform.isAndroid
                ? EdgeInsets.only(left: 20, top: 35, right: 10)
                : EdgeInsets.only(left: 20, top: 45, right: 10),
            child: new Align(
              alignment: Alignment.topRight,
              child: new FloatingActionButton(
                backgroundColor: AppColors.colorAccent,
                onPressed: () {
                  mostrarDialogo(context);
                },
                tooltip: Strings.menu,
                child: new Icon(
                  Icons.menu,
                  size: 25,
                  color: AppColors.yellowDark,
                ),
              ),
            ),
          ),
          new Padding(
            padding: Platform.isAndroid
                ? EdgeInsets.only(left: 20, bottom: 10, right: 10)
                : EdgeInsets.only(left: 20, bottom: 10, right: 10),
            child: new Align(
              alignment: Alignment.bottomRight,
              child: new FloatingActionButton(
                heroTag: "Calendario",
                backgroundColor: AppColors.colorAccent,
                onPressed: () {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calendario()),
                  );*/
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarScreen(clases)),
                  );
                },
                tooltip: Strings.calendario,
                child: new Icon(
                  Icons.calendar_today,
                  size: 30,
                  color: AppColors.yellowDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container getEmpty() {
    return Container(
        margin: new EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.center,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 220, bottom: 20),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/semaforo.png'),
              )),
            ),
            Container(
                margin: EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 5.0,
                  color: Colors.white,
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        Strings.sinClientes,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.bold,
                            color: AppColors.green),
                        textAlign: TextAlign.center,
                      )),
                )),
          ],
        ));
  }

  ListView getLista(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 110),
      itemBuilder: (context, index) {
        Clase aux = clases[index];
        return Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: ClienteAdapter(aux),
        );
      },
      scrollDirection: Axis.vertical,
      itemCount: clases.length,
      addAutomaticKeepAlives: true,
    );
  }

  /*Future<bool> mostrarDialogo(context) {
    return showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: AdminDialog(),
          );
        });
  }*/

  Future<bool> mostrarDialogo(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 300,
              width: 400,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: AdminDialog(),
            ),
          );
        });
  }
}
