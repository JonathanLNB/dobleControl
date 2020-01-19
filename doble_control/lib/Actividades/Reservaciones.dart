import 'dart:convert';
import 'dart:io';

import 'package:doble_control/API/ReservacionM.dart';
import 'package:doble_control/API/ClienteM.dart';
import 'package:doble_control/API/InstructorM.dart';
import 'package:doble_control/Actividades/SingIn.dart';
import 'package:doble_control/Adaptadores/ClaseAdapter.dart';
import 'package:doble_control/Adaptadores/ClaseAdapter.dart';
import 'package:doble_control/Adaptadores/ClienteAdapterL.dart';
import 'package:doble_control/Adaptadores/InstructorAdapter.dart';
import 'package:doble_control/Adaptadores/ReservacionAdapter.dart';
import 'package:doble_control/Herramientas/Progress.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:doble_control/TDA/Clase.dart';
import 'package:doble_control/TDA/Cliente.dart';
import 'package:doble_control/TDA/Instructor.dart';
import 'package:doble_control/TDA/Reservacion.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Reservaciones extends StatefulWidget {
  Reservaciones();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Reservaciones();
  }
}

class _Reservaciones extends State<Reservaciones> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Reservacion> _reservaciones = new List<Reservacion>();
  TextEditingController filtroC = new TextEditingController();
  String filter = "";
  bool filtroE, instructor;

  _Reservaciones();

  @override
  void initState() {
    filtroC.addListener(() {
      setState(() {
        filter = filtroC.text;
      });
    });
    _reservaciones = [];
    filtroE = false;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(children: <Widget>[
        _reservaciones!=null?_reservaciones.length>0?getLista(context):getEmpty():getEmpty(),
        NavigationBar(false),
        Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.only(left: 15, top: 40, right: 10)
              : EdgeInsets.only(left: 15, top: 50, right: 10),
          child: Text(
           Strings.reservaciones,
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

  Widget getLista(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 120),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          getTitulo(context, Strings.filtro),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getBuscador(context),
            ],
          ),
          getListado(context)
        ],
      ),
    );
  }

  Container getEmpty() {
    return Container(
        width: 400,
        margin: new EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
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
                        Strings.sinReservaciones,
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

  Widget getListado(BuildContext context) {
    return new Flexible(
        child: ListView.builder(
      itemBuilder: (context, index) {
        Reservacion aux = _reservaciones[index];
        return filter == null || filter == ""
            ? Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: ReservacionAdapter(aux,_scaffoldKey),
              )
            : aux.clase.cliente.nombre.toLowerCase().contains(filter.toLowerCase())
                ? Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: ReservacionAdapter(aux,_scaffoldKey),
                  )
                : Container();
      },
      scrollDirection: Axis.vertical,
      itemCount: _reservaciones.length,
      addAutomaticKeepAlives: true,
    ));
  }

  Widget getBuscador(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
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
              controller: filtroC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iFiltro,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: filtroE ? Strings.campovacio : null,
                suffixIcon: Icon(
                  Icons.search,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitulo(BuildContext context, String titulo) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 5.0,
            color: Colors.white,
            child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  titulo,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                      color: AppColors.yellowDark),
                  textAlign: TextAlign.center,
                ))));
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

  _getReservaciones() {
    String server = "${Strings.server}clases/reservaciones";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        //Navigator.pop(context);
        ReservacionM modelo = ReservacionM.fromJson(jsonDecode(response.body));
        if(modelo.valid == 1) {
          setState(() {
            _reservaciones = modelo.reservaciones;
          });
        }
        else
          Fluttertoast.showToast(msg: Strings.errorS);
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }

    getData();
  }


  getData() async {
    /*showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _onLoading(context),
    );*/
    await _getReservaciones();
  }
}
