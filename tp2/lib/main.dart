import 'package:flutter/material.dart';
import 'package:tp2/exercice1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TP2'),
    );
  }
}

class ExerciceListItem extends StatelessWidget {
  const ExerciceListItem({
    Key? key,
    required this.title,
    required this.description,
    required this.builderNewPage,
  }) : super(key: key);

  final String title;
  final String description;
  final WidgetBuilder builderNewPage;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.play_arrow),
        isThreeLine: true,
        onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: builderNewPage,
          ),
        );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
    padding: const EdgeInsets.all(8),
    children: <ExerciceListItem>[
      ExerciceListItem(
        title: "Exercice 1",
        description: "Afficher une image",
        builderNewPage: (context) => Exercice1Page(),),
      ExerciceListItem(
        title: "Exercice 2",
        description: "Transformer une image",
        builderNewPage: (context) => Exercice1Page(),),
      ExerciceListItem(
        title: "Exercice 4",
        description: "Affichage d'une tuile (un morceau d'image)",
        builderNewPage: (context) => Exercice1Page(),),
      ExerciceListItem(
        title: "Exercice 5.a",
        description: "Génération du plateau de tuiles où les cases sont des containers",
        builderNewPage: (context) => Exercice1Page(),),
      ExerciceListItem(
        title: "Exercice 5.b",
        description: "Génération du plateau de tuiles où les cases sont des portions de l'image",
        builderNewPage: (context) => Exercice1Page(),),
      ExerciceListItem(
        title: "Exercice 5.c",
        description: "Génération du plateau à nombre de tuiles variables où les cases sont des portions de l'image",
        builderNewPage: (context) => Exercice1Page(),),
      ExerciceListItem(
        title: "Exercice 6.a",
        description: "Animation d'une tuile",
        builderNewPage: (context) => Exercice1Page(),),
      ExerciceListItem(
        title: "Exercice 6.b",
        description: "Génération du plateau de tuiles où on peut échanger les tuiles",
        builderNewPage: (context) => Exercice1Page(),),
      ExerciceListItem(
        title: "Exercice 7",
        description: "Jeu de taquin",
        builderNewPage: (context) => Exercice1Page(),),
    ], 
      ),
    );
  }
}
