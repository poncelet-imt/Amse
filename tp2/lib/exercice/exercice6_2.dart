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
  late List<int>
      tilesPosition; // on stock dans cette list quelle tiles est a chaque position
  late int indexMissingTile;
  late int columnMissingTile;
  late int rowMissingTile;

  Object redrawObject = Object();
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

    // on donne l'entier -1 pour la case vide
    // le reste des entiers sont l'indice des tiles dans tilesList
    tilesPosition = <int>[for (var i = 0; i < height * width - 1; i++) i];
    tilesPosition.add(-1);
    indexMissingTile = height * width - 1;
    rowMissingTile = height - 1;
    columnMissingTile = width - 1;
  }

  void moveTile(int indexTile) {
    int column = indexTile % width;
    int row = indexTile ~/ width;

    if ((column == columnMissingTile) && (row == rowMissingTile)) {
    } else if (row == rowMissingTile) {
      if (column > columnMissingTile) {
        for (int i = columnMissingTile; i < column; i++) {
          tilesPosition[row * width + i] = tilesPosition[row * width + (i + 1)];
        }
      } else {
        for (int i = columnMissingTile; i > column; i--) {
          tilesPosition[row * width + i] = tilesPosition[row * width + (i - 1)];
        }
      }

      tilesPosition[row * width + column] = -1;
      columnMissingTile = column;
      setState(() {
        redrawObject = Object();
      });
    } else if (column == columnMissingTile) {
      if (row > rowMissingTile) {
        for (int i = rowMissingTile; i < row; i++) {
          tilesPosition[i * width + column] =
              tilesPosition[(i + 1) * width + column];
        }
      } else {
        for (int i = rowMissingTile; i > row; i--) {
          tilesPosition[i * width + column] =
              tilesPosition[(i - 1) * width + column];
        }
      }
      tilesPosition[row * width + column] = -1;
      rowMissingTile = row;
      setState(() {
        redrawObject = Object();
      });
    }
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
      key: ValueKey<Object>(redrawObject),
      children: <Widget>[
        for (int i = 0; i < tilesPosition.length; i++)
          SizedBox(
            width: heightTile,
            height: widthTile,
            child: InkWell(
              key: ValueKey<Object>(redrawObject),
              onTap: () {
                moveTile(i);
              },
              child: (tilesPosition[i] >= 0)
                  ? Container(child: tilesList[tilesPosition[i]].getTile())
                  : SizedBox(width: heightTile, height: widthTile),
            ),
          )
      ],
    );
  }
}

class Exercice6_2Page extends StatefulWidget {
  const Exercice6_2Page({Key? key}) : super(key: key);
  @override
  State<Exercice6_2Page> createState() => _Exercice6_2Page();
}

class _Exercice6_2Page extends State<Exercice6_2Page> {
  int _size = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercice 6.b"),
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
