import 'package:flutter/material.dart';
import 'boardGrid.dart';

Color colorText = Color.fromARGB(255, 236, 236, 236);
Color colorButton1 = Color.fromARGB(255, 255, 24, 24);
Color colorButton2 = Color.fromARGB(255, 24, 255, 255);
Color colorBackground = Color.fromARGB(255, 84, 99, 255);
Color colorWin = Color.fromARGB(255, 255, 195, 0);
Color colorGame = Color.fromARGB(255, 118, 130, 255);

Image imageGlobal = Image.asset('assets/image/Bear.png',
    width: 450, height: 450, fit: BoxFit.cover);

class MainGame extends StatefulWidget {
  const MainGame({Key? key}) : super(key: key);
  @override
  State<MainGame> createState() => _MainGame();
}

class _MainGame extends State<MainGame> with SingleTickerProviderStateMixin {
  bool menuOpen = false;
  late AnimationController _controllerFloatingActionButton;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  final Curve _curve = Curves.easeOut;
  Duration duration = const Duration(milliseconds: 500);
  double _fabHeight = 56.0;

  BoardGridControler myController = BoardGridControler();

  int _size = 3;
  bool asWin = false;
  int countMove = 0;

  @override
  initState() {
    _controllerFloatingActionButton =
        AnimationController(vsync: this, duration: duration)
          ..addListener(() {
            setState(() {});
          });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_controllerFloatingActionButton);
    _animateColor = ColorTween(
      begin: colorButton2,
      end: colorButton1,
    ).animate(CurvedAnimation(
      parent: _controllerFloatingActionButton,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _controllerFloatingActionButton,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _controllerFloatingActionButton.dispose();
    super.dispose();
  }

  Widget add() {
    return Visibility(
      visible: menuOpen,
      child: FloatingActionButton(
        heroTag: "add",
        onPressed: () {
          if (_size < 8) {
            setState(() {
              countMove = 0;
              asWin = false;
              _size++;
            });
          }
          ;
        },
        backgroundColor: colorButton1,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget sub() {
    return Visibility(
      visible: menuOpen,
      child: FloatingActionButton(
        heroTag: "sub",
        onPressed: () {
          if (_size > 2) {
            setState(() {
              countMove = 0;
              asWin = false;
              _size--;
            });
          }
          ;
        },
        backgroundColor: colorButton1,
        tooltip: 'Sub',
        child: Icon(Icons.remove),
      ),
    );
  }

  Widget play() {
    return Visibility(
      visible: menuOpen,
      child: FloatingActionButton(
        heroTag: "play",
        onPressed: () {
          myController.resetBoard();
        },
        tooltip: 'Play',
        backgroundColor: colorButton1,
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  Widget toggle() {
    return FloatingActionButton(
      heroTag: "toggle",
      tooltip: 'Toggle',
      onPressed: () {
        if (menuOpen) {
          _controllerFloatingActionButton.reverse();
          Future.delayed(duration, () {
            setState(() {
              menuOpen = false;
            });
          });
        } else {
          _controllerFloatingActionButton.forward();
          menuOpen = true;
        }
      },
      backgroundColor: _animateColor.value,
      child: AnimatedIcon(
        icon: AnimatedIcons.home_menu,
        progress: _animateIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: asWin ? colorWin : colorGame,
        title: Text(
          "Jeu de Tacquin",
          style: TextStyle(
            color: colorText,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
      ),
      body: Container(
        color: asWin ? colorWin : colorBackground,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "Depalcement $countMove",
                    style: TextStyle(
                      color: colorText,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  decoration: BoxDecoration(
                      color: colorGame,
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: BoardGrid(
                    height: _size,
                    width: _size,
                    heightTile: 150,
                    widthTile: 150,
                    image: imageGlobal,
                    notifyMove: (int move) {
                      setState(() {
                        countMove = move;
                      });
                    },
                    notifyWin: (bool win) {
                      setState(() {
                        asWin = win;
                      });
                    },
                    controler: myController,
                    key: ValueKey<int>(_size),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 3.0,
              0.0,
            ),
            child: add(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2.0,
              0.0,
            ),
            child: sub(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 1.0,
              0.0,
            ),
            child: play(),
          ),
          toggle()
        ],
      ),
    );
  }
}
