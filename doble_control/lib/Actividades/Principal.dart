import 'dart:convert';
import 'dart:io';
import 'package:doble_control/API/ClaseM.dart';
import 'package:doble_control/Adaptadores/ClaseAdapter.dart';
import 'package:doble_control/Herramientas/DobleControlDrawer.dart';
import 'package:doble_control/Herramientas/InteractiveCalendar/CalendarScreen.dart';
import 'package:doble_control/Herramientas/Progress.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:doble_control/TDA/Clase.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  List<Clase> clases1 = [],
      clases2 = [],
      clases3 = [],
      clases4 = [],
      clases5 = [],
      clases6 = [],
      clases7 = [],
      clases8 = [],
      clases9 = [],
      clases10 = [],
      clases11 = [],
      clases12 = [],
      clases13 = [],
      clases14 = [],
      clases15 = [],
      clases16 = [],
      clases17 = [],
      clases18 = [],
      clases19 = [],
      clases20 = [],
      clases21 = [],
      clases22 = [],
      clases23 = [],
      clases24 = [],
      clases25 = [],
      clases26 = [],
      clases27 = [],
      clases28 = [],
      clases29 = [],
      clases30 = [],
      clases31 = [];
  int idDia, idMes;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                      child: clases1.length > 0
                          ? getLista(context, clases1, 0)
                          : getEmpty(0)),
                  Flexible(
                      child: clases2.length > 0
                          ? getLista(context, clases2, 1)
                          : getEmpty(1)),
                  Flexible(
                      child: clases3.length > 0
                          ? getLista(context, clases3, 2)
                          : getEmpty(2)),
                  Flexible(
                      child: clases4.length > 0
                          ? getLista(context, clases4, 3)
                          : getEmpty(3)),
                  Flexible(
                      child: clases5.length > 0
                          ? getLista(context, clases5, 4)
                          : getEmpty(4)),
                  Flexible(
                      child: clases6.length > 0
                          ? getLista(context, clases6, 5)
                          : getEmpty(5)),
                  Flexible(
                      child: clases7.length > 0
                          ? getLista(context, clases7, 6)
                          : getEmpty(6)),
                  Flexible(
                      child: clases8.length > 0
                          ? getLista(context, clases8, 7)
                          : getEmpty(7)),
                  Flexible(
                      child: clases9.length > 0
                          ? getLista(context, clases9, 8)
                          : getEmpty(8)),
                  Flexible(
                      child: clases10.length > 0
                          ? getLista(context, clases10, 9)
                          : getEmpty(9)),
                  Flexible(
                      child: clases11.length > 0
                          ? getLista(context, clases11, 10)
                          : getEmpty(10)),
                  Flexible(
                      child: clases12.length > 0
                          ? getLista(context, clases12, 11)
                          : getEmpty(11)),
                  Flexible(
                      child: clases13.length > 0
                          ? getLista(context, clases13, 12)
                          : getEmpty(12)),
                  Flexible(
                      child: clases14.length > 0
                          ? getLista(context, clases14, 13)
                          : getEmpty(13)),
                  Flexible(
                      child: clases15.length > 0
                          ? getLista(context, clases15, 14)
                          : getEmpty(14)),
                  Flexible(
                      child: clases16.length > 0
                          ? getLista(context, clases16, 15)
                          : getEmpty(15)),
                  Flexible(
                      child: clases17.length > 0
                          ? getLista(context, clases17, 16)
                          : getEmpty(16)),
                  Flexible(
                      child: clases18.length > 0
                          ? getLista(context, clases18, 17)
                          : getEmpty(17)),
                  Flexible(
                      child: clases19.length > 0
                          ? getLista(context, clases19, 18)
                          : getEmpty(18)),
                  Flexible(
                      child: clases20.length > 0
                          ? getLista(context, clases20, 19)
                          : getEmpty(19)),
                  Flexible(
                      child: clases21.length > 0
                          ? getLista(context, clases21, 20)
                          : getEmpty(20)),
                  Flexible(
                      child: clases22.length > 0
                          ? getLista(context, clases22, 21)
                          : getEmpty(21)),
                  Flexible(
                      child: clases23.length > 0
                          ? getLista(context, clases23, 22)
                          : getEmpty(22)),
                  Flexible(
                      child: clases24.length > 0
                          ? getLista(context, clases24, 23)
                          : getEmpty(23)),
                  Flexible(
                      child: clases25.length > 0
                          ? getLista(context, clases25, 24)
                          : getEmpty(24)),
                  Flexible(
                      child: clases26.length > 0
                          ? getLista(context, clases26, 25)
                          : getEmpty(25)),
                  Flexible(
                      child: clases27.length > 0
                          ? getLista(context, clases27, 26)
                          : getEmpty(26)),
                  Flexible(
                      child: clases28.length > 0
                          ? getLista(context, clases28, 27)
                          : getEmpty(27)),
                  Flexible(
                      child: clases29.length > 0
                          ? getLista(context, clases29, 28)
                          : getEmpty(28)),
                  Flexible(
                      child: clases30.length > 0
                          ? getLista(context, clases30, 29)
                          : getEmpty(29)),
                  Flexible(
                      child: clases31.length > 0
                          ? getLista(context, clases12, 30)
                          : getEmpty(30)),
                ],
              ),
            ),

            /*NavigationBar(false),
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
            ),*/
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
                      MaterialPageRoute(builder: (context) => CalendarScreen()),
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

  Container getEmpty(int pos) {
    return Container(
        width: 500,
        margin: new EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.center,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 92),
              child: getDia(context, pos),
            ),
            Container(
              margin: EdgeInsets.only(top: 90, bottom: 20),
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

  Widget getLista(BuildContext context, List<Clase> clases, int pos) {
    return Container(
        width: 500,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 110),
          itemBuilder: (context, index) {
            if (index == 0)
              return getDia(context, pos);
            else {
              Clase aux = clases[index - 1];
              return Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: ClaseAdapter(aux, _scaffoldKey),
              );
            }
          },
          itemCount: clases.length + 1,
          addAutomaticKeepAlives: true,
        ));
  }

  Widget getDia(BuildContext context, int pos) {
    DateTime fecha = DateTime.now().add(Duration(days: pos));
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Material(
              elevation: 10,
              color: AppColors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(5),
              )),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Material(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Material(
                          elevation: 10,
                          color: AppColors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "${fecha.day}",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: "GoogleSans",
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorAccent),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                getMes(fecha.month),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "GoogleSans",
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorAccent),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ))),
              ))),
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

  _getClases(int tipo) {
    DateTime fecha = DateTime.now().add(Duration(days: tipo));
    String server = "${Strings.server}clases/${fecha.day}/${fecha.month}";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        //Navigator.pop(context);
        ClaseM modelo = ClaseM.fromJson(jsonDecode(response.body));
        setState(() {
          switch (tipo) {
            case 0:
              clases1 = modelo.clases;
              break;
            case 1:
              clases2 = modelo.clases;
              break;
            case 2:
              clases3 = modelo.clases;
              break;
            case 3:
              clases4 = modelo.clases;
              break;
            case 4:
              clases5 = modelo.clases;
              break;
            case 5:
              clases6 = modelo.clases;
              break;
            case 6:
              clases7 = modelo.clases;
              break;
            case 7:
              clases8 = modelo.clases;
              break;
            case 8:
              clases9 = modelo.clases;
              break;
            case 9:
              clases10 = modelo.clases;
              break;
            case 10:
              clases11 = modelo.clases;
              break;
            case 11:
              clases12 = modelo.clases;
              break;
            case 12:
              clases13 = modelo.clases;
              break;
            case 13:
              clases14 = modelo.clases;
              break;
            case 14:
              clases15 = modelo.clases;
              break;
            case 15:
              clases16 = modelo.clases;
              break;
            case 16:
              clases17 = modelo.clases;
              break;
            case 17:
              clases18 = modelo.clases;
              break;
            case 18:
              clases19 = modelo.clases;
              break;
            case 19:
              clases20 = modelo.clases;
              break;
            case 20:
              clases21 = modelo.clases;
              break;
            case 21:
              clases22 = modelo.clases;
              break;
            case 22:
              clases23 = modelo.clases;
              break;
            case 23:
              clases24 = modelo.clases;
              break;
            case 24:
              clases25 = modelo.clases;
              break;
            case 25:
              clases26 = modelo.clases;
              break;
            case 26:
              clases27 = modelo.clases;
              break;
            case 27:
              clases28 = modelo.clases;
              break;
            case 28:
              clases29 = modelo.clases;
              break;
            case 29:
              clases30 = modelo.clases;
              break;
            case 30:
              clases31 = modelo.clases;
              break;
          }
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

  getData() async {
    await _getClases(0);
    await _getClases(1);
    await _getClases(2);
    await _getClases(3);
    await _getClases(4);
    await _getClases(5);
    await _getClases(6);
    await _getClases(7);
    await _getClases(8);
    await _getClases(9);
    await _getClases(10);
    await _getClases(11);
    await _getClases(12);
    await _getClases(13);
    await _getClases(14);
    await _getClases(15);
    await _getClases(16);
    await _getClases(17);
    await _getClases(18);
    await _getClases(19);
    await _getClases(20);
    await _getClases(21);
    await _getClases(22);
    await _getClases(23);
    await _getClases(24);
    await _getClases(25);
    await _getClases(26);
    await _getClases(27);
    await _getClases(28);
    await _getClases(29);
    await _getClases(30);
    await _getClases(31);
  }

  Future<bool> onBackPress() {
    salir(context);
    return Future.value(false);
  }

  String getMes(int month) {
    switch (month) {
      case 1:
        return "Enero";
      case 2:
        return "Febrero";
      case 3:
        return "Marzo";
      case 4:
        return "Abril";
      case 5:
        return "Mayo";
      case 6:
        return "Junio";
      case 7:
        return "Julio";
      case 8:
        return "Agosto";
      case 9:
        return "Septiembre";
      case 10:
        return "Octubre";
      case 11:
        return "Noviembre";
      case 12:
        return "Diciembre";
    }
  }
}
