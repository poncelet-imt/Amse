import 'package:flutter/material.dart';

class Tile {
  Widget widgetOriginal;
  Alignment alignment;
  double widthFactor;
  double heightFactor;

  Tile(
      {required this.widgetOriginal,
      required this.alignment,
      required this.widthFactor,
      required this.heightFactor});

  Widget getTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: alignment,
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            child: widgetOriginal,
          ),
        ),
      ),
    );
  }
}
