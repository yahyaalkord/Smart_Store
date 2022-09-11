import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';
import '../models/create_order.dart';
import '../models/order.dart';
import '../models/order_detils.dart';
import '../prefs/shared_pref_controller.dart';
import 'api_settings.dart';

class OrderApiController {
  String token = SharedPrefController().getValueFor<String>(PrefKeys.token.name)!;
  Future<List<Order>> getCards() async {
    Uri uri = Uri.parse(ApiSettings.orders.replaceFirst('/{id}', ""));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      var jsonObj = json["list"] as List;
      final list = jsonObj.map((e) => Order.fromJson(e)).toList();
      return list;
    }
    return [];
  }

  Future<ApiResponseT<OrderDetails>> getOrderDetails(
      {required String id}) async {
    Uri uri = Uri.parse(ApiSettings.orders.replaceFirst('{id}', id));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    print("state ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      var jsonObj = json["data"];
      var data = OrderDetails.fromJson(jsonObj);
      return ApiResponseT<OrderDetails>(
        message: json["message"],
        status: json["status"],
        model: data,
      );
    }
    return ApiResponseT<OrderDetails>(
      message: "Something going wrong!",
      status: false,
    );
  }

  Future<ApiResponseT> createOrder({required CreateOrder order}) async {
    Uri uri = Uri.parse(ApiSettings.orders.replaceFirst('/{id}', ""));
    var response = await http.post(
      uri,
      body: {
        "payment_type": order.paymentType,
        "address_id": order.addressId,
        "cart": order.cartList
      },
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    print("stat ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      return ApiResponseT(
        message: json["message"],
        status: json["status"],
      );
    }
    return ApiResponseT(
      message: "Something going wrong!",
      status: false,
    );
  }
}