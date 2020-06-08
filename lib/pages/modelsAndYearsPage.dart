import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/models/carModelsAndYears.dart';
import 'package:tabela_fipe_flutter/pages/resultFipePage.dart';
import 'package:tabela_fipe_flutter/service/fipeService.dart';

class ModelAndYearsPage extends StatefulWidget {
  final String modelName;
  final int modelId;
  final String modelAndYearsId;
  final String type;

  const ModelAndYearsPage({
    Key key, 
    @required this.modelName, 
    @required this.modelId, 
    @required this.modelAndYearsId,
    @required this.type
  }) : super(key: key);


  @override
  _ModelAndYearsPageState createState() => _ModelAndYearsPageState();
}

class _ModelAndYearsPageState extends State<ModelAndYearsPage> {
  Future<List<CarModelsAndYears>> futureCarModelsAndYears;

  @override
  void initState() { 
    super.initState();
    futureCarModelsAndYears = FipeService().getModelsAndYears(
      widget.type, 
      widget.modelId.toString(), 
      widget.modelAndYearsId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.modelName),),
      body: FutureBuilder<List<CarModelsAndYears>>(
        future: futureCarModelsAndYears,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return new GestureDetector(
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (BuildContext context) => ResultFipePage(
                      type: widget.type,
                      modelId: widget.modelId.toString(),
                      modelsAndYearsId: widget.modelAndYearsId,
                      modelAndYearId: snapshot.data[index].id,
                      modelName: snapshot.data[index].name,
                    ))
                  ),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        snapshot.data[index].name,
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
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      )
    );
  }
}