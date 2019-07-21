import 'dart:io';

import 'package:doble_control/Herramientas/appColors.dart';
import 'package:doble_control/Herramientas/custom_shape_clipper.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  bool tipo = false;
  NavigationBar(this.tipo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        height: tipo ? 450 : Platform.isIOS ? 125 : 125,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.yellowDark,
              AppColors.yellow,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
