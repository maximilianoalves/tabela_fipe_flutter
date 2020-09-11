import 'package:flutter_driver/flutter_driver.dart';

class ResultFipePage {

  final textMarcaTitulo = find.byValueKey('text-marca-titulo');
  final textModelo = find.byValueKey('text-modelo-titulo');
  final textAnoModelo = find.byValueKey('text-ano-modelo');
  final textCombustivel = find.byValueKey('text-combustivel');
  final textMarca = find.byValueKey('text-marca');
  final textValor = find.byValueKey('text-valor');


  FlutterDriver _driver;

  //constructor
  ResultFipePage(FlutterDriver driver) {
    this._driver = driver;
  }

  Future<String> getTextMarcaTitulo() async {
    _driver.waitFor(textMarcaTitulo);
    return await _driver.getText(textMarcaTitulo);
  }

  Future<String> getTextModelo() async {
    _driver.waitFor(textModelo);
    return await _driver.getText(textModelo);
  }

  Future<String> getTextAnoModelo() async {
    _driver.waitFor(textAnoModelo);
    return await _driver.getText(textAnoModelo);
  }

  Future<String> getTextCombustivel() async {
    _driver.waitFor(textCombustivel);
    return await _driver.getText(textCombustivel);
  }

  Future<String> getTextMarca() async {
    _driver.waitFor(textMarca);
    return await _driver.getText(textMarca);
  }

  Future<String> getTextValor() async {
    _driver.waitFor(textValor);
    return await _driver.getText(textValor);
  }

}