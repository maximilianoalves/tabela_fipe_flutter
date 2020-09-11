import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:tabela_fipe_flutter/models/car.model.dart';
import 'package:tabela_fipe_flutter/models/favorite_model.model.dart';
import 'package:tabela_fipe_flutter/service/favorite_database.service.dart';
import 'package:tabela_fipe_flutter/service/fipe.service.dart';
import 'package:tabela_fipe_flutter/widgets/error_on_searching.dart';
import 'package:tabela_fipe_flutter/widgets/loader.dart';

class ResultFipePage extends StatefulWidget {
  final String type;
  final String brandId;
  final String modelId;
  final String fuelAndYearsId;
  final String modelName;

  const ResultFipePage(
      {Key key,
      @required this.type,
      @required this.brandId,
      @required this.modelId,
      @required this.fuelAndYearsId,
      @required this.modelName})
      : super(key: key);

  @override
  _ResultFipePageState createState() => _ResultFipePageState();
}

class _ResultFipePageState extends State<ResultFipePage> {
  Future<Car> futureCar;

  @override
  void initState() {
    super.initState();
    futureCar = FipeService().getResultFipe(widget.type.toLowerCase(),
        widget.brandId.toString(), widget.modelId, widget.fuelAndYearsId);
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
                  padding: EdgeInsets.only(
                    top: 15,
                    left: 5,
                    right: 5,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                            contentPadding: EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                              bottom: 20,
                            ),
                            title: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    key: Key('text-modelo-titulo'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(
                                  top: 0, right: 0, left: 0, bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  //ano-modelo
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Ano: ',
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
                                  Row(
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
                                        key:
                                            Key('text-combustivel'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
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
                                  Row(
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
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 35.0),
                                    child: Text(
                                      'Reference: ${snapshot.data.referencia}',
                                      key: Key('referencia'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: Text('Adicionar aos favoritos'),
                              onPressed: () async {
                                await FavoriteDatabaseService.db.addFavorite(
                                    new FavoriteModel(
                                        name: snapshot.data.name,
                                        price: snapshot.data.preco,
                                        url: 'url'));
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text('Adicionado com sucesso aos favoritos'),
                                ));
                              },
                            ),
                            FlatButton(
                              child: Icon(Icons.share),
                              onPressed: () {
                                final RenderBox box =
                                    context.findRenderObject();
                                Share.share(
                                  'Consulta FIPE\n'
                                  'Modelo: ${snapshot.data.name}\n'
                                  'Ano: ${snapshot.data.anoModelo}\n'
                                  'Marca: ${snapshot.data.marca}\n'
                                  'Combustível: ${snapshot.data.combustivel}\n'
                                  'Valor: ${snapshot.data.preco}',
                                  subject: 'Consulta FIPE',
                                  sharePositionOrigin:
                                      box.localToGlobal(Offset.zero) & box.size,
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
                return ErrorOnSearching();
              }
              return Loader();
            }));
  }
}
