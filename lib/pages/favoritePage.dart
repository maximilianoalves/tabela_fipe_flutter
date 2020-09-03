import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/models/favoriteModel.dart';
import 'package:tabela_fipe_flutter/service/favoriteDatabaseService.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<List<FavoriteModel>> futureFavorite;

  @override
  void initState() {
    super.initState();
    futureFavorite = FavoriteDatabaseService.db.getAllFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Favoritos'),
      ),
      body: FutureBuilder<List<FavoriteModel>>(
        future: futureFavorite,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.length);
            if (snapshot.data.length < 1) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(Icons.warning, size: 50,),
                    Text(
                      "Nenhum favorito cadastrado.",
                      key: Key('error-message'),
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder:(_, index) {
                          return Dismissible(
                            key: Key('${index}'),
                            onDismissed: (direction) {
                              FavoriteDatabaseService.db.deleteFavoriteWithId(snapshot.data[index].id);
                            },
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: AlignmentDirectional.centerEnd,
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.delete, color: Colors.white,),
                              ),
                            ),
                            child: Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index].name,
                                    key: Key('favorite-${index}'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  subtitle: Text('Valor: ${snapshot.data[index].price}'),
                                )
                            ),
                          );
                        }
                    ),
                  ),
                ],
              );
            }
          } else if(snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(Icons.warning, size: 50,),
                  Text(
                    "Nenhum favorito cadastrado.",
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
        },
      ),
    );
  }
}
