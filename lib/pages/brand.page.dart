import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/models/brand.model.dart';
import 'package:tabela_fipe_flutter/service/fipe.service.dart';
import 'package:tabela_fipe_flutter/utils/string.captalize.utils.dart';
import 'package:tabela_fipe_flutter/widgets/error_on_searching.dart';
import 'package:tabela_fipe_flutter/widgets/list_item.dart';
import 'package:tabela_fipe_flutter/widgets/loader.dart';
import 'package:tabela_fipe_flutter/widgets/search_box.dart';

class BrandPage extends StatefulWidget {
  final String type;

  BrandPage({Key key, @required this.type}) : super(key: key);

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  Future<List<Brand>> futureBrand;
  Future<List<Brand>> futureFilteredBrand;

  @override
  void initState() {
    super.initState();
    futureBrand = FipeService().getBrands(widget.type);
    futureFilteredBrand = futureBrand;
  }

  void _onSearchPressed(String text) {
    setState(() {
      futureFilteredBrand = futureBrand.then((value) {
        return value
            .where(
              (el) => (el.name.toLowerCase().contains(
                    text.toLowerCase(),
                  )),
            )
            .toList();
      });
    });
  }

  Widget _buildSearchField() {
    return SearchBox(
      onSearchPress: _onSearchPressed,
      hintText: 'Buscar por marcas',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(StringCapitalize().capitalize(widget.type)),
        ),
        body: FutureBuilder<List<Brand>>(
          future: futureFilteredBrand,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 5,
                      right: 5,
                      bottom: 5,
                    ),
                    child: _buildSearchField(),
                  ),
                  ListItem(
                    snapshot: snapshot,
                    type: widget.type,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return ErrorOnSearching();
            }
            return Loader();
          },
        ));
  }
}
