import 'package:demandium/feature/checkout/model/offline_payment_method_model.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  ConfigModel? _configModel = ConfigModel();
  bool _firstTimeConnectionCheck = true;
  bool _hasConnection = true;
  final bool _isLoading = false;
  List<OfflinePaymentModel>  _offlinePaymentModelList = [];

  bool get isLoading => _isLoading;
  ConfigModel get configModel => _configModel!;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get hasConnection => _hasConnection;
  List<OfflinePaymentModel>  get offlinePaymentModelList => _offlinePaymentModelList;

  bool savedCookiesData = false;

  Future<bool> getConfigData() async {
    _hasConnection = true;
    Response response = await splashRepo.getConfigData();
    bool isSuccess = false;
    if(response.statusCode == 200) {
      _configModel = ConfigModel.fromJson(response.body);
      isSuccess = true;
    }else {
      ApiChecker.checkApi(response);
      if(response.statusText == ApiClient.noInternetMessage) {
        _hasConnection = false;
      }
      isSuccess = false;
    }
    update();
    return isSuccess;
  }

  Future<void> getOfflinePaymentMethod(bool isReload, {bool shouldUpdate = true} ) async {

    if(_offlinePaymentModelList.isEmpty || isReload){
      _offlinePaymentModelList = [];
    }
    if(_offlinePaymentModelList.isEmpty) {
      Response response = await splashRepo.getOfflinePaymentMethod();
      if (response.statusCode == 200) {
        _offlinePaymentModelList = [];
        List<dynamic> list = response.body['content']['data'];
        for (var element in list) {
          _offlinePaymentModelList.add(OfflinePaymentModel.fromJson(element));
        }

      } else {
       // ApiChecker.checkApi(response);
      }
    }
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  void setGuestId(String guestId){
    splashRepo.setGuestId(guestId);
  }

  String getGuestId (){
    return splashRepo.getGuestId();
  }

  Future<bool> saveSplashSeenValue(bool value) async {
    return await splashRepo.setSplashSeen(value);
  }


  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }



  void saveCookiesData(bool data) {
    splashRepo.saveCookiesData(data);
    savedCookiesData = true;
    update();
  }

  getCookiesData(){
    savedCookiesData = splashRepo.getSavedCookiesData();
    update();
  }


  void cookiesStatusChange(String? data) {
    if(data != null){
      splashRepo.sharedPreferences.setString(AppConstants.cookiesManagement, data);
    }
  }

  bool getAcceptCookiesStatus(String data) => splashRepo.sharedPreferences.getString(AppConstants.cookiesManagement) != null
      && splashRepo.sharedPreferences.getString(AppConstants.cookiesManagement) == data;


  String getZoneId() =>  splashRepo.getZoneId();
  bool isSplashSeen() =>  splashRepo.isSplashSeen();


}
