import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/pages/modelPage.dart';
import 'package:tabela_fipe_flutter/models/brand.dart';
import 'package:tabela_fipe_flutter/service/fipeService.dart';

class BrandPage extends StatefulWidget {
  final String type;

  BrandPage(
    {
      Key key,
      @required this.type
    }) : super(key: key);

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  Future<List<Brand>> futureBrand;
  Future<List<Brand>> futureFilteredBrand;

  @override
  void initState() { 
    super.initState();
    futureBrand = FipeService().getBrands(widget.type);
    futureFilteredBrand = futureBrand;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.type.toUpperCase()),),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15.0),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  hintText: 'Pesquisar por marcas'
              ),
              onChanged: (string) {
                setState(() {
                  futureFilteredBrand = futureBrand.then((value) {
                    return value.where((el) => (
                      el.name.toLowerCase().contains(string.toLowerCase()))).toList();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Brand>>(
            future: futureFilteredBrand,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return new GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => ModelPage(
                              type: widget.type,
                              brandId: snapshot.data[index].id,
                              modelName: snapshot.data[index].name
                          ))
                      ),
                      child: Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              snapshot.data[index].name,
                              key: Key('brand-${snapshot.data[index].name.toLowerCase()}'),
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
            }),
          )
        ],
      )
    );
  }
}