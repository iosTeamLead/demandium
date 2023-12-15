import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/utils/app_constants.dart';

class HtmlRepository{
  final ApiClient apiClient;
  HtmlRepository({required this.apiClient});

  Future<Response> getPagesContent() async {
    return await apiClient.getData(AppConstants.pages);
  }

}