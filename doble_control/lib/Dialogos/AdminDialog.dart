import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:flutter/material.dart';

class AdminDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: FloatingActionButton(
                          backgroundColor: AppColors.yellowDark,
                          onPressed: () {
                            /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MostrarCategoria()),
                      );*/
                          },
                          tooltip: Strings.nuevoCurso,
                          child: new Icon(
                            Icons.add,
                            size: 30,
                            color: AppColors.colorAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            Strings.nuevoCurso,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "GoogleSans",
                                color: AppColors.black),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: AppColors.yellowDark,
                        onPressed: () {
                          /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MostrarCategoria()),
                      );*/
                        },
                        tooltip: Strings.instructores,
                        child: new Icon(
                          Icons.contact_mail,
                          size: 30,
                          color: AppColors.colorAccent,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        Strings.instructores,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "GoogleSans",
                            color: AppColors.black),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: AppColors.yellowDark,
                        onPressed: () {
                          /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MostrarCategoria()),
                      );*/
                        },
                        tooltip: Strings.misClientes,
                        child: new Icon(
                          Icons.people,
                          size: 30,
                          color: AppColors.colorAccent,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        Strings.misClientes,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "GoogleSans",
                            color: AppColors.black),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Column(
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: AppColors.red,
                        onPressed: () {
                          /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MostrarCategoria()),
                      );*/
                        },
                        tooltip: Strings.cerrarS,
                        child: new Icon(
                          Icons.exit_to_app,
                          size: 30,
                          color: AppColors.colorAccent,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        Strings.cerrarS,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "GoogleSans",
                            color: AppColors.red),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: new RaisedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Strings.cerrar,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "GoogleSans",
                        color: AppColors.colorAccent),
                    textAlign: TextAlign.center,
                  ),
                  color: AppColors.yellowDark,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
