import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/api_response.dart';
import '../models/home.dart';
import '../models/product.dart';
import '../prefs/shared_pref_controller.dart';
import '../utils/api_helper.dart';
import 'api_settings.dart';

class ProductsApiController {

  Future<List<Products>> getProducts({required int subCategoryId}) async {
    String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.product.replaceFirst('{id}', subCategoryId.toString()));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader:'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['list'] as List;
      return dataJsonObject
          .map((jsonObject) => Products.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<Home> getHomeData() async {
    Uri uri = Uri.parse(ApiSettings.home);
    var response = await http.get(uri,headers: {
      HttpHeaders.acceptHeader : "application/json",
      HttpHeaders.authorizationHeader : SharedPrefController().getValueFor(PrefKeys.token.name),
    });

    if(response.statusCode == 200 || response.statusCode == 400){
      var json = jsonDecode(response.body);
      return Home.fromJson(json["data"]);
    }
    return Home();
  }
  Future<ApiResponseT<Products>> getProductDetails(
      {required int productId}) async {
    Uri uri = Uri.parse(
        ApiSettings.productDetails.replaceFirst('{id}', productId.toString()));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().getValueFor(PrefKeys.token.name),
    });

    if (response.statusCode == 200 || response.statusCode == 401) {
      var json = jsonDecode(response.body);
      var jsonObj = json["object"] as Map<String, dynamic>;
      Products product = Products.fromJson(jsonObj);
      return ApiResponseT(message: json['message'], status: json['status'],model: product);
    }
    return ApiResponseT<Products>(
      message: "Something going wrong!",
      status: false,
    );
  }

}