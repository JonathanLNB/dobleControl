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

class SignIn extends StatefulWidget {
  int password = 1;

  SignIn();

  SignIn.fromSocial() {
    password = 0;
  }

  SignIn.fromUpdate() {
    password = 2;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _SignIn(password);
  }
}

class _SignIn extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  UserUpdateInfo userUpdate = new UserUpdateInfo();
  TextEditingController nombresC = new TextEditingController();
  TextEditingController correoC = new TextEditingController();
  TextEditingController passwordC = new TextEditingController();
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
      passwordE,
      numTelefonoE,
      numCelularE,
      domicilioE,
      edadE,
      horario;

  _SignIn(this.password);

  @override
  void initState() {
    _dias = new List<String>();
    horaI = new List<String>();
    horaF = new List<String>();
    dias = Strings.iDias;
    horarios = Strings.iHorario;
    horario = false;
    passwordVisible = true;
    nombresE = false;
    correoE = false;
    passwordE = false;
    numTelefonoE = false;
    numCelularE = false;
    domicilioE = false;
    edadE = false;
    config();
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
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                height: 100,
                                width: 400,
                                image:
                                    AssetImage("assets/images/doblecontrol.png"),
                              ),
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
                            getTitulo(context, Strings.diasT),
                            getDias(context),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            getTitulo(context, Strings.horario2),
                            getHora(context, false),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            getTitulo(context, Strings.correo),
                            getCorreo(context),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            password == 1
                                ? getTitulo(context, Strings.password)
                                : Container(),
                            password == 1 ? getPassword(context) : Container(),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
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
                                  password != 2
                                      ? Strings.registrar
                                      : Strings.actualizar,
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

  Future _selectTime() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        if (horario) {
          horaF.add(picked.format(context));
          for (int i = 0; i < horaF.length; i++)
            horarios = "${horaI[i]} - ${horaF[i]}\n";
        } else {
          horaI.add(picked.format(context));
          _selectTime();
        }
        horario = !horario;
      });
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

  Widget getHora(BuildContext context, bool salida) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: Material(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5))),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                horarios,
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.black,
                    fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _selectTime();
      },
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
                    color: AppColors.black,
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
                    color: AppColors.black,
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
                    color: AppColors.black,
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
                    color: AppColors.black,
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
                    color: AppColors.black,
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

  Widget getDias(BuildContext context) {
    return GestureDetector(
      child: Padding(
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
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                dias,
                style: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.black,
                    fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _showDays(context);
      },
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
                    color: AppColors.black,
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

  Widget getPassword(BuildContext context) {
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
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordC,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iPassword,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.black,
                    fontSize: 17),
                errorStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.red,
                    fontSize: 17),
                errorText: passwordE ? Strings.campovacio : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.black,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
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
    if (password == 1) {
      if (passwordC.text.length == 0) {
        access = false;
        passwordE = true;
      } else
        passwordE = false;
    } else
      passwordC.text = "Soc1al";
    return access;
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  Future<void> registerUserFirebase(BuildContext context) async {
    user = (await _auth.createUserWithEmailAndPassword(
            email: correoC.text, password: passwordC.text))
        .user;
    if (!user.isEmailVerified) {
      userUpdate.displayName = nombresC.text;
      user.updateProfile(userUpdate);
      await user.reload();
      getUser().then((user) {
        if (user != null) {
          user.sendEmailVerification();
          showMessage(context);
        }
      });
    }
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

  _showDays(BuildContext context) async {
    ListView getLista(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          bool elegido = false;
          _dias.forEach((dia) {
            if (dia == Strings.dias[index]) {
              elegido = true;
            }
          });
          return Container(
            child: CheckboxListTile(
                title: Text(
                  Strings.dias[index],
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                      color: AppColors.yellowDark),
                ),
                value: elegido,
                onChanged: (bool value) {
                  setState(() {
                    elegido = !elegido;
                  });
                  if (elegido) {
                    setState(() {
                      _dias.add(Strings.dias[index]);
                    });
                  } else {
                    if (_dias.length > 1)
                      for (int i = 0; i < _dias.length; i++) {
                        if (_dias[i] == Strings.dias[index]) {
                          setState(() {
                            _dias.removeWhere((String dia) => dia == Strings.dias[i]);
                            return;
                          });
                        }
                      }
                    else
                      _dias.removeLast();
                  }
                  setState(() {
                    if (_dias.length > 0)
                      dias = _dias.toString();
                    else
                      dias = Strings.iDias;
                  });
                  print("Lista: $_dias");
                  Navigator.pop(context);
                  _showDays(context);
                }),
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: Strings.dias.length,
        addAutomaticKeepAlives: true,
      );
    }

    AlertDialog dialog = AlertDialog(
        title: Text(
          Strings.diasT,
          style: TextStyle(
              fontSize: 18,
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.bold,
              color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 400,
          child: getLista(context),
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/images/email.gif', fit: BoxFit.cover),
              title: Text(
                Strings.verificacion,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.yellowDark),
              ),
              description: Text(
                Strings.verificacionInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.yellowDark),
              ),
              onlyOkButton: true,
              buttonOkText: Text(
                Strings.aceptar,
                style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
              ),
              onOkButtonPressed: () {
                _auth.signOut();
                goLogIn();
              },
            ));
  }

  Future config() async {
    //await info.inicializar();
    getUser().then((user) {
      if (user != null) {
        setState(() {
          if (password == 0) nombresC.text = user.displayName;

          if (user.photoUrl != null) {
            if (user.photoUrl.contains("s96-c/"))
              foto = user.photoUrl.split("s96-c/")[0] +
                  user.photoUrl.split("s96-c/")[1];
            else
              foto = user.photoUrl;
          }
          correoC.text = user.email;
        });
      }
    });
  }
}
