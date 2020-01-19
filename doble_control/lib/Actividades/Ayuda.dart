import 'dart:io';

import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:flutter/material.dart';

class Ayuda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 80),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    Strings.tarjetas,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 30.0,
                      fontFamily: "GoogleSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tarjeta Amarilla",
                    style: TextStyle(
                      color: AppColors.yellowDark,
                      fontSize: 25.0,
                      fontFamily: "GoogleSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  getTarjeta(context, 0),
                  Text(
                    "Una tarjeta amarilla indica que el cliente no ha liquidado el curso.",
                    style: TextStyle(
                      color: AppColors.yellowDark,
                      fontSize: 20.0,
                      fontFamily: "GoogleSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Tarjeta Roja",
                    style: TextStyle(
                      color: AppColors.red,
                      fontSize: 25.0,
                      fontFamily: "GoogleSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  getTarjeta(context, 1),
                  Text(
                    "La tarjeta roja indica que el cliente ya pago el curso pero no asistirá a esa clase",
                    style: TextStyle(
                      color: AppColors.red,
                      fontSize: 20.0,
                      fontFamily: "GoogleSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Tarjeta Verde",
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 25.0,
                      fontFamily: "GoogleSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  getTarjeta(context, 2),
                  Text(
                    "La tarjeta verde indica que el cliente ya pago el curso y asistirá a la clase ",
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 20.0,
                      fontFamily: "GoogleSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Autos",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 30.0,
                      fontFamily: "GoogleSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
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
                              image: AssetImage("assets/images/estandar.png")),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Text(
                          "Auto estandar",
                          style: TextStyle(
                              color: AppColors.green,
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
                              image: AssetImage("assets/images/automatico.png")),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Text(
                          "Auto Automatico",
                          style: TextStyle(
                              color: AppColors.pink,
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
                              image: AssetImage("assets/images/ambos.png")),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Text(
                          "Ambos Autos",
                          style: TextStyle(
                              color: AppColors.blueRey,
                              fontSize: 16.0,
                              fontFamily: "GoogleSans",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        NavigationBar(false),
        Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.only(left: 15, top: 40, right: 10)
              : EdgeInsets.only(left: 15, top: 50, right: 10),
          child: Text(
            Strings.ayuda,
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

  Container getTarjeta(BuildContext context, int color) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: color == 0
            ? AppColors.yellowDark
            : color == 1 ? AppColors.red : AppColors.green,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  "Persona",
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
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Text(
                          "${Strings.numTelefono}:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
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
}
