import 'package:flutter/material.dart';

class ErrorOnSearching extends StatelessWidget {
  ErrorOnSearching({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            Icons.announcement,
            size: 50,
          ),
          Text(
            "Impossível buscar suas informações.",
            key: Key('error-message'),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
