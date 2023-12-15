import 'dart:convert';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';


Future<Map<String, Map<String, String>>> init() async {
  //those binding are used before called GetMaterial app
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: LocationRepo(apiClient: Get.find(),sharedPreferences: Get.find())));
  Get.lazyPut(() => CartController(cartRepo: CartRepo(sharedPreferences:Get.find(),apiClient: Get.find())));
  Get.lazyPut(() => CouponController(couponRepo: CouponRepo(apiClient: Get.find())));
  Get.lazyPut(() => AuthController(authRepo: AuthRepo(sharedPreferences:Get.find(),apiClient: Get.find())));
  Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
  Get.lazyPut(() => WebLandingController(WebLandingRepo(apiClient: Get.find())));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> jsonValue = {};
    mappedJson.forEach((key, value) {
      jsonValue[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = jsonValue;
  }
  return languages;
}