import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  Loader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
