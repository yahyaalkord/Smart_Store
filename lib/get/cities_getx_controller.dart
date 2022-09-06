

import 'package:get/get.dart';
import 'package:smart_store/api/cities_api_controller.dart';
import 'package:smart_store/models/cities.dart';

class CitiesGetxController extends GetxController{

  static CitiesGetxController get to => Get.find();
  final CitiesApiController _citiesApiController = CitiesApiController();
  RxList<Cities> citiesItems = <Cities>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading.value = true;
    citiesItems.value = await _citiesApiController.cities();
    loading.value = false;
  }
}