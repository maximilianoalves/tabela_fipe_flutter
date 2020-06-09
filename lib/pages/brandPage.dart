import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/pages/modelPage.dart';
import 'package:tabela_fipe_flutter/models/brand.dart';
import 'package:tabela_fipe_flutter/service/fipeService.dart';

class BrandPage extends StatefulWidget {
  final String title;

  BrandPage(
    {
      Key key,
      @required this.title
    }) : super(key: key);

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  Future<List<Brand>> futureBrand;

  @override
  void initState() { 
    super.initState();
    futureBrand = FipeService().getBrands(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.title.toUpperCase()),),
      body: FutureBuilder<List<Brand>>(
        future: futureBrand,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return new GestureDetector(
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (BuildContext context) => ModelPage(
                      type: widget.title, 
                      modelId: snapshot.data[index].id,
                      modelName: snapshot.data[index].name
                    ))
                  ),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        snapshot.data[index].name,
                        key: Key('brand-${snapshot.data[index].name}'),
                        style: TextStyle(
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.announcement, size: 50,),
                  Text(
                    "Impossível buscar suas informações.",
                    key: Key('error-message'),
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                ],
              ),
            );
          }

          // By default, show a loading spinner.
          return Center(
            child: CircularProgressIndicator(),
          );
      })
    );
  }
}