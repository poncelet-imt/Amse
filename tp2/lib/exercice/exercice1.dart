import 'package:flutter/material.dart';



class Exercice1Page extends StatelessWidget {
  const Exercice1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercice 1"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset('assets/image/Bear.png'),
      ),
    );
  }
}