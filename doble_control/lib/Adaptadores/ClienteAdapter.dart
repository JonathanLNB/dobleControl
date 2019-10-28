import 'package:doble_control/Actividades/Curso.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/TDA/Cliente.dart';
import 'package:flutter/material.dart';

class ClienteAdapter extends StatelessWidget {
  ClienteAdapter({this.cliente, this.opcion});

  Cliente cliente;
  bool opcion = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(opcion) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Curso(cliente)),
          );
        }
      },
      child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: new Stack(
            children: <Widget>[getClase(context)],
          )),
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
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 5, bottom: 5),
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
}
