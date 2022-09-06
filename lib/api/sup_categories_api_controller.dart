import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/sup_categories.dart';
import '../prefs/shared_pref_controller.dart';
import 'api_settings.dart';

class SubCategoriesApiController {

  Future<List<SubCategories>> getSubCategories({required int categoryId}) async {
    String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.subCategories.replaceFirst('{id}', categoryId.toString()));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader:'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['list'] as List;
      return dataJsonObject
          .map((jsonObject) => SubCategories.fromJson(jsonObject))
          .toList();
    }
    return [];
  }
}