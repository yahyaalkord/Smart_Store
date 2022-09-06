

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../prefs/shared_pref_controller.dart';

class LanguageGetexController extends GetxController {

  String currentLanguage =SharedPrefController().getValueFor<String>(PrefKeys.language.name) ?? 'en';
  RxString language = ''.obs;

  static LanguageGetexController get to => Get.find<LanguageGetexController>();

  @override
  void onInit() {
    language.value = currentLanguage;
    super.onInit();
  }

  void changeLanguage() {
    language.value = language.value == 'en' ? 'ar' : 'en';
    SharedPrefController().changeLanguage(langCode: language.value);
  }
}