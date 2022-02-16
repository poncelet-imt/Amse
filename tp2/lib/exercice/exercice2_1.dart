import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as V;

class Exercice2_1Page extends StatefulWidget {
  const Exercice2_1Page({Key? key}) : super(key: key);
  @override
  State<Exercice2_1Page> createState() => _Exercice2_1Page();
}

class _Exercice2_1Page extends State<Exercice2_1Page> {
  double _rotationX = 0.0;
  double _rotationY = 0.0;
  double _rotationZ = 0.0;
  double _scale = 1.0;

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
        title: const Text("Exercice 2.a"),
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
              rowWithSlider('RotateZ :', -math.pi, math.pi, () {
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
    );
  }
}
