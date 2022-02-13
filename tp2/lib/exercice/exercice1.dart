import 'package:flutter/material.dart';



class Exercice1Page extends StatelessWidget {
  // In the constructor, require a Todo.
  const Exercice1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 1"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("alpha_test"),
      ),
    );
  }
}