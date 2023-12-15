export 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium/components/core_export.dart';

class NotificationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  NotificationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getNotificationList( int offset) async {
    return await apiClient.getData('${AppConstants.notificationUri}?limit=10&offset=$offset');
  }

  void saveSeenNotificationCount(int count) {
    sharedPreferences.setInt(AppConstants.notificationCount, count);
  }

  int getSeenNotificationCount() {
    return sharedPreferences.getInt(AppConstants.notificationCount)!;
  }

}
