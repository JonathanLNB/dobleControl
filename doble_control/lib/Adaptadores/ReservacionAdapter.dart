import 'dart:convert';

import 'package:doble_control/API/FechaM.dart';
import 'package:doble_control/API/Insercion.dart';
import 'package:doble_control/Actividades/Principal.dart';
import 'package:doble_control/Adaptadores/ClienteAdapter.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/TDA/Reservacion.dart';
import 'package:doble_control/TDA/Fecha.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import '../Herramientas/ShowDialog.dart';

class ReservacionAdapter extends StatelessWidget {

  ReservacionAdapter(this.reservacion, this._scaffoldKey) {
  }

  GlobalKey<ScaffoldState> _scaffoldKey;
  Reservacion reservacion;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: new Stack(
            children: <Widget>[getReservacion(context)],
          )),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Contacto',
          color: AppColors.green,
          icon: Icons.book,
          onTap: () {
            showDialog(
        context: _scaffoldKey.currentContext,
                builder: (_) => Center(
                        child: Container(
                      height: 165,
                      child:
                          ClienteAdapter(cliente: reservacion.clase.cliente, opcion: false),
                    )));
          },
        ),
       IconSlideAction(
          caption: 'Pagar',
          color: AppColors.green,
          icon: Icons.monetization_on,
          onTap: () {
            pagar(context);
          },
        ),
        IconSlideAction(
          caption: 'Eliminar',
          color: AppColors.red,
          icon: Icons.delete,
          onTap: () {
            eliminar(context);
          },
        ),
      ],
    );
  }

  Container getReservacion(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: reservacion.clase.asistio
            ? reservacion.clase.pagado ? AppColors.green : AppColors.yellowDark
            : reservacion.clase.pagado ? AppColors.red : AppColors.yellowDark,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  reservacion.clase.cliente.nombre,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              elevation: 15.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Text(
                          Strings.fechaR,
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        child: Text(
                          reservacion.fechar,
                          style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 16.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        child: Text(
                          Strings.horario,
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        child: Text(
                          reservacion.clase.horario,
                          style: TextStyle(
                              color: AppColors.red,
                              fontSize: 16.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: reservacion.clase.idtipoauto == 1
                                  ? AssetImage("assets/images/ambos.png")
                                  : reservacion.clase.idtipoauto == 2
                                      ? AssetImage("assets/images/automatico.png")
                                      : AssetImage("assets/images/estandar.png")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Text(
                          Strings.instructor,
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        child: Text(
                          reservacion.clase.instructor.nombre,
                          style: TextStyle(
                              color: AppColors.green,
                              fontSize: 16.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  pagar(BuildContext context) async {
    String server =
        "${Strings.server}clases/reservacion/${reservacion.clase.cliente.idcliente}/${reservacion.clase.idInstructorH}";
    Future<String> getData() async {
      try {
        http.Response response = await http.put(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        Insercion modelo = new Insercion.fromJson(jsonDecode(response.body));
        if (modelo.valid == 1) {
          Fluttertoast.showToast(msg: Strings.cursoPagado);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Principal()),
              ModalRoute.withName('/principal'));
        } else
          Fluttertoast.showToast(msg: Strings.errorS);
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }
    await getData();
  }

  eliminar(BuildContext context) async {
    String server =
        "${Strings.server}clases/reservacion/${reservacion.clase.cliente.idcliente}/${reservacion.clase.idInstructorH}";
    Future<String> getData() async {
      try {
        http.Response response = await http.delete(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        Insercion modelo = new Insercion.fromJson(jsonDecode(response.body));
        if (modelo.valid == 1) {
          Fluttertoast.showToast(msg: Strings.cursoEliminado);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Principal()),
              ModalRoute.withName('/principal'));
        } else
          Fluttertoast.showToast(msg: Strings.errorS);
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }
    await getData();
  }
}
