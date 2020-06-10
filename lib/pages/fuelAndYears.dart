import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/models/carFuelAndYears.dart';
import 'package:tabela_fipe_flutter/pages/resultFipePage.dart';
import 'package:tabela_fipe_flutter/service/fipeService.dart';

class FuelAndYearsPage extends StatefulWidget {
  final String modelName;
  final int brandId;
  final String modelId;
  final String type;

  const FuelAndYearsPage({
    Key key, 
    @required this.modelName, 
    @required this.brandId,
    @required this.modelId,
    @required this.type
  }) : super(key: key);


  @override
  _FuelAndYearsPageState createState() => _FuelAndYearsPageState();
}

class _FuelAndYearsPageState extends State<FuelAndYearsPage> {
  Future<List<CarFuelAndYears>> futureCarFuelAndYears;

  @override
  void initState() { 
    super.initState();
    futureCarFuelAndYears = FipeService().getFuelAndYears(
      widget.type, 
      widget.brandId.toString(),
      widget.modelId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.modelName),),
      body: FutureBuilder<List<CarFuelAndYears>>(
        future: futureCarFuelAndYears,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return new GestureDetector(
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (BuildContext context) => ResultFipePage(
                      type: widget.type,
                      brandId: widget.brandId.toString(),
                      modelId: widget.modelId,
                      fuelAndYearsId: snapshot.data[index].id,
                      modelName: snapshot.data[index].name,
                    ))
                  ),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        snapshot.data[index].name,
                        key: Key('fuelAndYears-$index'),
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
        }
      )
    );
  }
}