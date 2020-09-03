import 'package:flutter_driver/flutter_driver.dart';

class ModelsPage {
  final audiModel = find.byValueKey('model-0');

  FlutterDriver _driver;

  //constructor
  ModelsPage(FlutterDriver driver) {
    this._driver = driver;
  }

  Future<String> getTextModelAudi() async {
    return await _driver.getText(audiModel);
  }

  Future<void> tapModelAudi() async {
    _driver.waitFor(audiModel);
    return _driver.tap(audiModel);
  }
}