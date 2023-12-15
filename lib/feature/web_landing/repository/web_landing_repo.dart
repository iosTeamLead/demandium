import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/feature/notification/repository/notification_repo.dart';
import 'package:demandium/utils/app_constants.dart';

class WebLandingRepo {
  final ApiClient apiClient;

  WebLandingRepo({required this.apiClient});

  Future<Response> getWebLandingContents() async {
    return await apiClient.getData(AppConstants.webLandingContents,headers: AppConstants.configHeader);
  }

}