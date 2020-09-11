import 'package:flutter_driver/flutter_driver.dart';

class HomePage {
  final btnCars = find.byValueKey('btn-cars');
  final btnCarsText = find.byValueKey('btn-text-cars');


  FlutterDriver _driver;

  //constructor
  HomePage(FlutterDriver driver) {
    this._driver = driver;
  }

  Future<String> getTextBtnCars() async {
    return await _driver.getText(btnCarsText);
  }

  Future<void> tapBtnCars() async {
    _driver.waitFor(btnCars);
    return _driver.tap(btnCars);
  }
}