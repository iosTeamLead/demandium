import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class CheckoutHeaderWidget extends StatelessWidget {
  final String pageState;
  const CheckoutHeaderWidget({Key? key, required this.pageState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 426,
      child: GetBuilder<CheckOutController>(
        builder: (controller){
          return Column(
            children: [
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeSmall),
                child:  Stack(
                  children: [
                    SizedBox(
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomHeaderIcon(
                            assetIconSelected: Images.orderDetailsSelected,
                            assetIconUnSelected: Images.orderDetailsUnselected,
                            isActiveColor: controller.currentPageState == PageState.orderDetails ? true : false,
                          ),
                          controller.currentPageState == PageState.orderDetails ?
                          const CustomHeaderLine(
                              color: Color(0xffFF833D),
                              gradientColor1: Color(0xffFDA21A),
                              gradientColor2: Colors.orangeAccent) :
                          const CustomHeaderLine(
                              gradientColor1: Colors.deepOrange,
                              gradientColor2: Colors.orangeAccent),

                          CustomHeaderIcon(
                            assetIconSelected: Images.paymentSelected,
                            assetIconUnSelected: Images.paymentUnSelected,
                            isActiveColor: controller.currentPageState == PageState.payment ? true : false,),
                          controller.cancelPayment ?
                          const CustomHeaderLine(
                              cancelOrder: true,
                              gradientColor1: Colors.grey,
                              gradientColor2: Colors.grey) :
                          controller.currentPageState == PageState.payment ?
                          const CustomHeaderLine(
                              color: Colors.green,
                              gradientColor1: Colors.orangeAccent,
                              gradientColor2: Colors.green) :
                          const CustomHeaderLine(
                              gradientColor1: Colors.orangeAccent,
                              gradientColor2: Colors.greenAccent),
                          CustomHeaderIcon(
                            assetIconSelected: controller.cancelPayment? Images.completeSelected : Images.completeSelected,
                            assetIconUnSelected: Images.completeUnSelected,
                            isActiveColor: controller.currentPageState == PageState.complete ?
                            true : false,
                          ),
                        ],),),

                    if(controller.currentPageState == PageState.orderDetails  && PageState.orderDetails.name == pageState)
                      Positioned(
                        left: Get.find<LocalizationController>().isLtr ? 0: null,
                        right:Get.find<LocalizationController>().isLtr ? null: 0,
                        top: 0,
                        bottom: 0,
                        child: GestureDetector(
                            child: GestureDetector(
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage( Images.orderDetailsSelected,))),
                              ),)),),
                    if(controller.currentPageState == PageState.payment  || PageState.payment.name == pageState)
                      Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                              child: GestureDetector(
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage( Images.paymentSelected,))),
                                ),)),
                        ),
                      ), if(controller.currentPageState == PageState.complete || pageState == 'complete')
                      Positioned(
                        right: Get.find<LocalizationController>().isLtr ? 0:null,
                        left: Get.find<LocalizationController>().isLtr ? null: 0,
                        top: 0,
                        bottom: 0,
                        child: GestureDetector(
                            child: GestureDetector(
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage( Images.completeSelected,))),),)),),],
                ),),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault,left: 20.0,right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    CustomText(
                        text: "booking_details".tr,isActive :controller.currentPageState == PageState.orderDetails
                        && PageState.orderDetails.name == pageState),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: CustomText(text: "payment".tr,isActive :controller.currentPageState == PageState.payment
                          || PageState.payment.name == pageState),
                    ),
                    CustomText(text: "complete".tr,isActive : controller.currentPageState == PageState.complete  || pageState == 'complete'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
