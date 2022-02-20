import 'package:flutter/material.dart';

const List<Color> ColorsList = <Color>[
  Colors.red,
  Colors.blue,
  Colors.orange,
  Colors.green,
  Colors.lime,
  Colors.purple,
  Colors.indigo,
  Colors.pink,
  Colors.grey,
  Colors.cyan,
  Colors.yellow,
];

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
  State<BoardGrid> createState() => _BoardGrid();
}

class _BoardGrid extends State<BoardGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: widget.width,
      children: <Widget>[
        for (var i = 0; i < widget.width; i++)
          for (var j = 0; j < widget.height; j++)
            Container(
              width: widget.widthTile,
              height: widget.heightTile,
              color: ColorsList[(j * 3 + i * 5) % ColorsList.length],
              child: Center(
                child: Text("container ($j, $i)"),
              ),
            )
      ],
    );
  }
}

class Exercice5_1Page extends StatefulWidget {
  const Exercice5_1Page({Key? key}) : super(key: key);
  @override
  State<Exercice5_1Page> createState() => _Exercice5_1Page();
}

class _Exercice5_1Page extends State<Exercice5_1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercice 5.a"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: BoardGrid(
            height: 4,
            width: 4,
            heightTile: 150,
            widthTile: 150,
          ),
        ),
      ),
    );
  }
}
