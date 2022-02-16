import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as V;

class Exercice2_2Page extends StatefulWidget {
  const Exercice2_2Page({Key? key}) : super(key: key);
  @override
  State<Exercice2_2Page> createState() => _Exercice2_2Page();
}

class _Exercice2_2Page extends State<Exercice2_2Page>
    with TickerProviderStateMixin {
  late AnimationController _controllerImage;
  late AnimationController _controllerFloatingActionButton;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  final Curve _curve = Curves.easeOut;

  double _rotationX = 0.0;
  double _rotationY = 0.0;
  double _rotationZ = 0.0;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _controllerImage =
        AnimationController(vsync: this, duration: Duration(milliseconds: 50));
    _controllerImage.addListener(animateImage);

    _controllerFloatingActionButton =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_controllerFloatingActionButton);
    _animateColor = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _controllerFloatingActionButton,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controllerFloatingActionButton.dispose();
    _controllerImage.dispose();
    super.dispose();
  }

  void animateImage() {
    setState(() {
      _rotationX = (_rotationX + 0.001 + math.pi / 2) % math.pi - math.pi / 2;
      _rotationY = (_rotationY + 0.002 + math.pi / 2) % math.pi - math.pi / 2;
      _rotationZ = (_rotationZ + 0.003 + math.pi) % (2 * math.pi) - math.pi;
    });
  }

  Row rowWithSlider(String text, double min, double max, Function() funcValue,
      Function(double) funcOnChanged) {
    return Row(
      children: [
        Text(text),
        Expanded(
          child: Slider(
            value: funcValue(),
            min: min,
            max: max,
            onChanged: funcOnChanged,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercice 2.b"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Transform(
                    alignment: Alignment.center,
                    transform:
                        V.Matrix4.diagonal3(V.Vector3(_scale, _scale, _scale))
                          ..rotateX(_rotationX)
                          ..rotateY(_rotationY)
                          ..rotateZ(_rotationZ),
                    child:
                        Container(child: Image.asset('assets/image/Bear.png')),
                  )),
              rowWithSlider('RotateX :', -math.pi / 2, math.pi / 2, () {
                return _rotationX;
              }, (double value) {
                setState(() {
                  _rotationX = value;
                });
              }),
              rowWithSlider('RotateY :', -math.pi / 2, math.pi / 2, () {
                return _rotationY;
              }, (double value) {
                setState(() {
                  _rotationY = value;
                });
              }),
              rowWithSlider('RotateZ :', -math.pi / 2, math.pi / 2, () {
                return _rotationZ;
              }, (double value) {
                setState(() {
                  _rotationZ = value;
                });
              }),
              rowWithSlider('Scale   :', 0.0, 3, () {
                return _scale;
              }, (double value) {
                setState(() {
                  _scale = value;
                });
              }),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controllerImage.isAnimating) {
            _controllerImage.reset();
            _controllerFloatingActionButton.reverse();
          } else {
            _controllerImage.repeat();
            _controllerFloatingActionButton.forward();
          }
        },
        backgroundColor: _animateColor.value,
        child: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _animateIcon,
        ),
      ),
    );
  }
}
