import 'dart:convert';
import 'dart:io';

import '../models/address.dart';
import '../models/api_response.dart';
import '../prefs/shared_pref_controller.dart';
import 'api_settings.dart';
import 'package:http/http.dart' as http;

class AddressApiController {
  String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;

  Future<List<Address>> getAddresses() async {
    Uri uri = Uri.parse(ApiSettings.addresses.replaceFirst('/{id}', ""));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      var jsonObj = json["list"] as List;
      final list = jsonObj.map((e) => Address.fromJson(e)).toList();
      return list;
    }
    return [];
  }

  Future<ApiResponseT<Address>> createNewAddress({required Address address}) async {
    Uri uri = Uri.parse(ApiSettings.addresses.replaceFirst('/{id}', ""));
    var response = await http.post(
      uri,
      body: address.toJson(),
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    if (response.statusCode == 201 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if(response.statusCode == 201){
        print("body $json");
        print("object ${json["object"]}");
        return ApiResponseT<Address>(message: json["message"], status: json["status"], model: Address.fromJson(json["object"]));
      }
      return ApiResponseT<Address>(message: json["message"], status: json["status"]);
    }
    return ApiResponseT<Address>(message: "Something going wrong!", status: false);
  }

  Future<ApiResponseT> deleteAddress({required String id}) async {
    Uri uri = Uri.parse(ApiSettings.addresses.replaceFirst('{id}',id));
    var response = await http.delete(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      return ApiResponseT(message: json["message"], status: true);
    }
    return ApiResponseT(message: "Something going wrong!", status: false);
  }


  Future<ApiResponseT<Address>> updateAddress({required Address address}) async {
    String queryString = Uri(queryParameters: address.toJson()).query;
    var requestUrl = Uri.parse("${ApiSettings.addresses.replaceFirst('{id}', address.id.toString())}?$queryString");
    var response = await http.put(
      requestUrl,
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      return ApiResponseT<Address>(message: json["message"], status: json["status"]);
    }
    return ApiResponseT<Address>(message: "Something going wrong!", status: false);
  }


}