import 'dart:io';
import 'dart:math';

import 'package:doble_control/Herramientas/InteractiveCalendar/CalendarModel.dart';
import 'package:doble_control/Herramientas/InteractiveCalendar/CalendarWidget.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:doble_control/TDA/Clase.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  List<Clase> clases = [];

  CalendarScreen(this.clases);

  @override
  State<StatefulWidget> createState() {
    return CalendarScreenState(clases);
  }
}

class CalendarScreenState extends State<CalendarScreen> {
  List<Clase> clases = [];
  List<List<Clase>> events = [];

  CalendarScreenState(this.clases);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0 ; i < 28 ; i ++)
      events.add(randomClase());
  }

  List<Clase> randomClase() {
    List<Clase> _list = [];
    int length = Random().nextInt(1000) % 5;
    for (int i = 0; i < length; i++)
      _list.add(clases[Random().nextInt(1000) % clases.length]);
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            buildContent(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                  child: new RaisedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.cursoD,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "GoogleSans",
                          color: AppColors.colorAccent),
                      textAlign: TextAlign.center,
                    ),
                    color: AppColors.green,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                  child: new RaisedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.fechaD,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "GoogleSans",
                          color: AppColors.colorAccent),
                      textAlign: TextAlign.center,
                    ),
                    color: AppColors.green,
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
            Strings.calendario,
            style: TextStyle(
                color: AppColors.colorAccent,
                fontSize: 30.0,
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }

  Widget buildContent() {
    return InteractiveCalendar(events);
  }
}
