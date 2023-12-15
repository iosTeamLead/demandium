import 'package:demandium/feature/notification/repository/notification_repo.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';



class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    //common controller
    Get.lazyPut(() => SplashController(splashRepo: SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => AuthController(authRepo: AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
    Get.lazyPut(() => WebLandingController( WebLandingRepo( apiClient: Get.find())));
    Get.lazyPut(() => NotificationController( notificationRepo: NotificationRepo(apiClient:Get.find() , sharedPreferences: Get.find())));
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => CategoryController(categoryRepo: CategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceBookingController(serviceBookingRepo: ServiceBookingRepo(sharedPreferences:Get.find(),apiClient: Get.find())));
    Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
    Get.lazyPut(() => CouponController(couponRepo: CouponRepo(apiClient: Get.find())));
    Get.lazyPut(() => ScheduleController(scheduleRepo: ScheduleRepo(apiClient: Get.find())));
    Get.lazyPut(() => BookingDetailsController(bookingDetailsRepo: BookingDetailsRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => AllSearchController(searchRepo: SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => ServiceController(serviceRepo: ServiceRepo(apiClient: Get.find())));
    Get.lazyPut(() => HtmlViewController(htmlRepository: HtmlRepository(apiClient: Get.find())));
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
    Get.lazyPut(() => CheckOutController(checkoutRepo: CheckoutRepo(apiClient: Get.find())));
    Get.lazyPut(() => ProviderBookingController(providerBookingRepo: ProviderBookingRepo(apiClient: Get.find())));
    Get.lazyPut(() => CreatePostController(createPostRepo: CreatePostRepo(apiClient: Get.find())));
  }
}