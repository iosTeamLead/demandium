import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class BookingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BookingDetailsController(bookingDetailsRepo: BookingDetailsRepo(
      sharedPreferences: Get.find(),
      apiClient: Get.find(),
    )));
    Get.lazyPut(() => ServiceBookingController(serviceBookingRepo: ServiceBookingRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
    ///conversation controller is used in booking details screen
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
  }
}