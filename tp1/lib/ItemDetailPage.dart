import 'dart:math';

import 'package:flutter/material.dart';

import 'PhotoPage.dart';

class ItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> _inforamtion;
  const ItemDetailPage(this._inforamtion, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _inforamtion['title'],
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PhotoPage(_inforamtion['image'])));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/image/' + _inforamtion['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          const Divider(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  width: max(80, queryData.size.height / 6),
                  child: const Text('Title : ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Text(_inforamtion['title']),
                ),
              ],
            ),
          ),
          (!_inforamtion['text']?.isEmpty)
              ? const Divider(
                  height: 8,
                )
              : Container(),
          (!_inforamtion['text']?.isEmpty)
              ? Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: max(80, queryData.size.height / 6),
                        child: const Text('Description : ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: Text(_inforamtion['text']),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
