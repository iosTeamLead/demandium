import 'package:demandium/feature/notification/repository/notification_repo.dart';
import 'dart:convert';
import 'package:demandium/components/core_export.dart';

class SearchRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getSearchData(String query) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(query);
    return await apiClient.getData('${AppConstants.searchUri}?string=$encoded&offset=1&limit=50');
  }

  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    return await sharedPreferences.setStringList(AppConstants.searchHistory, searchHistories);
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.searchHistory) ?? [];
  }

  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstants.searchHistory, []);
  }

  Future<Response> getSuggestedServicesFromServer() async {
    return await apiClient.getData('${AppConstants.suggestedSearchUri}?offset=1&limit=20');
  }

  Future<Response> removeSuggestedServicesFromServer({String? id}) async {
    return await apiClient.getData('${AppConstants.removeSuggestedServiceUri}${id!=null?'?id[]=$id':''}');
  }
}
