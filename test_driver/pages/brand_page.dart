import 'package:flutter_driver/flutter_driver.dart';

class BrandPage {

  final audiBrand = find.byValueKey('brand-audi');

  FlutterDriver _driver;

  //constructor
  BrandPage(FlutterDriver driver) {
    this._driver = driver;
  }

  Future<String> getTextAudiBrand() async {
    return await _driver.getText(audiBrand);
  }

  Future<void> tapBtnAudiBrand() async {
    _driver.waitFor(audiBrand);
    return _driver.tap(audiBrand);
  }
}