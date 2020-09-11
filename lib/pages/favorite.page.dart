import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/models/favorite_model.model.dart';
import 'package:tabela_fipe_flutter/service/favorite_database.service.dart';
import 'package:tabela_fipe_flutter/widgets/loader.dart';
import 'package:tabela_fipe_flutter/widgets/no_favorites_warning.dart';

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
        title: Text('My Favorites'),
      ),
      body: FutureBuilder<List<FavoriteModel>>(
        future: futureFavorite,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.length);
            if (snapshot.data.length < 1) {
              return NoFavoritesWarning();
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return Dismissible(
                            key: Key('$index'),
                            onDismissed: (direction) {
                              FavoriteDatabaseService.db.deleteFavoriteWithId(
                                  snapshot.data[index].id);
                            },
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: AlignmentDirectional.centerEnd,
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index].name,
                                    key: Key('favorite-$index'),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                      'Value: ${snapshot.data[index].price}'),
                                )),
                          );
                        }),
                  ),
                ],
              );
            }
          } else if (snapshot.hasError) {
            return NoFavoritesWarning();
          }
          return Loader();
        },
      ),
    );
  }
}
