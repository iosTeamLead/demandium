import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/core/helper/route_helper.dart';
import 'package:demandium/feature/auth/controller/auth_controller.dart';
import 'package:demandium/feature/cart/controller/cart_controller.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'confirmation_dialog.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState  extends State<MenuDrawer> with SingleTickerProviderStateMixin {


  final List<Menu> _menuList = [
    Menu(icon: Images.profileIcon, title: 'profile'.tr, onTap: () {
      Get.back();
      Get.toNamed(RouteHelper.getProfileRoute());
    }),
    Menu(icon: Images.chatImage, title: 'inbox'.tr, onTap: () {
      Get.back();
      Get.toNamed( Get.find<AuthController>().isLoggedIn() ?
      RouteHelper.getInboxScreenRoute():RouteHelper.getNotLoggedScreen(RouteHelper.chatInbox, "inbox"));
    }),
    Menu(icon: Images.translate, title: 'language'.tr, onTap: () {
      Get.back();
      Get.toNamed(RouteHelper.getLanguageScreen('menuDrawer'));
    }),
    Menu(icon: Images.settings, title: 'settings'.tr, onTap: () {
      Get.back();
      Get.toNamed(RouteHelper.getSettingRoute());
    }),
    Menu(icon: Images.bookingsIcon, title:  Get.find<SplashController>().configModel.content?.guestCheckout == 0 || Get.find<AuthController>().isLoggedIn() ? 'bookings'.tr : "track_booking".tr, onTap: () {
      Get.back();
      Get.toNamed(!Get.find<AuthController>().isLoggedIn() && Get.find<SplashController>().configModel.content?.guestCheckout == 1 ?
      RouteHelper.getTrackBookingRoute() : !Get.find<AuthController>().isLoggedIn() ? RouteHelper.getNotLoggedScreen("booking","my_bookings") :
      RouteHelper.getBookingScreenRoute(true));
    }),

    if(Get.find<SplashController>().configModel.content?.biddingStatus==1)
    Menu(icon: Images.customPostIcon, title: 'my_posts'.tr, onTap: () {
      Get.back();
      Get.toNamed(Get.find<AuthController>().isLoggedIn() ?
      RouteHelper.getMyPostScreen() : RouteHelper.getNotLoggedScreen(RouteHelper.myPost,"my_posts"));
    }),

    Menu(icon: Images.voucherIcon, title: 'vouchers'.tr, onTap: () {
      Get.back();
      Get.toNamed(RouteHelper.getVoucherRoute());
    }),
    if(Get.find<SplashController>().configModel.content!.walletStatus != 0 && Get.find<AuthController>().isLoggedIn())
    Menu(icon: Images.walletMenu, title: 'my_wallet'.tr, onTap: () {
      Get.back();
      Get.toNamed(RouteHelper.getMyWalletScreen());
    }),
    if(Get.find<SplashController>().configModel.content!.loyaltyPointStatus != 0 && Get.find<AuthController>().isLoggedIn())
    Menu(icon: Images.myPoint, title: 'loyalty_point'.tr, onTap: () {
      Get.back();
      Get.toNamed(RouteHelper.getLoyaltyPointScreen());
    }),
    Menu(icon: Images.aboutUs, title: 'about_us'.tr, onTap: () {
      Get.back();
      Get.toNamed(RouteHelper.getHtmlRoute('about_us'));
    }),

    Menu(icon: Images.termsIcon, title: 'terms_and_conditions'.tr, onTap: () {
      Get.back();
      Get.toNamed( RouteHelper.getHtmlRoute('terms-and-condition'));
    }),
    Menu(icon: Images.privacyPolicyIcon, title: 'privacy_policy'.tr, onTap: () {
      Get.back();
      Get.toNamed( RouteHelper.getHtmlRoute('privacy-policy'));
    }),

    if(Get.find<SplashController>().configModel.content!.cancellationPolicy != "")
    Menu(icon: Images.cancellationPolicy, title: 'cancellation_policy'.tr, onTap: () {
      Get.back();
        Get.toNamed(RouteHelper.getHtmlRoute('cancellation_policy'));
      }),
    if(Get.find<SplashController>().configModel.content!.refundPolicy != "")
     Menu(icon: Images.refundPolicy, title: 'refund_policy'.tr, onTap: () {
       Get.back();
        Get.toNamed(RouteHelper.getHtmlRoute('refund_policy'));
      }),
    Menu(icon: Images.helpIcon, title: 'help_&_support'.tr, onTap: () {
      Get.back();
      Get.toNamed( RouteHelper.getSupportRoute());
    }),

     Menu(icon: Images.logout, title:Get.find<AuthController>().isLoggedIn() ? 'logout'.tr : 'sign_in'.tr, onTap: () {
       Get.back();
       if(Get.find<AuthController>().isLoggedIn()) {
         Get.dialog(ConfirmationDialog(icon: Images.logoutIcon, description: 'are_you_sure_to_logout'.tr, isLogOut: true, onYesPressed: () {
           Get.find<AuthController>().logOut();
           Get.find<AuthController>().clearSharedData();
           Get.find<CartController>().clearCartList();
           Get.find<AuthController>().googleLogout();
           Get.find<AuthController>().signOutWithFacebook();
           Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
         }), useSafeArea: false);
       }else {
         Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
       }
      }),
  ];


  static const _initialDelayTime = Duration(milliseconds: 200);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime + (_staggerTime * 7) + _buttonDelayTime + _buttonTime;

  AnimationController? _staggeredController;
  final List<Interval> _itemSlideIntervals = [];

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();
    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuList.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }
  }

  @override
  void dispose() {
    _staggeredController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? _buildContent() : null;
  }

  _buildContent(){
    return Align(alignment:Get.find<LocalizationController>().isLtr? Alignment.topRight : Alignment.topLeft, child: Container(
      width: 300,
      decoration: BoxDecoration(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30)), color: Theme.of(context).cardColor),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge, horizontal: 25),
              margin: const EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(Dimensions.radiusExtraLarge)),
                color: Theme.of(context).primaryColor,
              ),
              alignment: Alignment.centerLeft,
              child: Text('menu'.tr, style: ubuntuBold.copyWith(fontSize: 20, color: Colors.white)),
            ),

            ListView.builder(
              itemCount: _menuList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _staggeredController!,
                  builder: (context, child) {
                    final animationPercent = Curves.easeOut.transform(
                      _itemSlideIntervals[index].transform(_staggeredController!.value),
                    );
                    final opacity = animationPercent;
                    final slideDistance = (1.0 - animationPercent) * 150;

                    return Opacity(
                      opacity: opacity,
                      child: Transform.translate(
                        offset: Offset(slideDistance, 0),
                        child: child,
                      ),
                    );
                  },
                  child: InkWell(
                    onTap: _menuList[index].onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [

                        Container(
                          height: 60, width: 60, alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Image.asset(_menuList[index].icon!, height: 30, width: 30),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall),

                        Expanded(child: Text(_menuList[index].title!, style: ubuntuMedium, overflow: TextOverflow.ellipsis, maxLines: 1)),

                      ]),
                    ),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    ));
  }
}



class Menu {
  String? icon;
  String? title;
  Function()? onTap;

  Menu({@required this.icon, @required this.title, @required this.onTap});
}