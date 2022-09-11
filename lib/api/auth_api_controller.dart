import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_store/models/api_response.dart';
import 'package:smart_store/models/user.dart';
import 'package:smart_store/prefs/shared_pref_controller.dart';
import 'package:smart_store/utils/api_helper.dart';

import 'api_settings.dart';

class AuthApiController with ApiHelper{
  /// New Api Request
  /// 1 ) Convert URI in APISettings from String to URI .
  ///2 ) Detect request method ( Get , Post , Put / Patch , Delete )
  /// 3 ) Create new api request using http.method ( uri ) .
  ///  -> In case the request must have abody, set request body using body parameters in http.method function.
  ///  -> body will request a map of key: value     keys are defined by web developer must be same as defined in postman.
  ///  -> Values are the data enter from UI.
  /// 4 ) The created request is async future < Response> that returns a response object.
  /// 5 ) Ensure that the request completed successfully by checking the status code.
  ///5 ) If successfully executed , get the response body
  ///    => Convert response body from string to JSON using decode

  Future<ApiResponse> login({required String mobile, required String password}) async {
    Uri uri = Uri.parse(ApiSettings.login);
    var response =
        await http.post(uri, body: {'mobile': mobile, 'password': password});
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        User user = User.fromJson(json['data']);
        //TODO: save user in shared Preferences
        SharedPrefController().save(user: user);
      }
      return ApiResponse(json['message'], json['status']);
    }
    return errorRespnse;
  }

  Future<ApiResponse> register(User user) async {
    Uri uri =Uri.parse(ApiSettings.register);
    var response = await http.post(uri, body: {
      'name': user.name,
      'mobile': user.mobile,
      'password': user.password,
      'gender': user.gender,
      'STORE_API_KEY': ApiSettings.storeApiKey,
      'city_id': user.cityId,
    });
    if(response.statusCode == 201 || response.statusCode == 400){
      var json = jsonDecode(response.body);
      // ApiResponse(json['code'],json['status']);
      print(json['code']);
      return ApiResponse(json['message'], json['status'],);
    }
    return errorRespnse;
  }

  Future<ApiResponse> activate ({required String code,required String mobile}) async{
    Uri uri =Uri.parse(ApiSettings.activate);
    var response = await http.post(uri, body: {
      'mobile' :mobile,
      'code' : code,
    });
    if(response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      return ApiResponse(json['message'], json['status']);
    }
    return errorRespnse;
  }

  Future<ApiResponseT> updateProfile(
      {required User user}) async {
    String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.updateProfile);
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
      body:{
        'name': user.name,
        'mobile': user.mobile,
        'city_id': user.cityId,
        'gender': user.gender,
      },

    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 400) {
  /*    if(response.statusCode == 200){
             User user = User.fromJson(json['data']);
        //TODO: save user in shared Preferences
        SharedPrefController().save(user: user);
      }*/
      var json = jsonDecode(response.body);
      // SharedPrefController().save(user: user);
      return ApiResponseT(message: json["message"], status: json["status"]);
    }
    return ApiResponseT<int>(message: "Something going wrong!", status: false);
  }

  Future<ApiResponse> logout() async{
    String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.logout);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader:'application/json',
    });
    if(response.statusCode == 200 || response.statusCode == 401){
      SharedPrefController().clear();
      return ApiResponse('Logged out successfully', true);
    }
    return errorRespnse;
  }

}
