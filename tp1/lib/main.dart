import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'ItemDetailPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/list.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  int _indexNavBar = 0;
  final int _indexNavLike = 3;
  final int _numberCategory = 3;

  List<bool> _likeSelect = [];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<String> _labelOptions = ['Movie', 'Book', 'Art', 'Like'];
  static const List<IconData> _iconOptions = <IconData>[
    Icons.local_movies_outlined,
    Icons.book_outlined,
    Icons.brush_outlined,
    Icons.favorite_outline
  ];
  static const List<IconData> _iconSelectedOptions = <IconData>[
    Icons.local_movies,
    Icons.book,
    Icons.brush,
    Icons.favorite
  ];

  void _onItemTapped(int index) {
    setState(() {
      _indexNavBar = index;
    });
  }

  @override
  void initState() {
    _likeSelect = [for (var i = 0; i < _numberCategory; i++) true];
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_labelOptions[_indexNavBar], style: optionStyle),
      ),
      body: Column(
        children: [
          (_indexNavBar == _indexNavLike)
              ? Row(
                  children: [
                    for (var i = 0; i < _numberCategory; i += 1)
                      Expanded(
                          child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          setState(() {
                            _likeSelect[i] = !_likeSelect[i];
                          });
                        },
                        child: Icon(
                          _likeSelect[i]
                              ? _iconSelectedOptions[i]
                              : _iconOptions[i],
                          color: _likeSelect[i] ? Colors.green : Colors.grey,
                        ),
                      ))
                  ],
                )
              : Container(),
          _items.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    itemCount: _items.length,
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      if (_indexNavBar == _items[index]["category"] ||
                          (_indexNavBar == _indexNavLike &&
                              _items[index]["like"] &&
                              _likeSelect[_items[index]["category"]])) {
                        return Container(
                          height: max(80, queryData.size.height / 6),
                          width: queryData.size.width * 0.95,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Row(
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shape: const CircleBorder(),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ItemDetailPage(_items[index])));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/image/' + _items[index]['image'],
                                    width: min(
                                        max(60, queryData.size.height / 6 - 20),
                                        max(10, queryData.size.width / 4 - 20)),
                                    height: min(
                                        max(60, queryData.size.height / 6 - 20),
                                        max(10, queryData.size.width / 4 - 20)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      _items[index]['title'],
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Center(
                                            child:
                                                Text(_items[index]['text']))),
                                  ],
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shape: const CircleBorder(),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _items[index]['like'] =
                                        !_items[index]['like'];
                                  });
                                },
                                child: Icon(
                                  _items[index]['like']
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: _items[index]['like']
                                      ? Colors.pink
                                      : Colors.grey,
                                  size: min(
                                      max(40, queryData.size.height / 6 - 60),
                                      max(10, queryData.size.width / 4 - 60)),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      if (_indexNavBar == _items[index]["category"] ||
                          (_indexNavBar == _indexNavLike &&
                              _items[index]["like"] &&
                              _likeSelect[_items[index]["category"]])) {
                        return const Divider();
                      } else {
                        return Container();
                      }
                    },
                  ),
                )
              : Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          for (var i = 0; i < _labelOptions.length; i++)
            BottomNavigationBarItem(
              icon: Icon(_iconOptions[i]),
              activeIcon: Icon(_iconSelectedOptions[i]),
              label: _labelOptions[i],
            )
        ],
        currentIndex: _indexNavBar,
        unselectedItemColor: Colors.grey[800],
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
