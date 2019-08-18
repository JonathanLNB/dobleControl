import 'package:doble_control/Actividades/LogIn.dart';
import 'package:doble_control/Actividades/Principal.dart';
import 'package:doble_control/Actividades/SingIn.dart';
import 'package:doble_control/Herramientas/appColors.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doble Control',
      debugShowCheckedModeBanner: false,  
      routes: <String, WidgetBuilder>{
        '/principal': (BuildContext context) => new Principal(),
        '/logIn': (BuildContext context) => new LogIn(),
      },
      home: Scaffold(
        body: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: LogIn(),
          image: Image.asset("assets/images/logo.png"),
          photoSize: 150,
          loaderColor: AppColors.yellow,
        ),
      ),
    );
  }
}
