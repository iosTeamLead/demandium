import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }


  bool _darkTheme = false;
  String _lightMap = '[]';
  String _darkMap = '[]';

  bool get darkTheme => _darkTheme;
  String get lightMap => _lightMap;
  String get darkMap => _darkMap;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(AppConstants.theme, _darkTheme);
    update();
  }

  void _loadCurrentTheme() async {
    _lightMap = await rootBundle.loadString('assets/map/light_map.json');
    _darkMap = await rootBundle.loadString('assets/map/dark_map.json');
    _darkTheme = sharedPreferences.getBool(AppConstants.theme) ?? false;
    update();
  }
}
