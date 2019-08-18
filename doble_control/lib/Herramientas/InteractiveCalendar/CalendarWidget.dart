import 'package:doble_control/Herramientas/InteractiveCalendar/CalendarModel.dart';
import 'package:doble_control/Herramientas/InteractiveCalendar/CalendarPainter.dart';
import 'package:doble_control/Herramientas/InteractiveCalendar/Utils.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/TDA/Clase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var APP_BAR_SIZE = 80.0;
double HEIGHT_TITLE_WEEKDAY = 24.0;
double HEIGHT_TITLE_MONTH = 26.0;

class InteractiveCalendar extends StatefulWidget {
  List<List<Clase>> fakeEvents;

  InteractiveCalendar(this.fakeEvents);

  @override
  State<StatefulWidget> createState() {
    return InteractiveCalendarState(fakeEvents);
  }
}

class InteractiveCalendarState extends State<InteractiveCalendar> {
  var date = new DateTime.now();
  double WIDTH, HEIGHT, MARGIN, WIDTH_CELL;
  double _previousZoom;
  double _zoom = 1.0;
  Offset _startingFocalPoint;
  Offset _previousOffset;
  Offset _offset = Offset.zero;

  DateTime _startDate;
  DateTime _dateSelected = DateTime.now();
  DateTime _dateHover = DateTime.now();
  DateTime _tempDateSelected = DateTime.now();
  int meses = -5;
  bool _isLongPressed = false;

  List<List<Clase>> fakeEvents;

