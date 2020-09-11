import 'package:flutter_driver/flutter_driver.dart';

class FuelAndYearPage {
  final audiFuelAndYear = find.byValueKey('fuelAndYears-0');

  FlutterDriver _driver;

  //constructor
  FuelAndYearPage(FlutterDriver driver) {
    this._driver = driver;
  }

  Future<String> getTextAudiFuelAndYear() async {
    return await _driver.getText(audiFuelAndYear);
  }

  Future<void> tapAudiFuelAndYear() async {
    _driver.waitFor(audiFuelAndYear);
    return _driver.tap(audiFuelAndYear);
  }
}