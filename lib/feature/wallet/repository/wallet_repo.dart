import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class WalletRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  WalletRepo({required this.apiClient, required this.sharedPreferences,});

  Future<Response> getWalletTransactionData(int offset, String type) async {
    return await apiClient.getData("${AppConstants.walletTransactionData}?limit=10&offset=$offset&type=$type");
  }

  Future<Response> getBonusList() async {
    return await apiClient.getData(AppConstants.bonusUri);
  }

  Future<void> setWalletAccessToken(String token){
    return  sharedPreferences.setString(AppConstants.walletAccessToken, token);
  }

  String getWalletAccessToken(){
    return  sharedPreferences.getString(AppConstants.walletAccessToken) ?? "";
  }

}