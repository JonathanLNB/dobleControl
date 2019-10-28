import 'dart:io';

import 'package:doble_control/Actividades/Principal.dart';
import 'package:doble_control/Actividades/SingIn.dart';
import 'package:doble_control/Herramientas/Progress.dart';
import 'package:doble_control/Herramientas/Strings.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LogIn();
  }
}

class _LogIn extends State<LogIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging firebase = new FirebaseMessaging();
  UserUpdateInfo userUpdate = new UserUpdateInfo();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  TextEditingController correoC = new TextEditingController();
  TextEditingController passwordC = new TextEditingController();
  TextEditingController _emailR = TextEditingController();

  bool _success;
  int idUser;
  String _userID, token, email, foto;
  bool passwordVisible;
  bool dialogo;

  @override
  void initState() {
    passwordVisible = true;
    getUser().then((user) {
      if (user != null) {
        if (idUser != 0)
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Principal()),
              ModalRoute.withName('/principal'));
        else {
          _googleSignIn.signOut();
          _auth.signOut();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/images/fondo.png"),
                fit: BoxFit.none,
                repeat: ImageRepeat.repeat),
          ),
        ),
        NavigationBar(true),
        Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: Platform.isAndroid
                ? EdgeInsets.only(top: 120)
                : EdgeInsets.only(top: 120),
            child: Text(
              Strings.bienvenido,
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
                                image: AssetImage(
                                    "assets/images/doblecontrol.png"),
                              ),
                            ),
                            Text(
                              Strings.correo,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "GoogleSans",
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.red),
                              textAlign: TextAlign.center,
                            ),
                            getCorreo(context),
                            Padding(
                              padding: EdgeInsets.all(12),
                            ),
                            Text(
                              Strings.password,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "GoogleSans",
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.red),
                              textAlign: TextAlign.center,
                            ),
                            getPassword(context),
                            Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 12),
                            ),
                            GestureDetector(
                              onTap: () {
                                _displayForgotPassword(context);
                              },
                              child: Text(
                                Strings.recuperarPassword,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "GoogleSans",
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: new RaisedButton(
                                onPressed: () async {
                                  _signInWithEmailPassword();
                                },
                                child: Text(
                                  Strings.ingresar,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "GoogleSans",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorAccent),
                                  textAlign: TextAlign.center,
                                ),
                                color: AppColors.green,
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
              textInputAction: TextInputAction.next,
              controller: correoC,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.iCorreo,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.black,
                    fontSize: 17),
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
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
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

  void showMessage(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/images/email.gif', fit: BoxFit.cover),
              title: Text(
                dialogo ? Strings.resetPassword : Strings.verificacion,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.yellowDark),
              ),
              description: Text(
                dialogo ? Strings.resetPasswordInfo : Strings.verificacionInfo,
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
                if (!dialogo) {
                  _auth.signOut();
                  Navigator.pop(context);
                } else
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                      ModalRoute.withName('/logIn'));
              },
            ));
  }

  void salir(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/images/cerrar.gif', fit: BoxFit.cover),
              title: Text(
                Strings.salir,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.yellowDark),
              ),
              description: Text(
                Strings.salirInfo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.yellowDark),
              ),
              buttonCancelText: Text(
                Strings.cancelar,
                style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
              ),
              buttonOkText: Text(
                Strings.aceptar,
                style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
              ),
              onOkButtonPressed: () {
                Platform.isAndroid ? SystemNavigator.pop() : exit(0);
              },
            ));
  }

  void errorLogin(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/images/sea.gif', fit: BoxFit.cover),
              title: Text(
                Strings.errorLogIn,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.yellowDark),
              ),
              description: Text(
                Strings.errorC,
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
                Navigator.pop(context);
              },
            ));
  }

  Future<bool> onBackPress() {
    salir(context);
    return Future.value(false);
  }

  _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user != null) {
      _success = true;
      _userID = user.uid;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _onLoading(context),
      );
      //logInAPI(currentUser.email, true);
      foto = currentUser.photoUrl;
    } else {
      _success = false;
    }
  }

  _signInWithEmailPassword() async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: correoC.text, password: passwordC.text))
        .user;
    userUpdate.displayName = "Doble Control";
    user.updateProfile(userUpdate);
    await user.reload();
    assert(user.email != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user != null) {
      _success = true;
      _userID = user.uid;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _onLoading(context),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Principal()),
          ModalRoute.withName('/principal'));
    } else {
      _success = false;
    }
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

  _displayForgotPassword(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              Strings.recuperarPassword,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.yellowDark),
              textAlign: TextAlign.center,
            ),
            content: TextField(
              controller: _emailR,
              decoration: InputDecoration(
                hintText: Strings.iCorreo,
                hintStyle: TextStyle(
                    fontFamily: "GoogleSans",
                    color: AppColors.grey,
                    fontSize: 17),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.email,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text(
                  Strings.cancelar,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorAccent),
                  textAlign: TextAlign.center,
                ),
                color: AppColors.yellowDark,
              ),
              RaisedButton(
                onPressed: () async {
                  if (_emailR.text.length > 0) {
                    _auth.sendPasswordResetEmail(email: _emailR.text);
                    dialogo = true;
                    showMessage(context);
                  } else
                    Fluttertoast.showToast(msg: Strings.campovacio);
                },
                child: Text(
                  Strings.aceptar,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorAccent),
                  textAlign: TextAlign.center,
                ),
                color: AppColors.yellowDark,
              ),
            ],
          );
        });
  }

  Future goPrincipal() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Principal()),
        ModalRoute.withName('/principal'));
  }

  void goSignIn(bool social) {
    if (social)
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignIn.fromSocial()),
          ModalRoute.withName('/signIn'));
    else
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }
}
