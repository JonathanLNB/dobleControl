import 'package:doble_control/Actividades/LogIn.dart';
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
        '/principal': (BuildContext context) => new SignIn(),
        '/logIn': (BuildContext context) => new LogIn(),
      },
      home: Scaffold(
        body: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: LogIn(),
          image: Image.asset("assets/images/logo.jpg"),
          photoSize: 60,
          loaderColor: AppColors.yellow,
        ),
      ),
    );
  }
}
