import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tabela_fipe_flutter/pages/brand.page.dart';
import 'package:tabela_fipe_flutter/utils/string.captalize.utils.dart';

enum VehicleType {
  motorcycles,
  cars,
  trucks,
}

class VehicleTypeButton extends StatelessWidget {
  @required
  final VehicleType vehicleType;
  Key buttonKey;
  Key buttonTextKey;
  String vehicleTypeName;
  IconData icon;

  VehicleTypeButton({
    this.vehicleType,
  });

  void _fillInformation() {
    switch (vehicleType) {
      case VehicleType.motorcycles:
        buttonKey = Key('btn-motorcycles');
        vehicleTypeName = 'Motos';
        buttonTextKey = Key('btn-text-motorcycles');
        icon = Icons.motorcycle;
        break;
      case VehicleType.cars:
        buttonKey = Key('btn-cars');
        vehicleTypeName = 'Carros';
        buttonTextKey = Key('btn-text-cars');
        icon = Icons.directions_car;
        break;
      case VehicleType.trucks:
        buttonKey = Key('btn-trucks');
        vehicleTypeName = 'Caminhões';
        buttonTextKey = Key('btn-text-trucks');
        icon = Icons.local_shipping;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _fillInformation();
    return Container(
      padding: EdgeInsets.only(top: 15),
      width: 300.0,
      height: 100.0,
      child: RaisedButton(
        key: buttonKey,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => BrandPage(
                type: vehicleTypeName,
              ),
            ),
          );
        },
        color: Colors.blue[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              StringCapitalize().capitalize(vehicleTypeName),
              key: buttonTextKey,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
