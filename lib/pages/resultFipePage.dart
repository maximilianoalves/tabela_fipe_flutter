import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/models/car.dart';
import 'package:tabela_fipe_flutter/service/fipeService.dart';

class ResultFipePage extends StatefulWidget {
  final String type;
  final String modelId;
  final String modelsAndYearsId;
  final String modelAndYearId;
  final String modelName;

  const ResultFipePage({
    Key key, 
    @required this.type, 
    @required this.modelId, 
    @required this.modelsAndYearsId, 
    @required this.modelAndYearId,
    @required this.modelName
  }) : super(key: key);


  @override
  _ResultFipePageState createState() => _ResultFipePageState();
}

class _ResultFipePageState extends State<ResultFipePage> {
  Future<Car> futureCar;

  @override
  void initState() { 
    super.initState();
    futureCar = FipeService().getResultFipe(
      widget.type.toLowerCase(), 
      widget.modelId.toString(), 
      widget.modelsAndYearsId, 
      widget.modelAndYearId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.widget.modelName),),
      body: FutureBuilder<Car>(
        future: futureCar,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(
              elevation: 3,
              child: ListTile(
                title: Text( 'Veículo: ${snapshot.data.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Ano Modelo: ${snapshot.data.anoModelo}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      Text('Combustível: ${snapshot.data.combustivel}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      Text('Marca: ${snapshot.data.marca}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      Text('Valor: ${snapshot.data.preco}', 
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.green
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 36.0),
                        child: Text('Referência: ${snapshot.data.referencia}',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              )
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
        }
      )
    );
  }
}