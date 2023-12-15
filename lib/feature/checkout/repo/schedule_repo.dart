import 'package:demandium/data/provider/client_api.dart';
import 'package:get/get.dart';
import 'package:demandium/utils/app_constants.dart';

class ScheduleRepo extends GetxService {
  final ApiClient apiClient;
  ScheduleRepo({required this.apiClient});

  Future<Response> changePostScheduleTime(String postId, String scheduleTime) async {
    return await apiClient.postData(AppConstants.updatePostInfo,{
      "_method":"put",
      "post_id":postId,
      "booking_schedule":scheduleTime
    });
  }
}