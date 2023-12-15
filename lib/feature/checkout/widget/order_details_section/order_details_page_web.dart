import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/provider_details_card.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/wallet_payment_card.dart';
import 'package:get/get.dart';

class OrderDetailsPageWeb extends StatelessWidget {
  const OrderDetailsPageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ConfigModel configModel = Get.find<SplashController>().configModel;

    return Center( child: SizedBox(width: Dimensions.webMaxWidth,
      child: GetBuilder<CartController>(builder: (cartController){
        return Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(child: WebShadowWrap( minHeight: Get.height * 0.1, child: Column( mainAxisSize: MainAxisSize.min, children: [

              const ServiceSchedule(),
              const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault), child: AddressInformation()),
              ( cartController.preSelectedProvider) ? const ProviderDetailsCard() : const SizedBox(),

              const SizedBox(height: Dimensions.paddingSizeDefault,),
              const ShowVoucher(),

              (Get.find<AuthController>().isLoggedIn() && Get.find<CartController>().walletBalance > 0 && configModel.content?.walletStatus == 1 && configModel.content?.partialPayment == 1) ?
              const WalletPaymentCard(fromPage: "checkout",) : const SizedBox(),
            ]),
          )),

            const SizedBox(width: 50,),
            Expanded(child: WebShadowWrap( minHeight: Get.height * 0.1  ,child: const CartSummery()),),
        ]);
      }),
    ));
  }
}
