import 'package:get/get.dart';
import 'package:demandium/components/web_search_widget.dart';
import 'package:demandium/components/core_export.dart';

class WebMenuBar extends StatelessWidget implements PreferredSizeWidget {
  const WebMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Container( width: Dimensions.webMaxWidth,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(offset: const Offset(1, 1), blurRadius: 8, color: Theme.of(context).primaryColor.withOpacity(0.15),)],
        color: Theme.of(context).cardColor, borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(Dimensions.radiusDefault),
          bottomLeft: Radius.circular(Dimensions.radiusDefault),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
      child: Row(children: [

        InkWell( onTap: () => Get.toNamed(RouteHelper.getInitialRoute(fromPage: 'appbar')),
          child: Image.asset(Get.isDarkMode?Images.webAppbarLogoDark:Images.webAppbarLogo,width: 150),
        ),

        Get.find<LocationController>().getUserAddress() != null ? Expanded(
          child: InkWell( onTap: () => Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
            child: Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: GetBuilder<LocationController>(builder: (locationController) {
                return Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Icon(locationController.getUserAddress()!.addressType == 'home' ?
                  Icons.home_filled : locationController.getUserAddress()!.addressType == 'office' ? Icons.work : Icons.location_on,
                    size: 20, color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  Flexible( child: Text( locationController.getUserAddress()?.address ?? "",
                    style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: Dimensions.fontSizeExtraSmall,),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  )),
                  Icon( Icons.arrow_drop_down, color: Get.isDarkMode? light.cardColor : Theme.of(context).primaryColor),
                ]);
              }),
            ),
          )
        ) : const Expanded(child: SizedBox()),

        MenuButtonWeb(title: 'home'.tr, onTap: () => Get.toNamed(RouteHelper.getMainRoute("home"))),
        const SizedBox(width: 10),

        MenuButtonWeb( title: 'categories'.tr, onTap: () => Get.toNamed(RouteHelper.getCategoryProductRoute(
            Get.find<CategoryController>().categoryList?[0].id ?? "",
            Get.find<CategoryController>().categoryList?[0].name ?? "",
            0.toString()
        ))),
        const SizedBox(width: Dimensions.paddingSizeSmall),

        MenuButtonWeb( title: 'services'.tr, onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute('all_service'))),

        const SearchWidgetWeb(),
        MenuButtonWebIcon( icon: Images.notification, isCart: false, onTap: () => Get.toNamed(RouteHelper.getNotificationRoute())),

        const SizedBox(width: Dimensions.paddingSizeSmall),
        MenuButtonWebIcon( icon: Images.offerMenu, isCart: false, onTap: () => Get.toNamed(RouteHelper.getOffersRoute('offer'))),

        const SizedBox(width: Dimensions.paddingSizeSmall),
        MenuButtonWebIcon( icon: Images.webCartIcon, isCart: true, onTap: () => Get.toNamed(RouteHelper.getCartRoute())),

        const SizedBox(width: Dimensions.paddingSizeSmall),
        MenuButtonWebIcon(icon: Images.webHomeIcon, onTap: () => Scaffold.of(context).openEndDrawer()),

        const SizedBox(width: 10),
        GetBuilder<AuthController>(builder: (authController){
          return InkWell( onTap: () {
            if(authController.isLoggedIn()){
              Get.toNamed(RouteHelper.getBookingScreenRoute(true));
            }else{
              Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
            }},
            child: Container(padding: const EdgeInsets.symmetric( horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall-2),
              decoration: BoxDecoration( color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(Dimensions.radiusSmall),),
              child: Row(children: [
                authController.isLoggedIn() ?const SizedBox.shrink():Image.asset(Images.webSignInButton,width: 16.0,height: 16.0,),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                Text(authController.isLoggedIn() ? 'my_bookings'.tr : 'sign_in'.tr, style: ubuntuRegular.copyWith(color: Colors.white)),
              ]),
            ),
          );
        }),
      ]),
    ));
  }
  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 70);
}

class MenuButtonWebIcon extends StatelessWidget {
  final String? icon;
  final bool isCart;
  final Function() onTap;
  const MenuButtonWebIcon({super.key, @required this.icon, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell( onTap: onTap,
      child: Row(children: [ Stack (clipBehavior: Clip.none, children: [

        Image.asset( icon!, height: 16, width: 16, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.7)),

        isCart ? GetBuilder<CartController>(builder: (cartController) {
          return cartController.cartList.isNotEmpty ? Positioned( top: -7, right: -7,
            child: Container(
              padding: const EdgeInsets.all(2),
              height: 15, width: 15, alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary),
              child: FittedBox(child: Text(
                cartController.cartList.length.toString(),
                style: ubuntuRegular.copyWith(fontSize: 12, color: light.cardColor),
              ),
              ),
            ),
          ) : const SizedBox();
        }) : const SizedBox()]),

        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
      ]),
    );
  }
}

class MenuButtonWeb extends StatelessWidget {
  final String? title;
  final bool isCart;
  final Function() onTap;
  const MenuButtonWeb({super.key, @required this.title, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(
      builder: (hovered){
        return Container(
          decoration: BoxDecoration(
            color:hovered ? Theme.of(context).colorScheme.primary.withOpacity(.1) : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault))
          ),
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeEight, horizontal: Dimensions.paddingSizeEight),
              child: Text(title!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
            ),
          ),
        );
      },
    );
  }
}

