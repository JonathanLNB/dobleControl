import 'dart:convert';

import 'package:doble_control/API/FechaM.dart';
import 'package:doble_control/API/Insercion.dart';
import 'package:doble_control/Actividades/Principal.dart';
import 'package:doble_control/Adaptadores/ClienteAdapter.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/TDA/Clase.dart';
import 'package:doble_control/TDA/Fecha.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import '../Herramientas/ShowDialog.dart';

class ClaseAdapter extends StatelessWidget {

  ClaseAdapter(this.clase, this._scaffoldKey) {
    _getFechas();
  }

  GlobalKey<ScaffoldState> _scaffoldKey;
  Clase clase;
  Fecha fecha;
  List<Fecha> _dates = new List<Fecha>();

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
            children: <Widget>[getClase(context)],
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
                          ClienteAdapter(cliente: clase.cliente, opcion: false),
                    )));
          },
        ),
        IconSlideAction(
          caption: 'Reagendar',
          color: AppColors.yellowDark,
          icon: Icons.edit,
          foregroundColor: AppColors.colorAccent,
          onTap: () {
            _selectDate(_scaffoldKey.currentContext);
          },
        ),
        IconSlideAction(
          caption: 'Falta',
          color: AppColors.red,
          icon: Icons.cancel,
          onTap: () {
            falta(context);
          },
        ),
        clase.pagado?Container():IconSlideAction(
          caption: 'Pagar',
          color: AppColors.green,
          icon: Icons.monetization_on,
          onTap: () {
            pagar(context);
          },
        ),
        clase.pagado?Container():IconSlideAction(
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

  Container getClase(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: clase.asistio
            ? clase.pagado ? AppColors.green : AppColors.yellowDark
            : clase.pagado ? AppColors.red : AppColors.yellowDark,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  clase.cliente.nombre,
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
                          clase.horario,
                          style: TextStyle(
                              color: AppColors.red,
                              fontSize: 16.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        child: Text(
                          clase.curso,
                          style: TextStyle(
                              color: AppColors.yellowDark,
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
                              image: clase.idtipoauto == 1
                                  ? AssetImage("assets/images/ambos.png")
                                  : clase.idtipoauto == 2
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
                          clase.instructor.nombre,
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

  void falta(BuildContext context) async {
    showDialog(
        context: _scaffoldKey.currentContext,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/images/sea.gif', fit: BoxFit.cover),
              title: Text(
                Strings.confirmacion,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.green),
              ),
              description: Text(
                '¿${clase.cliente.nombre} faltó?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.green),
              ),
              buttonCancelText: Text(
                Strings.cancelar,
                style: TextStyle(
                    fontFamily: "GoogleSans", color: AppColors.colorAccent),
              ),
              buttonOkText: Text(
                Strings.aceptar,
                style: TextStyle(
                    fontFamily: "GoogleSans", color: AppColors.colorAccent),
              ),
              onOkButtonPressed: () {
                ponerFalta(_scaffoldKey.currentContext);
              },
            ));
  }

  void reagendar(BuildContext context, String fecha) async {
    showDialog(
        context: _scaffoldKey.currentContext,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/images/sea.gif', fit: BoxFit.cover),
              title: Text(
                Strings.confirmacion,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.green),
              ),
              description: Text(
                '¿${clase.cliente.nombre} será reagendado para el ${fecha}?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.green),
              ),
              buttonCancelText: Text(
                Strings.cancelar,
                style: TextStyle(
                    fontFamily: "GoogleSans", color: AppColors.colorAccent),
              ),
              buttonOkText: Text(
                Strings.aceptar,
                style: TextStyle(
                    fontFamily: "GoogleSans", color: AppColors.colorAccent),
              ),
              onOkButtonPressed: () async {
                Navigator.pop(_scaffoldKey.currentContext);
                await reagendarServ(_scaffoldKey.currentContext, fecha);
              },
            ));
  }

  ponerFalta(BuildContext context) {
    String server =
        "${Strings.server}clases/falta/${clase.cliente.idcliente}/${clase.idcalendario}";
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
          Fluttertoast.showToast(msg: Strings.alumnoFalta);
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

    getData();
  }

  _getFechas() {
    String server =
        "${Strings.server}clases/${clase.idInstructorH}/${clase.idtipoauto}/${DateTime.now().month}";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        //Navigator.pop(context);
        FechasM modelo = new FechasM.fromJson(jsonDecode(response.body));
        _dates = modelo.fechas;
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }

    getData();
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
                Strings.iFecha,
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.blue,
                    fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _selectDate(_scaffoldKey.currentContext);
      },
    );
  }

  Future _selectDate(BuildContext context) async {
    ListView getLista(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return new SimpleDialogOption(
            child: Text(
              "${_dates[index].dia} ${_dates[index].iddia} de ${Strings.meses[(_dates[index].idmes - 1)]}",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              String _fecha =
                  "${_dates[index].dia} ${_dates[index].iddia} de ${Strings.meses[(_dates[index].idmes - 1)]}";
              fecha = _dates[index];
              Navigator.pop(context);
              reagendar(context, _fecha);
            },
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: _dates.length,
        addAutomaticKeepAlives: true,
      );
    }

    ShowDialog dialog = ShowDialog(
        title: Text(
          Strings.iFecha,
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
        context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  reagendarServ(BuildContext context, String fecha) async {
    String server =
        "${Strings.server}clases/reagendar/${clase.cliente.idcliente}/${clase.idcalendario}/${this.fecha.iddia}/${this.fecha.idmes}";
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
          Fluttertoast.showToast(msg: Strings.cursoReagendado);
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

  pagar(BuildContext context) async {
    String server =
        "${Strings.server}clases/reservacion/${clase.cliente.idcliente}/${clase.idInstructorH}";
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
        "${Strings.server}clases/reservacion/${clase.cliente.idcliente}/${clase.idInstructorH}";
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
