import 'package:flutter/material.dart';

class PhotoPage extends StatelessWidget {
  final String _name;
  const PhotoPage(this._name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Image.asset(
            'assets/image/' + _name,
            width: queryData.size.height,
            height: queryData.size.height,
            fit: BoxFit.contain,
          ),
        ));
  }
}
