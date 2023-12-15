import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SplashRepo({ required this.apiClient, required this.sharedPreferences});

  Future<Response> getConfigData() async {
    Response response = await apiClient.getData(AppConstants.configUri,headers: AppConstants.configHeader);
    return response;
  }

  Future<Response> getOfflinePaymentMethod() async {
    Response response = await apiClient.getData(AppConstants.offlinePaymentUri);
    return response;
  }


  Future<bool> initSharedData() async {

    if(!sharedPreferences.containsKey(AppConstants.theme)) {
      sharedPreferences.setBool(AppConstants.theme, false);
    }
    if(!sharedPreferences.containsKey(AppConstants.countryCode)) {
      sharedPreferences.setString(AppConstants.countryCode, AppConstants.languages[0].countryCode!);
    }
    if(!sharedPreferences.containsKey(AppConstants.languageCode)) {
      sharedPreferences.setString(AppConstants.languageCode, AppConstants.languages[0].languageCode!);
    }
    if(!sharedPreferences.containsKey(AppConstants.cartList)) {
      sharedPreferences.setStringList(AppConstants.cartList, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.searchHistory)) {
      sharedPreferences.setStringList(AppConstants.searchHistory, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.notification)) {
      sharedPreferences.setBool(AppConstants.notification, true);
    }
    if(!sharedPreferences.containsKey(AppConstants.notificationCount)) {
      sharedPreferences.setInt(AppConstants.notificationCount, 0);
    }

    if(!sharedPreferences.containsKey(AppConstants.acceptCookies)) {
      sharedPreferences.setBool(AppConstants.acceptCookies, false);
    }

    if(!sharedPreferences.containsKey(AppConstants.guestId)) {
      sharedPreferences.setString(AppConstants.guestId, "");
    }


    return Future.value(true);
  }

  String getZoneId() => sharedPreferences.getString(AppConstants.zoneId)!;

  Future<bool> setSplashSeen(bool isSplashSeen) async {
    return await sharedPreferences.setBool(AppConstants.isSplashScreen, isSplashSeen);
  }

  bool isSplashSeen() {
    return sharedPreferences.getBool(AppConstants.isSplashScreen) != null ? sharedPreferences.getBool(AppConstants.isSplashScreen)! : false;
  }

  Future<void> setGuestId(String guestId){
    return  sharedPreferences.setString(AppConstants.guestId, guestId);
  }

  String getGuestId(){
    return  sharedPreferences.getString(AppConstants.guestId)??"";
  }

  bool getSavedCookiesData() {
    return sharedPreferences.getBool(AppConstants.acceptCookies)!;
  }

  Future<void> saveCookiesData(bool data) async {
    try {
      await sharedPreferences.setBool(AppConstants.acceptCookies, data);

    } catch (e) {
      rethrow;
    }
  }

}
