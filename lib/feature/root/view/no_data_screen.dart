import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

enum NoDataType {
  cart, notification, order, coupon, others, home, offers, address, bookings,search, service,inbox, categorySubcategory,transaction
}

class NoDataScreen extends StatelessWidget {
  final NoDataType? type;
  final String? text;
  final bool isShowHomePage;
  const NoDataScreen({super.key, required this.text, this.type,  this.isShowHomePage = true, });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.03),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset((type == NoDataType.cart || type == NoDataType.order) ? Images.emptyCart:
            type == NoDataType.coupon ? Images.emptyCoupon:
            type == NoDataType.notification ? Images.emptyNotification:
            type == NoDataType.address ? Images.emptyAddress:
            type == NoDataType.bookings ? Images.emptyBooking:
            type == NoDataType.service ? Images.emptyService:
            type == NoDataType.search ? Images.emptySearchService:
            type == NoDataType.inbox ? Images.chatImage:
            type == NoDataType.transaction ? Images.emptyTransaction:
            type == NoDataType.offers ? Images.emptyOffer:Images.emptyService,
              width: type == NoDataType.coupon ? 50.0:MediaQuery.of(context).size.height*0.12 ,
              height:type == NoDataType.coupon ? 50.0: MediaQuery.of(context).size.height*0.12,
              color: Get.isDarkMode && (
                  type == NoDataType.bookings ||
                  type == NoDataType.home ||
                  type == NoDataType.service ||
                  type == NoDataType.categorySubcategory ||
                  type == NoDataType.notification
              ) ? Theme.of(context).primaryColorLight:null,
            ),
      ),
      Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Text(
          type == NoDataType.cart ? 'your_cart_is_empty'.tr :
          type == NoDataType.order ? 'sorry_your_order_history_is_Empty'.tr :
          type == NoDataType.coupon ? 'no_coupon_found'.tr:
          type == NoDataType.notification ? 'empty_notifications'.tr : text!,
          style: ubuntuMedium.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.4),),
          textAlign: TextAlign.center,
        ),
      ),

      if(type == NoDataType.search)
      Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Text('there_are_no_services_related_to_your_search'.tr,style: ubuntuRegular.copyWith(
          fontSize: Dimensions.fontSizeDefault,
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.4),
        ),
          textAlign: TextAlign.center,),
      ),
      SizedBox(height: MediaQuery.of(context).size.height*0.04),
      if(
          type != NoDataType.categorySubcategory &&
          type != NoDataType.inbox &&
          type != NoDataType.bookings &&
          type != NoDataType.service  &&
          type != NoDataType.search  &&
          type != NoDataType.offers &&
          type != NoDataType.cart &&
          type != NoDataType.address &&
          type != NoDataType.home &&
          type != NoDataType.coupon &&
          (type == NoDataType.notification && ResponsiveHelper.isMobile(context) || type == NoDataType.notification && ResponsiveHelper.isTab(context)) &&

          isShowHomePage )
      CustomButton(
        height: 40, width: 200,
        buttonText: 'back_to_homepage'.tr,
        onPressed: () => Get.offAllNamed(RouteHelper.getInitialRoute()),
      ),

    ]);
  }
}
