import 'package:doble_control/Actividades/Principal.dart';
import 'package:doble_control/Adaptadores/ClienteAdapter.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/TDA/Clase.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class ClaseAdapter extends StatelessWidget {
  ClaseAdapter(this.clase);

  Clase clase;

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
                context: context,
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
          foregroundColor: AppColors.colorAccent,
          color: AppColors.yellowDark,
          icon: Icons.edit,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Falta',
          color: AppColors.red,
          icon: Icons.cancel,
          onTap: () {
            falta(context);
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
                                  ? AssetImage("assets/images/automatico.png")
                                  : clase.idtipoauto == 2
                                      ? AssetImage("assets/images/estandar.png")
                                      : AssetImage("assets/images/ambos.png")),
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
        context: context,
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
                Fluttertoast.showToast(msg: Strings.falta);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Principal()),
                    ModalRoute.withName('/principal'));
              },
            ));
  }
}
