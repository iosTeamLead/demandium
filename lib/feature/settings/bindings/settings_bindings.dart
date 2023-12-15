import 'package:get/get.dart';
import 'package:demandium/controller/theme_controller.dart';

class SettingsBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  }

}