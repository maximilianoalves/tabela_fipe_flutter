import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/models/carModel.dart';
import 'package:tabela_fipe_flutter/pages/fuelAndYears.dart';
import 'package:tabela_fipe_flutter/service/fipeService.dart';

class ModelPage extends StatefulWidget {
  final int brandId;
  final String modelName;
  final String type;

  ModelPage(
      {
        Key key,
        @required this.brandId,
        @required this.modelName,
        @required this.type
      }) : super(key: key);

  @override
  _ModelPageState createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  Future<List<CarModel>> futureCarModel;
  Future<List<CarModel>> futureFilteredCarModel;


  @override
  void initState() {
    super.initState();
    futureCarModel = FipeService().getModels(
        widget.type.toLowerCase(),
        widget.brandId.toString()
    );
    futureFilteredCarModel = futureCarModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(this.widget.modelName),),
        body: FutureBuilder<List<CarModel>>(
            future: futureFilteredCarModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column (
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
                            hintText: 'Pesquisar por modelos'
                        ),
                        onChanged: (string) {
                          setState(() {
                            futureFilteredCarModel = futureCarModel.then((value) {
                              return value.where((el) => (
                                  el.fipeName.toLowerCase().contains(string.toLowerCase()))).toList();
                            });
                          });
                        },
                      ),
                    ),
                    Expanded (
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return new GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => FuelAndYearsPage(
                                  modelId: snapshot.data[index].id,
                                  brandId: widget.brandId,
                                  modelName: snapshot.data[index].name,
                                  type: widget.type,
                                ))
                            ),
                            child: Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index].fipeName??'Nome não informado',
                                    key: Key('model-$index'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )
                            ),
                          );
                        },
                      ),
                    )
                  ],
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