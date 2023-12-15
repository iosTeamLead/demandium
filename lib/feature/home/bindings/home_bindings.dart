import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => BannerController(bannerRepo: BannerRepo(apiClient: Get.find())));
    Get.lazyPut(() => CampaignController( campaignRepo: CampaignRepo(apiClient: Get.find())));
    Get.lazyPut(() => CategoryController(categoryRepo: CategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceController(serviceRepo: ServiceRepo(apiClient:Get.find())));
    Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceBookingController(serviceBookingRepo: ServiceBookingRepo(sharedPreferences: Get.find(),apiClient: Get.find())));
  }
}