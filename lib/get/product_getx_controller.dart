

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smart_store/models/product.dart';
import '../api/product_api_controller.dart';

import '../api/product_api_controller.dart';
import '../models/api_response.dart';
import '../models/home.dart';

class ProductGetController extends GetxController {
  Products? products;
  bool loading = false;
  int id;

  ProductGetController({required this.id});

  static ProductsApiController get to => Get.find<ProductsApiController>();

  @override
  void onInit() {
     read();
    super.onInit();
  } // List<Product> products = <Product>[];


  void read() async {
    loading = true;
    products = (await ProductsApiController().getProductDetails(productId: id)).model;
    update();
    loading = false;

  }

}