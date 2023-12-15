import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  final int? status;

  const OrderSuccessfulScreen({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: FooterBaseView(
        isCenter: true,
        child: WebShadowWrap(
          child: Center(child: SizedBox(width: Dimensions.webMaxWidth, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            Image.asset(status == 1 ? Images.successIcon : Images.warning, width: 100, height: 100),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            Text(status == 1 ? 'you_placed_the_booking_successfully'.tr : 'your_bookings_is_failed_to_place'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
              child: Text(
                status == 1 ? 'your_order_is_placed_successfully'.tr : 'you_can_try_again_later'.tr,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: CustomButton(buttonText: 'back_to_home'.tr, width: Dimensions.webMaxWidth/5, onPressed: () {
                Get.offAllNamed(RouteHelper.getMainRoute("home"));
              }),
            ),
          ]))),
        ),
      ),
    );
  }
}
