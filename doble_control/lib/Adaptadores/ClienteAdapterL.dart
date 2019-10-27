import 'dart:convert';

import 'package:doble_control/Actividades/Alumnos.dart';
import 'package:doble_control/Actividades/Principal.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:doble_control/TDA/Cliente.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class ClienteAdapterL extends StatelessWidget {
  ClienteAdapterL(this.cliente);

  Cliente cliente;

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
          caption: 'Editar',
          color: AppColors.green,
          icon: Icons.edit,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Alumnos.update(cliente)));
          },
        ),
        IconSlideAction(
          caption: 'Eliminar',
          color: AppColors.red,
          icon: Icons.delete_forever,
          onTap: () {
            advertencia(context);
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
        color: AppColors.green,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  cliente.nombre,
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
                          "${Strings.numTelefono}:",
                          style: TextStyle(
                              color: AppColors.green,
                              fontSize: 14.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        child: Text(
                          cliente.telefono,
                          style: TextStyle(
                              color: AppColors.greyDark,
                              fontSize: 14.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Text(
                          "${Strings.numCelular}:",
                          style: TextStyle(
                              color: AppColors.green,
                              fontSize: 14.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        child: Text(
                          cliente.celular,
                          style: TextStyle(
                              color: AppColors.greyDark,
                              fontSize: 14.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                    child: Text(
                      cliente.email,
                      style: TextStyle(
                          color: AppColors.greyDark,
                          fontSize: 14.0,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void advertencia(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/images/sea.gif', fit: BoxFit.cover),
              title: Text(
                Strings.eliminarAlumno,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.green),
              ),
              description: Text(
                '¿Estas seguro de eliminar a ${cliente.nombre}?',
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
                deleteCliente(context);
              },
            ));
  }

  void deleteCliente(BuildContext context) {
    String server = "${Strings.server}clientes/${cliente.idcliente}";
    Future<String> getData() async {
      try {
        http.Response response;
        response = await http.delete(
          Uri.encodeFull(server),
          headers: {"content-type": "application/json"},
        );
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["valid"] == 1) {
          Fluttertoast.showToast(msg: Strings.alumnoDelete);
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
}