  InteractiveCalendarState(this.fakeEvents);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WIDTH = MediaQuery.of(context).size.width;
    HEIGHT = MediaQuery.of(context).size.height * .8;
    MARGIN = (WIDTH - WIDTH / 8 * 7) / 2;
    WIDTH_CELL = WIDTH / 8;
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[buildBody(context)]));
  }

  Widget buildBody(BuildContext context) {
    _startDate = getStartDate();

    List<CalendarBase> cells = [];

    DateTime _now = new DateTime(date.year, date.month - meses, date.day);
    for (int i = 0; i < 42; i++) {
      if (i == 0)
        ['D', 'L', 'M', 'X', 'J', 'V', 'S']
            .forEach((t) => cells.add(CalendarCellTitle(text: t)));

      DateTime _date = _startDate.add(Duration(days: i));

      CalendarEvent event = CalendarEvent.Disable(_date, []);
      if (_date.month == _now.month) event = CalendarEvent.Enable(_date, []);

      if (Utils.isEqual(_date, _dateSelected)) {
        event = CalendarEvent.Selection(_date, []);
        if (Utils.isEqual(_date, DateTime.now()))
          event = CalendarEvent.SelectedToday(_date, []);
      } else {
        if (Utils.isEqual(_date, DateTime.now()))
          event = CalendarEvent.Today(_date, []);
      }
      cells.add(event..events = fakeEvents[i]);
    }

    return Container(
      child: ConstrainedBox(
        child: Listener(
            onPointerMove: (e) {
              if (this._isLongPressed) {
                //todo update long pressed
                setState(() {
                  this._offset = this._offset - e.delta;
                  _dateHover =
                      getDateByOffset(e.position - _offset) ?? _dateHover;
                });
              }
            },
            onPointerUp: (e) {
              if (this._isLongPressed)
                setState(() {
                  /*//todo stop long pressed
                  this._isLongPressed = false;
                  //covert data from dateselected => datehover
                  int diffSelected = Duration(
                              milliseconds:
                                  _dateSelected.millisecondsSinceEpoch)
                          .inDays -
                      Duration(milliseconds: _startDate.millisecondsSinceEpoch)
                          .inDays;
                  int diffHover = Duration(
                              milliseconds: _dateHover.millisecondsSinceEpoch)
                          .inDays -
                      Duration(milliseconds: _startDate.millisecondsSinceEpoch)
                          .inDays;

                  List<Clase> _temp = []..addAll(fakeEvents[diffSelected]);
                  widget.fakeEvents[diffSelected] = [];
                  widget.fakeEvents[diffHover] = widget.fakeEvents[diffHover]
                    ..addAll(_temp);
                  _dateSelected = _dateHover;

                  print('diffSelected: ' + diffSelected.toString());
                  print('diffHover: ' + diffHover.toString());*/
                });
            },
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 120),
                child: CustomPaint(
                    painter: CalendarPainter(
                        isLongPress: _isLongPressed,
                        title: DateFormat('MM/yyyy').format(new DateTime(
                            date.year, date.month - meses, date.day)),
                        offset: _offset,
                        zoom: _zoom,
                        dateHover: _dateHover,
                        widthCell: WIDTH_CELL,
                        widthParent: WIDTH,
                        values: cells,
                        margin: MARGIN)),
              ),
              onLongPress: handleLongPress,
              onTap: handleTap,
              onTapDown: handleTapDown,
              onScaleStart: _isLongPressed ? null : handleScaleStart,
              onScaleUpdate: _isLongPressed ? null : handleScaleUpdate,
            )),
        constraints: BoxConstraints.expand(width: WIDTH, height: HEIGHT),
      ),
    );
  }

  void handleTap() {
    if (_isLongPressed) {
      setState(() => this._isLongPressed = false);
    } else {
      if (_tempDateSelected.month ==
          new DateTime(date.year, date.month - meses, date.day).month)
        setState(() => this._dateSelected = this._tempDateSelected);
      print(DateFormat('dd/MM/yyyy').format(_dateSelected));
    }
  }

  void handleTapDown(TapDownDetails detail) {
    _tempDateSelected =
        getDateByOffset(detail.globalPosition - _offset) ?? _tempDateSelected;
  }

  void handleScaleStart(ScaleStartDetails details) {
    setState(() {
      _startingFocalPoint = details.focalPoint;
      _previousOffset = _offset;
      _previousZoom = _zoom;
    });
  }

  void handleScaleUpdate(ScaleUpdateDetails details) {
    double _tempZoom = _previousZoom * details.scale;
    if (_tempZoom < 0.8)
      _tempZoom = 0.8;
    else if (_tempZoom > 7.0) _tempZoom = 7.0;
    setState(() {
      _zoom = _tempZoom;
      final Offset normalizedOffset =
          (_startingFocalPoint - _previousOffset) / _previousZoom;
      _offset = details.focalPoint - normalizedOffset * _zoom;
    });
  }

  void handleLongPress() {
    if (_tempDateSelected.month ==
        new DateTime(date.year, date.month - meses, date.day).month) {
      _dateSelected = _tempDateSelected;
      setState(() {
        this._isLongPressed = true;
        this._dateHover = null;
      });
    }
  }

  DateTime getStartDate() {
    //todo monday => 1, sunday => 7
    int _weekday =
        new DateTime(date.year, date.month - meses, date.day).weekday == 7
            ? 0
            : new DateTime(date.year, date.month - meses, date.day).weekday;
    int _diff =
        (new DateTime(date.year, date.month - meses, date.day).day / 7).ceil() *
                7 +
            _weekday;

    DateTime _startMonth = new DateTime(date.year, date.month - meses, date.day)
        .subtract(Duration(days: _diff));
    return _startMonth;
  }

  DateTime getDateByOffset(Offset offset) {
    double _x = (offset.dx) / _zoom - MARGIN;
    double _y = (offset.dy - APP_BAR_SIZE - MARGIN) / _zoom -
        HEIGHT_TITLE_WEEKDAY -
        HEIGHT_TITLE_MONTH;

    int _i = (_y / WIDTH_CELL).floor();
    int _j = (_x / WIDTH_CELL).floor();

    if (_i >= 0 && _i < 7 && _j >= 0 && _j < 7) {
      int diff = _i * 7 + _j;
      DateTime _date = _startDate.add(Duration(days: diff));
      return _date;
    }
    return null;
  }
}
