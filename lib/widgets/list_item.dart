import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/pages/model.page.dart';

class ListItem extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final String type;

  ListItem({
    this.snapshot,
    this.type,
  });

  void _goToModelPage(BuildContext context, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ModelPage(
              type: type,
              brandId: snapshot.data[index].id,
              modelName: snapshot.data[index].name),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: snapshot.data.length,
          itemBuilder: (_, index) {
            return new GestureDetector(
              onTap: () => _goToModelPage(context, index),
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    snapshot.data[index].name,
                    key:
                        Key('brand-${snapshot.data[index].name.toLowerCase()}'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
