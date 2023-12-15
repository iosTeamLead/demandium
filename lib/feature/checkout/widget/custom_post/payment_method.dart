import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/checkout/widget/payment_section/digital_payment.dart';
import 'package:demandium/feature/checkout/widget/payment_section/payment_method_button.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatefulWidget {

  final String? postId;
  final String? providerId;
  const PaymentMethod({Key? key, this.postId, this.providerId}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  int crossAxisCount = 1;
  double padding = 0.00;

  List<PaymentMethodButton> listOfButton =[
    if(Get.find<SplashController>().configModel.content?.digitalPayment==1)
      PaymentMethodButton(title: "pay_now".tr,paymentMethodName: PaymentMethodName.digitalPayment, assetName: Images.pay,),
    if(Get.find<SplashController>().configModel.content?.cashAfterService==1)
      PaymentMethodButton(title: "cash_after_service".tr,paymentMethodName: PaymentMethodName.cos,assetName: Images.cod,),
    if(Get.find<SplashController>().configModel.content?.walletStatus==1)
    PaymentMethodButton(title: "pay_via_wallet".tr,paymentMethodName: PaymentMethodName.walletMoney,assetName: Images.walletMenu,),
  ];

  @override
  Widget build(BuildContext context) {

    if(ResponsiveHelper.isMobile(context)){
      crossAxisCount = listOfButton.length<2 ? 1: 2;
      if(listOfButton.length==1){
        padding = 0.2;
      }else{
        padding = 0.04;
      }

    }else{
      if(listOfButton.length==1){
        crossAxisCount=1;
      }else if(listOfButton.length==2){
        crossAxisCount = 2;
      }else{
        crossAxisCount = 3;
      }

      if(listOfButton.length==1){
        padding = 0.27;
      }else if(listOfButton.length==2){
        padding = 0.17;
      }else{
        padding = 0.12;
      }
    }
    return GetBuilder<CheckOutController>(builder: (controller){
      return Column(
        children: [
          const SizedBox(height: Dimensions.paddingSizeDefault,),
          Text("payment_method".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(height: Dimensions.paddingSizeDefault),


          Padding(padding: EdgeInsets.symmetric(horizontal: Get.width * padding),
            child: GridView.builder(
              shrinkWrap: true,
              key: UniqueKey(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //crossAxisSpacing: Dimensions.paddingSizeSmall ,
                //mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeSmall ,
                mainAxisExtent: ResponsiveHelper.isMobile(context) ? 65  : 80 ,
                crossAxisCount: crossAxisCount,
              ),
              physics:  const NeverScrollableScrollPhysics(),
              itemCount: listOfButton.length,
              itemBuilder: (context, index) {
                return SizedBox(child: listOfButton.elementAt(index));
              },
            ),
          ),

          const SizedBox(height: Dimensions.paddingSizeDefault),

          Gaps.verticalGapOf(26),
          GetBuilder<CheckOutController>(builder: (controller){
            if(controller.selectedPaymentMethod ==  PaymentMethodName.digitalPayment){
              List<DigitalPaymentMethod>? paymentGateways = Get.find<SplashController>().configModel.content?.paymentMethodList;
              if( paymentGateways!.isNotEmpty) {
                return  GridView.builder(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault,left: 15,right: 15),
                  key: UniqueKey(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeDefault,
                    mainAxisExtent: 70,
                    crossAxisCount:  ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTab(context) ? 3 : 2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: paymentGateways.length,
                  itemBuilder: (context, index)  {
                    return GetBuilder<CheckOutController>(builder: (controller){
                      return GestureDetector(
                        onTap: () => controller.changePaymentMethod(digitalMethod: paymentGateways[index]),
                        child: Stack(children: [
                          DigitalPayment(
                            paymentGateway: paymentGateways[index].gateway ?? '',

                          ),

                         controller.selectedDigitalPaymentMethod == paymentGateways[index] ?
                          Stack(alignment: Alignment.topRight,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor.withOpacity(0.15),
                                ),
                              ),

                              Padding(padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5),
                                child: Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary, size: 20),
                              )

                            ],
                          ):const SizedBox()
                        ]),
                      );
                    });
                  },
                );
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeExtraMoreLarge,Dimensions.paddingSizeSmall
                    ,Dimensions.paddingSizeExtraMoreLarge,Dimensions.paddingSizeExtraLarge+5),
                child: Text('online_payment_option_is_not_available'.tr,
                  textAlign:TextAlign.center,
                  style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge,

                      color: Theme.of(context).colorScheme.error),),
              );
            }else{
              return const SizedBox();
            }
          }),
        ],
      );
    });
  }
}
