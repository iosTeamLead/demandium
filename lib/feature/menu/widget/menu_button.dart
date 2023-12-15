import 'package:get/get.dart';
import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/components/core_export.dart';


class MenuButton extends StatelessWidget {
  final MenuModel? menu;
  final bool? isLogout;
  const MenuButton({super.key, @required this.menu, @required this.isLogout});

  @override
  Widget build(BuildContext context) {
    int count = ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4;
    double size = ((context.width > Dimensions.webMaxWidth ? Dimensions.webMaxWidth : context.width)/count)-Dimensions.paddingSizeDefault;

    return Stack(
      children: [
        Column(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            height: size-(size*0.3),
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            alignment: Alignment.center,
            child: Image.asset(menu!.icon!, width: size, height: size),
          ),
          const SizedBox(height: Dimensions.paddingSizeEight),
          Text(menu!.title!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center),
        ]),
        Positioned.fill(child: RippleButton(onTap: () async {
          if(isLogout!) {
            Get.back();
            if(Get.find<AuthController>().isLoggedIn()) {
              Get.dialog(ConfirmationDialog(
                  icon: Images.logoutIcon,
                  description: 'are_you_sure_to_logout'.tr, isLogOut: true,
                  onYesPressed: () {
                Get.find<AuthController>().logOut();
                Get.find<AuthController>().clearSharedData();
                Get.find<CartController>().clearCartList();
                Get.find<AuthController>().googleLogout();
                Get.find<AuthController>().signOutWithFacebook();
                Get.find<LocationController>().updateSelectedAddress(null);

                Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.main));
              }), useSafeArea: false);
            }else {
              Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
            }
          }else if(menu!.route!.startsWith('http')) {
            if(await canLaunchUrlString(menu!.route!)) {
          launchUrlString(menu!.route!, mode: LaunchMode.externalApplication);}}
          else {
            Get.offNamed(menu!.route!);
          }
        }))
      ],
    );
  }
}

