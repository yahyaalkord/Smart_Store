

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../api/product_api_controller.dart';
import '../models/home.dart';

class HomeGetController extends GetxController {
  Home? home;
  bool loading = false;

  static HomeGetController get to => Get.find<HomeGetController>();

  @override
  void onInit() {
    read();
    super.onInit();
  } // List<Product> products = <Product>[];


  void read() async {
    loading = true;
    home = await ProductsApiController().getHomeData();
    update();
    loading = false;

  }

}