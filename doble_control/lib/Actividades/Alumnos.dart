import 'dart:convert';
import 'dart:io';

import 'package:doble_control/Herramientas/Progress.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'LogIn.dart';
import 'Principal.dart';

class Alumnos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Alumnos();
  }
}

class _Alumnos extends State<Alumnos> {
  TextEditingController nombresC = new TextEditingController();
  TextEditingController correoC = new TextEditingController();
  TextEditingController numTelefonoC = new TextEditingController();
  TextEditingController numCelularC = new TextEditingController();
  TextEditingController domicilioC = new TextEditingController();
  TextEditingController edadC = new TextEditingController();
  List<String> _dias, horaI, horaF;
  String foto, dias, horarios;
  int password, idUser;
  bool passwordVisible,
      nombresE,
      correoE,
      numTelefonoE,
      numCelularE,
      domicilioE,
      edadE,
      nuevo = false;

  _Alumnos();

  @override
  void initState() {
    horarios = Strings.iHorario;
    passwordVisible = true;
    nombresE = false;
    correoE = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        NavigationBar(true),
        Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: Platform.isAndroid
                ? EdgeInsets.only(top: 120)
                : EdgeInsets.only(top: 120),
            child: Text(
              Strings.registrate,
              style: TextStyle(
                  color: AppColors.colorAccent,
                  fontSize: 30.0,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 150, bottom: 20),
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
                                value: nuevo,
                                onChanged: (bool value) {
                                  setState(() {
                                    nuevo = value;
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
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: new RaisedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => _onLoading(context),
                                  );
                                  registerUser();
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
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
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
                errorText: nombresE ? Strings.campovacio : null,
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
                errorText: numTelefonoE ? Strings.campovacio : null,
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
                errorText: numCelularE ? Strings.campovacio : null,
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
                errorText: domicilioE ? Strings.campovacio : null,
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
                errorText: edadE ? Strings.campovacio : null,
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
                enabled: password == 1,
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
                errorText: correoE ? Strings.campovacio : null,
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

  Future goPrincipal() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Principal()),
        ModalRoute.withName('/principal'));
  }

  void registerUser() {
    /*if (validation()) RegisterAPI();*/
  }

  void goLogIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LogIn()),
        ModalRoute.withName('/logIn'));
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
    return access;
  }

/*void RegisterAPI() {
    String server = "${Strings.server}users";
    Future<String> getData() async {
      try {
        http.Response response;
        if (password != 2) {
          response = await http.post(Uri.encodeFull(server),
              headers: {"content-type": "application/json"},
              body: jsonEncode({
                "username": userC.text,
                "name": nombresC.text,
                "lastname": apellidosC.text,
                "email": correoC.text,
                "password": "Ema1lPas5",
                "profile_img": image,
                "birthday": fechaN,
                "birthplace": "",
                "gender_id": generoC,
                "role_id": 1
              }));
        } else {
          print("${server}/$idUser");
          response = await http.put(Uri.encodeFull("${server}/$idUser"),
              headers: {
                "content-type": "application/json",
                'Authorization': 'Bearer $token'
              },
              body: jsonEncode({
                "username": userC.text,
                "name": nombresC.text,
                "lastname": apellidosC.text,
                "profile_img": image,
                "birthday": fechaN,
                "birthplace": "",
                "gender_id": generoC,
                "role_id": 1
              }));
        }
        Navigator.pop(context);
        print(response.body);
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data["error"] != null) {
          Fluttertoast.showToast(msg: data["error"]);
        } else {
          Registro dataM = new Registro.fromJson(data);
          if (password == 1)
            registerUserFirebase(context);
          else {
            await info.setIdUser(dataM.id);
            await info.setNombre(nombresC.text);
            await info.setUsername(userC.text);
            await info.setApellidos(apellidosC.text);
            await info.setGenero("$generoC");
            await info.setRol("1");
            await info.setAPIToken(dataM.apiToken);
            print("Token: ${await info.getAPIToken()}");
            goPrincipal();
          }
        }
      } catch (e) {
        Fluttertoast.showToast(msg: Strings.errorS);
      }
    }

    getData();
  }
  */

}
