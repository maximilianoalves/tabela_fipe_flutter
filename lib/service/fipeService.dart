import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tabela_fipe_flutter/models/brand.dart';
import 'package:tabela_fipe_flutter/models/car.dart';
import 'package:tabela_fipe_flutter/models/carModel.dart';
import 'package:tabela_fipe_flutter/models/carFuelAndYears.dart';

class FipeService {

  static const String BASE_URL = 'https://fipeapi.appspot.com/api/1/';

  Future<List<Brand>> getBrands(String type) async {
    final response = await http.get('$BASE_URL$type/marcas.json');
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      return list.map((i) => Brand.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load List Brand');
    }
  }

  Future<List<CarModel>> getModels(String type, String modelId) async {
    final response = await http.get('https://fipeapi.appspot.com/api/1/$type/veiculos/$modelId.json');
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      return list.map((i) => CarModel.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load CarModel');
    }
  }

  Future<List<CarFuelAndYears>> getFuelAndYears(String type, String modelId, String carModelsAndYearsId) async {
    final response = await http.get('https://fipeapi.appspot.com/api/1/$type/veiculo/$modelId/$carModelsAndYearsId.json');
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as List;
      return list.map((i) => CarFuelAndYears.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load CarModelsAndYears');
    }
  }

  Future<Car> getResultFipe(String type, String modelId, String modelsAndYearsId, String modelAndYearId) async {
    final response = await http.get('$BASE_URL$type/veiculo/$modelId/$modelsAndYearsId/$modelAndYearId.json');
    if (response.statusCode == 200) {
      return Car.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Car');
    }
  }
}