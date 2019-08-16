import 'dart:io';

import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class Calendario extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Calendario();
  }
}

class _Calendario extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    EventList<Event> _markedDateMap = new EventList<Event>(
      events: {
        new DateTime(2019, 2, 10): [
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 1',
          ),
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 2',
          ),
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 3',
          ),
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 1',
          ),
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 2',
          ),
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 3',
          ),
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 2',
          ),
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 3',
          ),
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 2',
          ),
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 3',
          ),
        ],
      },
    );
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 130),
              child: CalendarCarousel<Event>(
                markedDatesMap: _markedDateMap,
                todayButtonColor: AppColors.green,
                todayBorderColor: AppColors.green,
                todayTextStyle: TextStyle(
                  fontFamily: "GoogleSans",
                ),
                daysTextStyle: TextStyle(
                  fontFamily: "GoogleSans",
                ),
                weekdayTextStyle: TextStyle(
                  fontFamily: "GoogleSans",
                ),
                weekendTextStyle: TextStyle(
                  color: AppColors.red,
                  fontFamily: "GoogleSans",
                ),
                onDayPressed: (DateTime date, List<Event> events) {},
                iconColor: Colors.amber,
                thisMonthDayBorderColor: AppColors.yellowDark,
                weekFormat: false,
                height: 360.0,
                daysHaveCircularBorder: true,
                markedDateMoreShowTotal: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5, right: 5),
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
                  padding: EdgeInsets.only(top: 10, bottom: 5, left: 5),
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
}
