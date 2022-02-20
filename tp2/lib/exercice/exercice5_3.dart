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

Image imageGlobal = Image.asset('assets/image/Bear.png',
    width: 450, height: 450, fit: BoxFit.cover);

class BoardGrid extends StatefulWidget {
  final int width;
  final int height;
  final double widthTile;
  final double heightTile;

  const BoardGrid(
      {required this.width,
      required this.height,
      required this.widthTile,
      required this.heightTile,
      Key? key})
      : super(key: key);

  @override
  State<BoardGrid> createState() => _BoardGrid(
      width: width,
      height: height,
      widthTile: widthTile,
      heightTile: heightTile);
}

class _BoardGrid extends State<BoardGrid> {
  late List<Tile> tilesList;
  int width;
  int height;
  double widthTile;
  double heightTile;

  _BoardGrid(
      {required this.width,
      required this.height,
      required this.heightTile,
      required this.widthTile});

  @override
  void initState() {
    super.initState();
    tilesList = <Tile>[
      for (var j = 0; j < height; j++)
        for (var i = 0; i < width; i++)
          Tile(
              widgetOriginal: imageGlobal,
              alignment: FractionalOffset(i / (width - 1), j / (height - 1)),
              widthFactor: 1 / width,
              heightFactor: 1 / height)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: width,
      children: <Widget>[
        for (var tile in tilesList)
          SizedBox(
            width: heightTile,
            height: widthTile,
            child: Container(child: tile.getTile()),
          )
      ],
    );
  }
}

class Exercice5_3Page extends StatefulWidget {
  const Exercice5_3Page({Key? key}) : super(key: key);
  @override
  State<Exercice5_3Page> createState() => _Exercice5_3Page();
}

class _Exercice5_3Page extends State<Exercice5_3Page> {
  int _size = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercice 5.c"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [
              BoardGrid(
                height: _size,
                width: _size,
                heightTile: 150,
                widthTile: 150,
                key: ValueKey<int>(_size),
              ),
              Row(
                children: [
                  Text('size'),
                  Expanded(
                    child: Slider(
                      value: _size.toDouble(),
                      min: 2,
                      max: 10,
                      divisions: 8,
                      label: _size.toString(),
                      onChanged: (double value) {
                        setState(() {
                          _size = value.toInt();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
