import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class WalletPaymentConfirmDialog extends StatelessWidget {
  const WalletPaymentConfirmDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController){

      double walletBalance = cartController.walletBalance;
      double bookingAmount = Get.find<CartController>().totalPrice;
      bool isPartialPayment = walletBalance < bookingAmount;

      return SizedBox(width: Dimensions.webMaxWidth/2.3,
        child: Padding(padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge,horizontal: Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: Dimensions.paddingSizeLarge),

            Image.asset(Images.note, height: 45,),

            Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Text('note!'.tr, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
            ),


            RichText( text:
              TextSpan(children: <TextSpan>[
                TextSpan(
                  text: isPartialPayment ? "you_do_not_have_sufficient_balance_to_pay_full_amount_via_wallet.".tr
                    : "you_can_pay_the_full_amount_with_your_wallet".tr,
                  style: ubuntuRegular.copyWith(color: Theme.of(Get.context!).textTheme.bodyLarge!.color!.withOpacity(0.9),height: 1.7),
                ),
                TextSpan(text: isPartialPayment ? "want_to_pay_partially_with_wallet".tr : "want_to_pay_via_your_wallet".tr,
                    style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],),
              textAlign: TextAlign.center,
              textScaleFactor: 0.90,
            ),

            const SizedBox(height: Dimensions.paddingSizeExtraLarge),

            isPartialPayment ? Column(children: [
              Image.asset(Images.walletMenu, height: 40,),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Text(PriceConverter.convertPrice(walletBalance),style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Theme.of(context).primaryColor),),
            ],):

            Row(mainAxisAlignment: MainAxisAlignment.center ,children: [
              Image.asset(Images.walletMenu, height: 40,),
              const SizedBox(width : Dimensions.paddingSizeSmall),
              Text(PriceConverter.convertPrice(bookingAmount),style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Theme.of(context).primaryColor),),
              const SizedBox(width : Dimensions.paddingSizeSmall),
              Text('booking_amount'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8)), textAlign: TextAlign.center),

            ],),
            SizedBox(height: isPartialPayment ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault),

            isPartialPayment ?
            Text('can_be_paid_via_wallet'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5)), textAlign: TextAlign.center
            ):
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('remaining_wallet_balance'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6)), textAlign: TextAlign.center),
              Text(PriceConverter.convertPrice(walletBalance-bookingAmount),style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6))),

            ],),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            Row(children: [
              Expanded( child: TextButton(
                onPressed: () {
                  Get.back();
                  cartController.updateWalletPaymentStatus(false);
                  },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3),
                  minimumSize: const Size(Dimensions.webMaxWidth, 45),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                ),
                child: Text(
                  "no".tr, textAlign: TextAlign.center,
                  style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),),
              )),
              const SizedBox(width: Dimensions.paddingSizeLarge),

              Expanded( child: CustomButton(
                buttonText: "yes_pay".tr,
                fontSize: Dimensions.fontSizeDefault,
                onPressed: () {
                  cartController.updateWalletPaymentStatus(true);
                  Get.back();
                  },
                radius: Dimensions.radiusSmall, height: 45,
              )),
            ])


          ]),
        ),
      );
    });
  }
}


