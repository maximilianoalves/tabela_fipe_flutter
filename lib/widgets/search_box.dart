import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final Function onSearchPress;

  SearchBox({
    this.hintText,
    this.onSearchPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          contentPadding: EdgeInsets.all(15.0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blue,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          fillColor: Colors.blue,
          hintText: hintText,
        ),
        onChanged: (string) => onSearchPress(string),
      ),
    );
  }
}
