import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class CheckoutBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => ScheduleController(scheduleRepo: ScheduleRepo(apiClient: Get.find())));
  }
}