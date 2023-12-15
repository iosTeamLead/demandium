import 'package:get/get.dart';

enum BnbItem {home, bookings, cart, offers, more}
class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();


  var currentPage = BnbItem.home.obs;
  void changePage(BnbItem bnbItem) {
    currentPage.value = bnbItem;
  }

}
