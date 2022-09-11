

import 'package:get/get.dart';
import 'package:smart_store/api/cities_api_controller.dart';
import 'package:smart_store/models/cities.dart';

class CitiesGetxController extends GetxController{

  static CitiesGetxController get to => Get.find();
  final CitiesApiController _citiesApiController = CitiesApiController();
  List<Cities> citiesItems = <Cities>[];
  bool loading = false;

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading = true;
    citiesItems = await _citiesApiController.cities();
    loading = false;
    update();
  }
}