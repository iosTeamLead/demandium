import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'widget/menu_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
    ConfigModel configModel  = Get.find<SplashController>().configModel;

    double ratio = ResponsiveHelper.isDesktop(context) ? 1.1 : ResponsiveHelper.isTab(context) ? 1.1 : 1.2;
    final List<MenuModel> menuList = [
      MenuModel(icon: Images.profileIcon, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      MenuModel(icon: Images.chatImage, title: 'inbox'.tr, route:isLoggedIn? RouteHelper.getInboxScreenRoute() :  RouteHelper.getNotLoggedScreen(RouteHelper.chatInbox,"inbox")),
      MenuModel(icon: Images.translate, title: 'language'.tr, route: RouteHelper.getLanguageScreen('fromSettingsPage')),
      MenuModel(icon: Images.settings, title: 'settings'.tr, route: RouteHelper.getSettingRoute()),
      MenuModel(icon: Images.bookingsIcon, title: configModel.content?.guestCheckout == 0 || isLoggedIn ? 'bookings'.tr : "track_booking".tr, route: !isLoggedIn && configModel.content?.guestCheckout == 1
          ? RouteHelper.getTrackBookingRoute() : !isLoggedIn ? RouteHelper.getNotLoggedScreen("booking","my_bookings")
          : RouteHelper.getBookingScreenRoute(true)
      ),
      MenuModel(icon: Images.voucherIcon, title: 'vouchers'.tr, route: RouteHelper.getVoucherRoute()),
      MenuModel(icon: Images.aboutUs, title: 'about_us'.tr, route: RouteHelper.getHtmlRoute('about_us')),
      if(Get.find<SplashController>().configModel.content!.termsAndConditions != "")
      MenuModel(icon: Images.termsIcon, title: 'terms_and_conditions'.tr, route: RouteHelper.getHtmlRoute('terms-and-condition')),
      MenuModel(icon: Images.privacyPolicyIcon, title: 'privacy_policy'.tr, route: RouteHelper.getHtmlRoute('privacy-policy')),
      if(Get.find<SplashController>().configModel.content!.cancellationPolicy != "")
        MenuModel(icon: Images.cancellationPolicy, title: 'cancellation_policy'.tr, route: RouteHelper.getHtmlRoute('cancellation_policy')),
      if(Get.find<SplashController>().configModel.content!.refundPolicy != "")
        MenuModel(icon: Images.refundPolicy, title: 'refund_policy'.tr, route: RouteHelper.getHtmlRoute('refund_policy')),
      MenuModel(icon: Images.helpIcon, title: 'help_&_support'.tr, route: RouteHelper.getSupportRoute()),

      if(configModel.content?.biddingStatus == 1)
        MenuModel(icon: Images.customPostIcon, title: 'my_posts'.tr,
            route: isLoggedIn ? RouteHelper.getMyPostScreen() : RouteHelper.getNotLoggedScreen(RouteHelper.myPost,"my_posts")
        ),

      if(configModel.content!.walletStatus != 0 && isLoggedIn)
      MenuModel(icon: Images.walletMenu, title: 'my_wallet'.tr, route: RouteHelper.getMyWalletScreen()),
      if(configModel.content!.loyaltyPointStatus != 0 && isLoggedIn)
      MenuModel(icon: Images.myPoint, title: 'loyalty_point'.tr, route: RouteHelper.getLoyaltyPointScreen()),
      if(configModel.content?.providerSelfRegistration == 1)
      MenuModel(icon: Images.providerImage, title: 'become_a_provider'.tr, route: RouteHelper.getProviderWebView()),
    ];
    menuList.add(MenuModel(icon: Images.logout, title: isLoggedIn ? 'logout'.tr : 'sign_in'.tr, route: ''));

    return PointerInterceptor(
      child: Container(
        width: Dimensions.webMaxWidth,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: Theme.of(context).cardColor,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.keyboard_arrow_down_rounded, size: 30,color: Theme.of(context).colorScheme.primary,),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4,
              childAspectRatio: (1/ratio),
              crossAxisSpacing: Dimensions.paddingSizeExtraSmall, mainAxisSpacing: Dimensions.paddingSizeExtraSmall,
            ),
            itemCount: menuList.length,
            itemBuilder: (context, index) {
              return MenuButton(menu: menuList[index], isLogout: index == menuList.length-1);
            },
          ),
          Text("${'app_version'.tr} ${AppConstants.appVersion}",style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),),
          SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeDefault : 0),

        ]),
      ),
    );
  }
}
