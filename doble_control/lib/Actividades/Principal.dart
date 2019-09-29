import 'dart:io';
import 'package:doble_control/Actividades/Calendario.dart';
import 'package:doble_control/Adaptadores/ClaseAdapter.dart';
import 'package:doble_control/Dialogos/AdminDialog.dart';
import 'package:doble_control/Herramientas/DobleControlDrawer.dart';
import 'package:doble_control/Herramientas/InteractiveCalendar/CalendarScreen.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:doble_control/TDA/Clase.dart';
import 'package:doble_control/TDA/Instructor.dart';
import 'package:doble_control/TDA/Curso.dart';
import 'package:doble_control/TDA/Auto.dart';
import 'package:doble_control/TDA/Cliente.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class Principal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Principal();
  }
}

class _Principal extends State<Principal> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Clase> clases = [];

  @override
  Widget build(BuildContext context) {
    clases.add(new Clase(
        null,
        new Cliente("Jonathan", "San Isidro Culiacan", "12", "555",
            "55", "hoal@gmail.com"),
        new Instructor("JP", "San Isidro Culiacan", "12", "555",
            "55", "hoal@gmail.com", null),
        new Auto(1, "Automatico"),
        new Curso(1, "Curso 1"),
        "10:20",
        "11:20"));
    clases.add(new Clase(
        null,
        new Cliente("Leonardo", "San Isidro Culiacan", "12", "555",
            "55", "hoal@gmail.com"),
        new Instructor("JP", "San Isidro Culiacan", "12", "555",
            "55", "hoal@gmail.com", null),
        new Auto(2, "Estandar"),
        new Curso(1, "Curso 2"),
        "10:20",
        "11:20"));
    clases.add(new Clase(
        null,
        new Cliente("Pedro", "San Isidro Culiacan", "12", "555",
            "55", "hoal@gmail.com"),
        new Instructor("JP", "San Isidro Culiacan", "12", "555",
            "55", "hoal@gmail.com", null),
        new Auto(3, "Dos"),
        new Curso(1, "Curso 3"),
        "10:20",
        "11:20"));
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Stack(
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
                  backgroundColor: AppColors.yellowDark,
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  tooltip: Strings.menu,
                  child: new Icon(
                    Icons.menu,
                    size: 25,
                    color: AppColors.colorAccent,
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
                  backgroundColor: AppColors.yellowDark,
                  onPressed: () {
                    /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calendario()),
                  );*/
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalendarScreen(clases)),
                    );
                  },
                  tooltip: Strings.calendario,
                  child: new Icon(
                    Icons.calendar_today,
                    size: 30,
                    color: AppColors.colorAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: DobleControlDrawer(),
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
          child: ClaseAdapter(aux),
        );
      },
      scrollDirection: Axis.vertical,
      itemCount: clases.length,
      addAutomaticKeepAlives: true,
    );
  }

  void salir(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
          image: Image.asset('assets/images/cerrar.gif', fit: BoxFit.cover),
          title: Text(
            Strings.salir,
            style: TextStyle(
                fontSize: 22,
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.bold,
                color: AppColors.yellowDark),
          ),
          description: Text(
            Strings.salirInfo,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                fontFamily: "GoogleSans",
                color: AppColors.yellowDark),
          ),
          buttonCancelText: Text(
            Strings.cancelar,
            style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
          ),
          buttonOkText: Text(
            Strings.aceptar,
            style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
          ),
          onOkButtonPressed: () {
            Platform.isAndroid ? SystemNavigator.pop() : exit(0);
          },
        ));
  }

  Future<bool> onBackPress() {
    salir(context);
    return Future.value(false);
  }

}
