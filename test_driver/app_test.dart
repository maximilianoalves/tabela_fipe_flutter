import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tabela FIPE App Test', () {
    FlutterDriver driver;

    //elements

    final btnCars = find.byValueKey('btn-carros');
    final btnCarsText = find.byValueKey('btn-text-carros');
    final audiBrand = find.byValueKey('brand-audi');
    final audiModel = find.byValueKey('model-0');
    final audiFuelAndYear = find.byValueKey('fuelAndYears-0');

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('- check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('- select cars button', () async {
      expect(
          await driver.getText(btnCarsText),
          equals('Carros')
      );

      await driver.waitFor(btnCars);
      await driver.tap(btnCars);
    });

    test('- select brand cars', () async {
      expect(
          await driver.getText(audiBrand),
          equals('AUDI')
      );

      await driver.waitFor(audiBrand);
      await driver.tap(audiBrand);
    });

    test('- select model cars', () async {
      expect(
          await driver.getText(audiModel),
          equals('100 2.8 V6')
      );

      await driver.waitFor(audiModel);
      await driver.tap(audiModel);
    });

    test('- select fuel and year of car', () async {
      expect(
          await driver.getText(audiFuelAndYear),
          equals('1995 Gasolina')
      );

      await driver.waitFor(audiFuelAndYear);
      await driver.tap(audiFuelAndYear);
    });

  });
}