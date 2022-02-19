import 'package:flutter/material.dart';

class Tile {
  Widget widgetOriginal;
  Alignment alignment;
  double widthFactor;
  double heightFactor;

  Tile(
      {required this.widgetOriginal,
      required this.alignment,
      this.widthFactor = 0.3,
      this.heightFactor = 0.3});

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

Image imageGlobal = Image.asset('assets/image/Bear.png',
    width: 450, height: 450, fit: BoxFit.cover);

Tile tile = Tile(
    widgetOriginal: imageGlobal, alignment: const FractionalOffset(0.3, 0.3));

class Exercice4Page extends StatelessWidget {
  const Exercice4Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercice 4"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: Container(
                      margin: EdgeInsets.all(20.0), child: tile.getTile()),
                ),
                imageGlobal,
              ],
            ),
          )),
    );
  }
}
