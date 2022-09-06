import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smart_store/api/api_settings.dart';
import 'package:smart_store/models/cities.dart';
import 'package:smart_store/utils/api_helper.dart';

import '../prefs/shared_pref_controller.dart';


 class CitiesApiController with ApiHelper{
  Future<List<Cities>> cities() async{
   Uri uri = Uri.parse(ApiSettings.cities);
   var response = await http.get(uri,headers: {
    HttpHeaders.acceptHeader:'application/json',
   });
   if(response.statusCode == 200){
    var json = jsonDecode(response.body);
    print(json);
    var dataJsonObject = json['list'] as List;
    //TODO: save user in shared Preferences
    return dataJsonObject.map((jsonObject) => Cities.fromJson(jsonObject)).toList();

   }
   return [];
  }
 }