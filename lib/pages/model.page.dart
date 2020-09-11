import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/models/car_model.model.dart';
import 'package:tabela_fipe_flutter/pages/fueld_and_years.page.dart';
import 'package:tabela_fipe_flutter/service/fipe.service.dart';
import 'package:tabela_fipe_flutter/utils/string.captalize.utils.dart';
import 'package:tabela_fipe_flutter/widgets/error_on_searching.dart';
import 'package:tabela_fipe_flutter/widgets/loader.dart';
import 'package:tabela_fipe_flutter/widgets/search_box.dart';

class ModelPage extends StatefulWidget {
  final int brandId;
  final String modelName;
  final String type;

  ModelPage(
      {Key key,
      @required this.brandId,
      @required this.modelName,
      @required this.type})
      : super(key: key);

  @override
  _ModelPageState createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  Future<List<CarModel>> futureCarModel;
  Future<List<CarModel>> futureFilteredCarModel;

  @override
  void initState() {
    super.initState();
    futureCarModel = FipeService().getModels(
      widget.type.toLowerCase(),
      widget.brandId.toString(),
    );
    futureFilteredCarModel = futureCarModel;
  }

  void _onSearchPressed(String text) {
    setState(() {
      futureFilteredCarModel = futureCarModel.then((value) {
        return value
            .where((el) =>
                (el.fipeName.toLowerCase().contains(text.toLowerCase())))
            .toList();
      });
    });
  }

  Widget _buildSearchField() {
    return SearchBox(
      onSearchPress: _onSearchPressed,
      hintText: 'Buscar por modelos',
    );
  }

  Widget _buildRowItem(AsyncSnapshot snapshot) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: snapshot.data.length,
        itemBuilder: (_, index) {
          return new GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => FuelAndYearsPage(
                  modelId: snapshot.data[index].id,
                  brandId: widget.brandId,
                  modelName: snapshot.data[index].name,
                  type: widget.type,
                ),
              ),
            ),
            child: Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    snapshot.data[index].fipeName ?? 'Nome não informado',
                    key: Key('model-$index'),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringCapitalize().capitalize(
            widget.modelName.toLowerCase(),
          ),
        ),
      ),
      body: FutureBuilder<List<CarModel>>(
        future: futureFilteredCarModel,
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
                _buildRowItem(snapshot),
              ],
            );
          } else if (snapshot.hasError) {
            return ErrorOnSearching();
          }
          return Loader();
        },
      ),
    );
  }
}
