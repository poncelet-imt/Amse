import 'dart:math';

import 'package:flutter/material.dart';

import 'tile.dart';

class BoardGridControler {
  late void Function() resetBoard;
}

class BoardGrid extends StatefulWidget {
  final int width;
  final int height;
  final double widthTile;
  final double heightTile;
  final Image image;
  final Function notifyWin;
  final Function notifyMove;
  final BoardGridControler controler;

  const BoardGrid(
      {required this.width,
      required this.height,
      required this.widthTile,
      required this.heightTile,
      required this.image,
      required this.notifyWin,
      required this.notifyMove,
      required this.controler,
      Key? key})
      : super(key: key);

  @override
  State<BoardGrid> createState() => _BoardGrid(controler,
      width: width,
      height: height,
      widthTile: widthTile,
      heightTile: heightTile,
      image: image);
}

class _BoardGrid extends State<BoardGrid> {
  late List<Tile> tilesList;
  late List<int>
      tilesPosition; // on stock dans cette list quelle tiles est a chaque position
  late int columnMissingTile;
  late int rowMissingTile;
  late int move;
  late bool asWin;

  Object redrawObject = Object();
  int width;
  int height;
  double widthTile;
  double heightTile;
  Image image;

  _BoardGrid(BoardGridControler _controler,
      {required this.width,
      required this.height,
      required this.heightTile,
      required this.widthTile,
      required this.image}) {
    _controler.resetBoard = resetBoard;
  }

  @override
  void initState() {
    super.initState();
    tilesList = <Tile>[
      for (var j = 0; j < height; j++)
        for (var i = 0; i < width; i++)
          Tile(
              widgetOriginal: image,
              alignment: FractionalOffset(i / (width - 1), j / (height - 1)),
              widthFactor: 1 / width,
              heightFactor: 1 / height)
    ];

    // on donne l'entier -1 pour la case vide
    // le reste des entiers sont l'indice des tiles dans tilesList
    tilesPosition = <int>[for (var i = 0; i < height * width - 1; i++) i];
    tilesPosition.add(-1);
    randomBoard();
    asWin = false;
    move = 0;
  }

  void resetBoard() {
    tilesPosition[tilesPosition.length - 1] = -1;
    randomBoard();
    asWin = false;
    widget.notifyWin(false);
    move = 0;
  }

  bool solvable() {
    // https://www.geeksforgeeks.org/check-instance-15-puzzle-solvable/

    int countPermutation = 0;
    for (var i = 0; i < tilesPosition.length; i++) {
      for (var j = i + 1; j < tilesPosition.length; j++) {
        if (tilesPosition[i] > tilesPosition[j] && tilesPosition[j] != -1) {
          countPermutation++;
        }
      }
    }
    if (width % 2 == 0) {
      return (countPermutation % 2 != (tilesPosition.indexOf(-1) ~/ width) % 2);
    } else {
      return (countPermutation % 2 == 0);
    }
  }

  void randomBoard() {
    int indexMissing;
    tilesPosition.shuffle();
    while (!solvable()) {
      tilesPosition.shuffle();
    }
    indexMissing = tilesPosition.indexOf(-1);
    rowMissingTile = indexMissing ~/ width;
    columnMissingTile = indexMissing % width;
    redrawObject = Object();
  }

  bool checkWin() {
    for (var i = 0; i < tilesPosition.length - 1; i++) {
      if (tilesPosition[i] != i) {
        return false;
      }
    }
    return true;
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
      move++;
      widget.notifyMove(move);
      if (checkWin()) {
        tilesPosition[tilesPosition.length - 1] = tilesPosition.length - 1;
        asWin = true;
        widget.notifyWin(true);
      }
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
      move++;
      widget.notifyMove(move);
      if (checkWin()) {
        tilesPosition[tilesPosition.length - 1] = tilesPosition.length - 1;
        asWin = true;
        widget.notifyWin(true);
      }
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
                if (!asWin) {
                  moveTile(i);
                }
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
