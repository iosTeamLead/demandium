import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class WalletPaymentCard extends StatelessWidget {
  final String fromPage;
  const WalletPaymentCard({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController){

      double walletBalance = cartController.walletBalance;
      double bookingAmount = fromPage == "custom-checkout" ? Get.find<CheckOutController>().totalAmount :  cartController.totalPrice;

      bool isPartialPayment = walletBalance < bookingAmount;
      double paidAmount = isPartialPayment ? walletBalance : bookingAmount;
      double remainingWalletBalance = isPartialPayment? 0 : walletBalance - bookingAmount;

      return  Container(
        margin: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault+8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSeven),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3), width: 0.5),
          color: Theme.of(context).hoverColor,
        ),

        child: Stack(alignment: AlignmentDirectional.bottomEnd,children: [
          Image.asset(Images.walletBackground,height: Dimensions.walletTopCardHeight*0.8,),
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

              Row(children: [
                Image.asset(Images.walletMenu,height: 40,width: 40,),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Row(children: [
                        Expanded(child: Text(PriceConverter.convertPrice(  cartController.walletPaymentStatus ? paidAmount : walletBalance ),style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Theme.of(context).colorScheme.primary),)),
                        if( cartController.walletPaymentStatus && !isPartialPayment) Text("${'remaining'.tr} ${PriceConverter.convertPrice(remainingWalletBalance)}",
                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                    Text(  cartController.walletPaymentStatus && isPartialPayment ? "has_paid_by_your_wallet".tr:   cartController.walletPaymentStatus && !isPartialPayment? "paid_by_your_account".tr : "you_have_balance_in_your_wallet".tr,
                      style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6), fontSize: Dimensions.fontSizeSmall),
                    ),
                  ]),
                ),
              ],),
              const SizedBox(height: Dimensions.paddingSizeDefault,),


              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                cartController.walletPaymentStatus?
                Row(children: [
                  Icon(Icons.check_circle, color: Theme.of(context).colorScheme.onSecondaryContainer, size: Dimensions.fontSizeDefault,),
                  Text("applied!".tr,
                    style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeDefault),
                  ),

                ]) :
                Text("do_you_want_to_use_now".tr,
                  style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeDefault),
                ),

                cartController.walletPaymentStatus ?
                TextButton(
                  onPressed: (){
                    cartController.updateWalletPaymentStatus(false);
                    Get.find<CheckOutController>().getPaymentMethodList(shouldUpdate: true);
                    if(fromPage == "custom-checkout"){
                      Get.find<CheckOutController>().changePaymentMethod();
                    }
                  },
                  child: Text('remove'.tr,
                    style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.error),),
                )
                : CustomButton(
                  height: ResponsiveHelper.isDesktop(context) ? 40 : 30 ,width: 80,
                  buttonText: "use".tr,
                  onPressed: (){
                    cartController.updateWalletPaymentStatus(true);
                    Get.find<CheckOutController>().getPaymentMethodList(shouldUpdate: true, isPartialPayment: isPartialPayment);
                    if(fromPage == "custom-checkout"){
                      Get.find<CheckOutController>().changePaymentMethod();
                    }
                  }
                )
              ],)

            ]),
          )
        ]),
      );
    });
  }


}
