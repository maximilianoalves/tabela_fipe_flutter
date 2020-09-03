import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:tabela_fipe_flutter/models/car.dart';
import 'package:tabela_fipe_flutter/models/favoriteModel.dart';
import 'package:tabela_fipe_flutter/service/favoriteDatabaseService.dart';
import 'package:tabela_fipe_flutter/service/fipeService.dart';

class ResultFipePage extends StatefulWidget {
  final String type;
  final String brandId;
  final String modelId;
  final String fuelAndYearsId;
  final String modelName;

  const ResultFipePage({
    Key key, 
    @required this.type, 
    @required this.brandId,
    @required this.modelId,
    @required this.fuelAndYearsId,
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
      widget.brandId.toString(),
      widget.modelId,
      widget.fuelAndYearsId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.modelName),
      ),
      body: FutureBuilder<Car>(
        future: futureCar,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 15, left: 5, right: 5),
              child: Card(
                  elevation: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          contentPadding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                               Wrap(
                                 direction: Axis.vertical,
                                 spacing: 5.0,
                                 runSpacing: 5.0,
                                 children: <Widget>[
                                   Text(
                                     '${snapshot.data.marca} - ',
                                     key: Key('text-marca-titulo'),
                                     style: TextStyle(
                                       fontWeight: FontWeight.w600,
                                       fontSize: 22,
                                     ),
                                   ),
                                   Text(
                                     '${snapshot.data.name}',
                                     key: Key('text-modelo'),
                                     style: TextStyle(
                                       fontWeight: FontWeight.w600,
                                       fontSize: 22,
                                     ),
                                   ),
                                 ],
                               )
                              ],
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //ano-modelo
                                Row (
                                  children: <Widget>[
                                    Text(
                                      'Ano Modelo: ',
                                      key: Key('ano-modelo'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data.anoModelo}',
                                      key: Key('text-ano-modelo'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                //combustivel
                                Row (
                                  children: <Widget>[
                                    Text(
                                      'Combustível: ',
                                      key: Key('combustivel'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data.combustivel}',
                                      key: Key('text-combustivel'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                //marca
                                Row (
                                  children: <Widget>[
                                    Text(
                                      'Marca: ',
                                      key: Key('marca'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data.marca}',
                                      key: Key('text-marca'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                //valor
                                Row (
                                  children: <Widget>[
                                    Text(
                                      'Valor: ',
                                      key: Key('valor'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${snapshot.data.preco}',
                                      key: Key('text-valor'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20,
                                          color: Colors.green
                                      ),
                                    ),
                                  ],
                                ),
                                //referencia
                                Padding(padding: EdgeInsets.only(top: 35.0),
                                  child: Text(
                                    'Referência: ${snapshot.data.referencia}',
                                    key: Key('text-referencia'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text('ADICIONAR AOS FAVORITOS'),
                            onPressed: () async {
                              await FavoriteDatabaseService.db.addFavorite(new FavoriteModel(
                                name: snapshot.data.name,
                                price: snapshot.data.preco,
                                url: 'url'
                              ));
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Adicionado aos favoritos com sucesso'),
                              ));
                            },
                          ),
                          FlatButton(
                            child: Icon(Icons.share),
                            onPressed: () {
                              final RenderBox box = context.findRenderObject();
                              Share.share(
                                'Consulta FIPE\nModelo: ${snapshot.data.name}\nAno: ${snapshot.data.anoModelo}\nMarca: ${snapshot.data.marca}\nCombustível: ${snapshot.data.combustivel}\nValor: ${snapshot.data.preco}',
                                subject: 'Consulta FIPE',
                                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.announcement, size: 50,),
                  Text(
                    'Impossível buscar suas informações.', 
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