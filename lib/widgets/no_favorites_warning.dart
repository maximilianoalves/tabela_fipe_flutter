import 'package:flutter/material.dart';

class NoFavoritesWarning extends StatelessWidget {
  NoFavoritesWarning({
    Key key,
  }) : super(key: key);

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
            color: Colors.yellow[900],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Nenhum favorito cadastrado.",
            key: Key('error-message'),
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
