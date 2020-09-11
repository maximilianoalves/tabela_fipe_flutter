import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/pages/favorite.page.dart';
import 'package:tabela_fipe_flutter/widgets/vehicle_type_button.dart';

void main() => runApp(
      App(),
    );

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIPE Table',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FIPE Table"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => FavoritePage(),
                  ));
            },
          )
        ],
      ),
      body: Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          VehicleTypeButton(
            vehicleType: VehicleType.cars,
          ),
          VehicleTypeButton(
            vehicleType: VehicleType.motorcycles,
          ),
          VehicleTypeButton(
            vehicleType: VehicleType.trucks,
          ),
        ],
      )),
    );
  }
}
