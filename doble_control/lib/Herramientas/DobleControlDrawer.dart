import 'package:doble_control/Actividades/Alumnos.dart';
import 'package:doble_control/Actividades/Ayuda.dart';
import 'package:doble_control/Actividades/ListarPersonas.dart';
import 'package:doble_control/Actividades/LogIn.dart';
import 'package:doble_control/Actividades/Principal.dart';
import 'package:doble_control/Actividades/Reservaciones.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Strings.dart';
import 'appColors.dart';

class DobleControlDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _DobleControlDrawer();
  }
}

class _DobleControlDrawer extends State<DobleControlDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String nombre;
  String email;
  String foto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombre = "";
    email = "";
    foto = Strings.fotoPersona;
    configuracion();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text(nombre,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorAccent)),
            accountEmail: Text(
              email,
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorAccent),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: foto != null
                  ? NetworkImage(foto)
                  : AssetImage("assets/images/fotopersona.png"),
            ),
            decoration: BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/driver.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            title: Text(Strings.pendientes,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.black)),
            trailing: Icon(
              Icons.calendar_today,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Principal()),
                  ModalRoute.withName('/principal'));
            },
          ),
          ListTile(
            title: Text(Strings.nuevoCurso,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.black)),
            trailing: Icon(
              Icons.add,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Alumnos()));
            },
          ),
          ListTile(
            title: Text(Strings.instructores,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.black)),
            trailing: Icon(
              Icons.contact_mail,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListarPersonas(true)));
            },
          ),
          ListTile(
            title: Text(Strings.misClientes,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.black)),
            trailing: Icon(
              Icons.people,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListarPersonas(false)));
            },
          ),
          ListTile(
            title: Text(Strings.reservaciones,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.black)),
            trailing: Icon(
              Icons.perm_contact_calendar,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Reservaciones()));
            },
          ),
          ListTile(
            title: Text(Strings.ayuda,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.black)),
            trailing: Icon(
              Icons.help,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Ayuda()));
            },
          ),
          ListTile(
            title: Text(Strings.cerrarS,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.red)),
            trailing: Icon(
              Icons.exit_to_app,
              color: AppColors.red,
            ),
            onTap: () {
              cerrarSesion(context);
            },
          )
        ],
      ),
    );
  }

  void cerrarSesion(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/images/sea.gif', fit: BoxFit.cover),
              title: Text(
                Strings.confirmacion,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.green),
              ),
              description: Text(
                '¿${nombre} estás segur@ de cerrar tu sesión ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "GoogleSans",
                    color: AppColors.green),
              ),
              buttonCancelText: Text(
                Strings.cancelar,
                style: TextStyle(
                    fontFamily: "GoogleSans", color: AppColors.colorAccent),
              ),
              buttonOkText: Text(
                Strings.aceptar,
                style: TextStyle(
                    fontFamily: "GoogleSans", color: AppColors.colorAccent),
              ),
              onOkButtonPressed: () {
                _googleSignIn.signOut();
                _auth.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                    ModalRoute.withName('/logIn'));
              },
            ));
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  Future configuracion() async {
    getUser().then((user) {
      if (user != null) {
        setState(() {
          nombre = user.displayName;
          email = user.email;
          if (user.photoUrl != null) {
            if (user.photoUrl.contains("s96-c/"))
              foto = user.photoUrl.split("s96-c/")[0] +
                  user.photoUrl.split("s96-c/")[1];
            else
              foto = user.photoUrl + "?height=500&width=500";
          }
        });
      }
    });
  }
}
