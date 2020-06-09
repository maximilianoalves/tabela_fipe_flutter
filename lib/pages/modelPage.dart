import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/models/carModel.dart';
import 'package:tabela_fipe_flutter/pages/modelsAndYearsPage.dart';
import 'package:tabela_fipe_flutter/service/fipeService.dart';

class ModelPage extends StatefulWidget {
  final int modelId;
  final String modelName;
  final String type;

  ModelPage(
    {
      Key key,
      @required this.modelId,
      @required this.modelName,
      @required this.type
    }) : super(key: key);

  @override
  _ModelPageState createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  Future<List<CarModel>> futureCarModel;

  @override
  void initState() { 
    super.initState();
    futureCarModel = FipeService().getModels(
      widget.type.toLowerCase(), 
      widget.modelId.toString()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.modelName),),
      body: FutureBuilder<List<CarModel>>(
        future: futureCarModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return new GestureDetector(
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (BuildContext context) => ModelAndYearsPage(
                      modelAndYearsId: snapshot.data[index].id,
                      modelId: widget.modelId,
                      modelName: snapshot.data[index].name,
                      type: widget.type, 
                    ))
                  ),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        snapshot.data[index].fipeName??'Nome não informado',
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
                  Text("Impossível buscar suas informações.", style: TextStyle(
                    fontSize: 20
                  ),),
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