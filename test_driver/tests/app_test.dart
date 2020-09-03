import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../pages/brand_page.dart';
import '../pages/fuel_and_year_page.dart';
import '../pages/home_page.dart';
import '../pages/models_page.dart';
import '../pages/result_fipe_page.dart';

void main() {
  group('Tabela FIPE App Test', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('- select cars button', () async {
      HomePage homePage = HomePage(driver);

      expect(
          await homePage.getTextBtnCars(),
          equals('Carros')
      );

      await homePage.tapBtnCars();
    });

    test('- select brand cars', () async {
      BrandPage brandPage = BrandPage(driver);

      expect(
          await brandPage.getTextAudiBrand(),
          equals('AUDI')
      );

      await brandPage.tapBtnAudiBrand();
    });

    test('- select model cars', () async {
      ModelsPage modelsPage = ModelsPage(driver);

      expect(
          await modelsPage.getTextModelAudi(),
          equals('100 2.8 V6')
      );

      await modelsPage.tapModelAudi();
    });

    test('- select fuel and year of car', () async {
      FuelAndYearPage fuelAndYearPage = FuelAndYearPage(driver);

      expect(
          await fuelAndYearPage.getTextAudiFuelAndYear(),
          equals('1995 Gasolina')
      );

      await fuelAndYearPage.tapAudiFuelAndYear();
    });

    test('-- validate result', () async {
      ResultFipePage resultFipePage = ResultFipePage(driver);

      expect(
          await resultFipePage.getTextCombustivel(),
          equals('Gasolina')
      );

      //print(resultFipePage.getTextMarcaTitulo().toString());
      //print(resultFipePage.getTextMarca().toString());
      //print(resultFipePage.getTextAnoModelo());
      //print(resultFipePage.getTextModelo());
      //print(resultFipePage.getTextCombustivel());

    });

  });
}