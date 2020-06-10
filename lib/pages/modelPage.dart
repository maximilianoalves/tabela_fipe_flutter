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

  @override
  void initState() { 
    super.initState();
    futureCarModel = FipeService().getModels(
      widget.type.toLowerCase(), 
      widget.brandId.toString()
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