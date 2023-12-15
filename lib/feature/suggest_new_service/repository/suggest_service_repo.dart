import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/utils/app_constants.dart';
import 'package:get/get.dart';


class SuggestServiceRepo{
  final ApiClient apiClient;
  SuggestServiceRepo({required this.apiClient});

  Future<Response> getCategoryList() async {
    return await apiClient.getData('${AppConstants.categoryUrl}&limit=100&offset=1');
  }

  Future<Response> getSuggestedServiceList(int offset) async {
    return await apiClient.getData('${AppConstants.getSuggestedServiceList}?limit=30&offset=$offset');
  }

  Future<Response> submitNewServiceRequest(Map<String,String> body) async {
    return await apiClient.postData(AppConstants.submitNewServiceRequest,body);
  }
}