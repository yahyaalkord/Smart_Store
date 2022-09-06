import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smart_store/api/api_settings.dart';

import '../models/home/categories.dart';
import '../models/home/famous_product.dart';
import '../models/home/latest_product.dart';
import '../models/home/slider.dart';
import '../prefs/shared_pref_controller.dart';

class HomeApiController {

  Future<List<HomeSlider>> getHomeSlider() async {
    String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.home);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader:'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['slider'] as List;
      return dataJsonObject
          .map((jsonObject) => HomeSlider.fromJson(jsonObject))
          .toList();

    }
    return [];
  }
  Future<List<LatestProducts>> getLatestProducts() async {
    String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.home);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader:'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['latest_products'] as List;
      return dataJsonObject
          .map((jsonObject) => LatestProducts.fromJson(jsonObject))
          .toList();
    }
    return [];
  }
  Future<List<FamousProducts>> getFamousProducts() async {
    String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.home);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader:'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['famous_products'] as List;
      return dataJsonObject
          .map((jsonObject) => FamousProducts.fromJson(jsonObject))
          .toList();
    }
    return [];
  }
  Future<List<HomeCategorise>> getHomeCategorise() async {
    String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.home);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader:'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['categories'] as List;
      return dataJsonObject
          .map((jsonObject) => HomeCategorise.fromJson(jsonObject))
          .toList();
    }
    return [];
  }
}
