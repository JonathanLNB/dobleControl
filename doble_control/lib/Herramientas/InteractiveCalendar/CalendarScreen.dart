import 'dart:io';
import 'package:doble_control/Herramientas/InteractiveCalendar/CalendarWidget.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:flutter/material.dart';


class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarScreenState();
  }
}

class CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return InteractiveCalendar();
  }
}
