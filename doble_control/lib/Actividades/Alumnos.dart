import 'dart:convert';
import 'dart:io';

import 'package:doble_control/API/ClienteM.dart';
import 'package:doble_control/Adaptadores/ClienteAdapter.dart';
import 'package:doble_control/Herramientas/Progress.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:doble_control/TDA/Cliente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'Curso.dart';
import 'Principal.dart';

class Alumnos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Alumnos();
  }
}

class _Alumnos extends State<Alumnos> {
  TextEditingController filtroC = new TextEditingController();
  TextEditingController nombresC = new TextEditingController();
  TextEditingController correoC = new TextEditingController();
  TextEditingController numTelefonoC = new TextEditingController();
  TextEditingController numCelularC = new TextEditingController();
  TextEditingController domicilioC = new TextEditingController();
  TextEditingController edadC = new TextEditingController();
  List<String> _dias, horaI, horaF;
  List<Cliente> _clientes = new List<Cliente>();
  String dias, horarios;
  int idUser;
  bool passwordVisible,
      nombresE,
      correoE,
      numTelefonoE,
      numCelularE,
      domicilioE,
      edadE,
      filtroE,
      antiguo = false;

  _Alumnos();

  @override
  void initState() {
    horarios = Strings.iHorario;
    passwordVisible = true;
    nombresE = false;
    domicilioE = false;
    filtroE = false;
    numCelularE = false;
    numTelefonoE = false;
    edadE = false;
    correoE = false;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100, bottom: 20),
                  alignment: Alignment.center,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 5.0,
                    color: Colors.white,
                    child: Container(
                        width: 300,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            getTitulo(context, Strings.alumnonuevo),
                            Transform.scale(
                              scale: 2.0,
                              child: new Switch(
                                value: antiguo,
                                onChanged: (bool value) {
                                  setState(() {
                                    antiguo = value;
                                  });
                                },
                                activeColor: AppColors.green,
                                activeTrackColor: AppColors.green,
                                activeThumbImage:
                                    AssetImage('assets/images/check.png'),
                                inactiveTrackColor: AppColors.red,
                                inactiveThumbColor: AppColors.red,
                                inactiveThumbImage:
                                    AssetImage('assets/images/close.png'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            antiguo
                                ? getNewAlumno(context)
                                : getOldAlumnos(context),
                            antiguo
                                ? Padding(
                                    padding: EdgeInsets.all(10),
                                    child: new RaisedButton(
                                      onPressed: () {
                                        /*showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => _onLoading(context),
                                  );*/
                                        //AQUI EL USUARIO
                                        if (validation()) {
                                          Cliente cliente = new Cliente(
                                              nombre: nombresC.text,
                                              domicilio: domicilioC.text,
                                              edad: int.parse(edadC.text),
                                              telefono: numTelefonoC.text,
                                              celular: numCelularC.text,
                                              email: correoC.text);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Curso(cliente)),
                                          );
                                        }
                                      },
                                      child: Text(
                                        Strings.siguiente,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "GoogleSans",
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.colorAccent),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: AppColors.yellowDark,
                                    ),
                                  )
                                : Container(),
                          ],
                        )),
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
            Strings.nuevoCurso,
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

  Widget getNewAlumno(BuildContext context) {
    return Column(
      children: <Widget>[
        getTitulo(context, Strings.nombre),
        getNombre(context),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        getTitulo(context, Strings.domicilio),
        getDomicilio(context),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        getTitulo(context, Strings.edad),
        getEdad(context),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        getTitulo(context, Strings.numTelefono),
        getNumTelefono(context),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        getTitulo(context, Strings.numCelular),
        getNumCelular(context),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        getTitulo(context, Strings.correo),
        getCorreo(context),
      ],
    );
  }

  Widget getOldAlumnos(BuildContext context) {
    return Column(
      children: <Widget>[
        getTitulo(context, Strings.filtro),
        getFiltro(context),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        Container(
          height: 370,
          child: ListView.builder(
            itemBuilder: (context, index) {
              Cliente aux = _clientes[index];
              return Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: ClienteAdapter(aux),
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: _clientes.length,
            shrinkWrap: true,
          ),
        )
      ],
    );
  }

  Widget getTitulo(BuildContext context, String titulo) {
    return Text(
      titulo,
      style: TextStyle(
          fontSize: 18,
          fontFamily: "GoogleSans",
          fontWeight: FontWeight.bold,
          color: AppColors.yellowDark),
      textAlign: TextAlign.center,
    );
  }

  Widget getNombre(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
              controller: nombresC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iNombre,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: nombresE ? "Error: ${Strings.campovacio}" : null,
                suffixIcon: Icon(
                  Icons.account_circle,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getFiltro(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
                errorText: filtroE ? "Error: ${Strings.campovacio}" : null,
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

  Widget getNumTelefono(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
              keyboardType: TextInputType.phone,
              controller: numTelefonoC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iNumTelefono,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: numTelefonoE ? "Error: ${Strings.campovacio}" : null,
                suffixIcon: Icon(
                  Icons.phone,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getNumCelular(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              controller: numCelularC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iNumCelular,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: numCelularE ? "Error: ${Strings.campovacio}" : null,
                suffixIcon: Icon(
                  Icons.phone_android,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDomicilio(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
              controller: domicilioC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iDomicilio,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: domicilioE ? "Error: ${Strings.campovacio}" : null,
                suffixIcon: Icon(
                  Icons.map,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getEdad(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              controller: edadC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iEdad,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: edadE ? "Error: ${Strings.campovacio}" : null,
                suffixIcon: Icon(
                  Icons.timelapse,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCorreo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: correoC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iCorreo,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: correoE ? "Error: ${Strings.campovacio}" : null,
                suffixIcon: Icon(
                  Icons.email,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

  getData() async {

    await _getClientes();
  }

  Future goPrincipal() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Principal()),
        ModalRoute.withName('/principal'));
  }

  bool validation() {
    bool access = true;
    if (nombresC.text.length == 0) {
      access = false;
      nombresE = true;
    } else
      nombresE = false;
    if (correoC.text.length == 0) {
      access = false;
      correoE = true;
    } else
      correoE = false;
    if (domicilioC.text.length == 0) {
      access = false;
      domicilioE = true;
    } else
      domicilioE = false;
    if (edadC.text.length == 0) {
      access = false;
      edadE = true;
    } else
      edadE = false;
    if (numTelefonoC.text.length == 0) {
      access = false;
      numTelefonoE = true;
    } else
      numTelefonoE = false;
    if (numCelularC.text.length == 0) {
      access = false;
      numCelularE = true;
    } else
      numCelularE = false;
    if (!access) Fluttertoast.showToast(msg: Strings.errorForm);
    return access;
  }
}
