import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/provider_details_card.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/wallet_payment_card.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConfigModel configModel = Get.find<SplashController>().configModel;
    return SingleChildScrollView(
      child: Column(children: [
        const ServiceSchedule(),
        const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: AddressInformation(),
        ),
        Get.find<CartController>().preSelectedProvider ? const ProviderDetailsCard(): const SizedBox(),

        const ShowVoucher(),

        (Get.find<AuthController>().isLoggedIn() && Get.find<CartController>().walletBalance > 0 && configModel.content?.walletStatus == 1 && configModel.content?.partialPayment == 1) ?
        const WalletPaymentCard(fromPage: 'checkout',): const SizedBox(),

        const CartSummery()
    ]));
  }
}
