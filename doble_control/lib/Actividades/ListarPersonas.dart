import 'dart:convert';
import 'dart:io';

import 'package:doble_control/API/ClienteM.dart';
import 'package:doble_control/API/InstructorM.dart';
import 'package:doble_control/Actividades/SingIn.dart';
import 'package:doble_control/Adaptadores/ClienteAdapterL.dart';
import 'package:doble_control/Adaptadores/InstructorAdapter.dart';
import 'package:doble_control/Herramientas/Progress.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:doble_control/TDA/Cliente.dart';
import 'package:doble_control/TDA/Instructor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ListarPersonas extends StatefulWidget {
  bool instructor;

  ListarPersonas(this.instructor);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ListarPersonas(instructor);
  }
}

class _ListarPersonas extends State<ListarPersonas> {
  List<Instructor> _instructores = new List<Instructor>();
  List<Cliente> _clientes = new List<Cliente>();
  TextEditingController filtroC = new TextEditingController();
  String filter = "";
  bool filtroE, instructor;

  _ListarPersonas(this.instructor);

  @override
  void initState() {
    filtroC.addListener(() {
      setState(() {
        filter = filtroC.text;
      });
    });
    filtroE = false;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(children: <Widget>[
        getLista(context),
        NavigationBar(false),
        Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.only(left: 15, top: 40, right: 10)
              : EdgeInsets.only(left: 15, top: 50, right: 10),
          child: Text(
            instructor ? Strings.instructores : Strings.misClientes,
            style: TextStyle(
                color: AppColors.colorAccent,
                fontSize: 30.0,
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.bold),
          ),
        ),
        new Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.only(left: 20, bottom: 10, right: 10)
              : EdgeInsets.only(left: 20, bottom: 10, right: 10),
          child: new Align(
            alignment: Alignment.bottomRight,
            child: instructor
                ? new FloatingActionButton(
                    heroTag: Strings.nuevoInstructor,
                    backgroundColor: AppColors.yellowDark,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    tooltip: Strings.nuevoInstructor,
                    child: new Icon(
                      Icons.person_add,
                      size: 30,
                      color: AppColors.colorAccent,
                    ),
                  )
                : Container(),
          ),
        ),
      ]),
    );
  }

  Widget getLista(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 120),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          getTitulo(context, Strings.filtro),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getBuscador(context),
            ],
          ),
          getListado(context)
        ],
      ),
    );
  }

  Widget getListado(BuildContext context) {
    return new Flexible(
        child: ListView.builder(
      itemBuilder: (context, index) {
        if (instructor) {
          Instructor aux = _instructores[index];
          return filter == null || filter == ""
              ? Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: InstructorAdapter(aux),
                )
              : aux.nombre.toLowerCase().contains(filter.toLowerCase())
                  ? Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: InstructorAdapter(aux),
                    )
                  : Container();
        } else {
          Cliente aux = _clientes[index];
          return filter == null || filter == ""
              ? Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: ClienteAdapterL(aux),
                )
              : aux.nombre.toLowerCase().contains(filter.toLowerCase())
                  ? Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: ClienteAdapterL(aux),
                    )
                  : Container();
        }
      },
      scrollDirection: Axis.vertical,
      itemCount: instructor ? _instructores.length : _clientes.length,
      addAutomaticKeepAlives: true,
    ));
  }

  Widget getBuscador(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5))),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: filtroC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iFiltro,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: filtroE ? Strings.campovacio : null,
                suffixIcon: Icon(
                  Icons.search,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitulo(BuildContext context, String titulo) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 5.0,
            color: Colors.white,
            child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  titulo,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                      color: AppColors.yellowDark),
                  textAlign: TextAlign.center,
                ))));
  }

  _onLoading(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ColorLoader3(
          radius: 20,
          dotRadius: 8,
        )
      ],
    );
  }

  _getClientes() {
    String server = "${Strings.server}clientes";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        //Navigator.pop(context);
        ClienteM modelo = ClienteM.fromJson(jsonDecode(response.body));
        modelo.clientes.sort((a, b) => a.nombre.compareTo(b.nombre));
        setState(() {
          _clientes = modelo.clientes;
        });
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }

    getData();
  }

  _getInstructores() {
    String server = "${Strings.server}empleados";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(
          Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
          },
        );
        //Navigator.pop(context);
        InstructorM modelo = InstructorM.fromJson(jsonDecode(response.body));
        setState(() {
          _instructores = modelo.instructores;
        });
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }

    getData();
  }

  getData() async {
    /*showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _onLoading(context),
    );*/

    if (instructor)
      await _getInstructores();
    else
      await _getClientes();
  }
}
