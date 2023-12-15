import 'package:demandium/feature/checkout/model/offline_payment_method_model.dart';
import 'package:demandium/feature/checkout/widget/payment_section/offline_payment_dialog.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';


class PaymentPage extends StatefulWidget {
  final String addressId;
  final JustTheController tooltipController;
  final String fromPage;
  const PaymentPage({Key? key, required this.addressId, required this.tooltipController, required this.fromPage}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}
class _PaymentPageState extends State<PaymentPage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<CheckOutController>(builder: (checkoutController){
        return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
          child: Column( children: [
            if(checkoutController.othersPaymentList.isEmpty && checkoutController.digitalPaymentList.isEmpty)
            Padding(padding: const EdgeInsets.symmetric( vertical: Dimensions.paddingSizeLarge * 2),
                child: Text("no_payment_method_available".tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).colorScheme.error),)
            ),

            if(checkoutController.othersPaymentList.isNotEmpty)
            Padding( padding: const EdgeInsets.symmetric(vertical :Dimensions.paddingSizeDefault),
              child: Row(children: [
                Text(" ${'choose_payment_method'.tr} ", style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                Expanded(child: Text('click_one_of_the_option_bellow'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))),
              ]),
            ),
            if(checkoutController.othersPaymentList.isNotEmpty)
            SizedBox(child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.paddingSizeExtraSmall,mainAxisExtent: 90),
              itemBuilder: (context, index){
                return checkoutController.othersPaymentList.elementAt(index);},
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: checkoutController.othersPaymentList.length,
              ),
            ),

            if(checkoutController.digitalPaymentList.isNotEmpty)
            Row( children: [
              Text(" ${'pay_via_online'.tr} ", style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
              Expanded(child: Text('faster_and_secure_way_to_pay_bill'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))),
            ]) ,
            if(checkoutController.digitalPaymentList.isNotEmpty)
            Padding( padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              child: DigitalPaymentMethodView(
                paymentList: checkoutController.digitalPaymentList,
                onTap: (index) => checkoutController.changePaymentMethod(digitalMethod: checkoutController.digitalPaymentList[index]),
                tooltipController: widget.tooltipController,
                fromPage: widget.fromPage,
              ),
            )],
          ),
        );
      }),
    );
  }
}


class DigitalPaymentMethodView extends StatelessWidget {
  final Function(int index) onTap;
  final List<DigitalPaymentMethod> paymentList;
  final JustTheController tooltipController;
  final String fromPage;
  const DigitalPaymentMethodView({
    Key? key, required this.onTap, required this.paymentList, required this.tooltipController, required this.fromPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<OfflinePaymentModel?>  offlinePaymentMethodList =  Get.find<SplashController>().offlinePaymentModelList;

    List<String> offlinePaymentTooltipTextList = [
      'to_pay_offline_you_have_to_pay_the_bill_from_a_option_below',
      'save_the_necessary_information_that_is_necessary_to_identify_or_confirmation_of_the_payment',
      'insert_the_information_and_proceed'
    ];

    return GetBuilder<CheckOutController>(builder: (checkoutController){
      return SingleChildScrollView(child: ListView.builder(
        itemCount: paymentList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){

          bool isSelected = paymentList[index] == Get.find<CheckOutController>().selectedDigitalPaymentMethod;
          bool isOffline = paymentList[index].gateway == 'offline';

          return InkWell(
            onTap: isOffline ? null :  ()=> onTap(index),
            child: Container(
              decoration: BoxDecoration(
                  color: isSelected ? Theme.of(context).hoverColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
              ),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                InkWell(
                  onTap: isOffline && !checkoutController.showOfflinePaymentInputData ?  ()=> onTap(index) : null,
                  child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [
                    Row(children: [
                      Container(
                        height: Dimensions.paddingSizeLarge, width: Dimensions.paddingSizeLarge,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,
                            border: Border.all(color: Theme.of(context).disabledColor)
                        ),
                        child: Icon(Icons.check, color: isSelected ? Colors.white : Colors.transparent, size: 16),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault),

                      isOffline ? const SizedBox() :
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        child: CustomImage(
                          height: Dimensions.paddingSizeLarge, fit: BoxFit.contain,
                          image: '${Get.find<SplashController>().configModel.content?.imageBaseUrl}/payment_modules/gateway_image/${paymentList[index].gatewayImage}',
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),

                      Text( isOffline ? 'pay_offline'.tr : paymentList[index].label ?? "",
                        style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                      ),
                    ]),

                    isOffline ? JustTheTooltip(
                      backgroundColor: Colors.black87, controller: tooltipController,
                      preferredDirection: AxisDirection.down, tailLength: 14, tailBaseWidth: 20,
                      content: Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child:  Column( mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start ,children: [
                          Text("note".tr, style: ubuntuBold.copyWith(color: Theme.of(context).colorScheme.primary),),
                          const SizedBox(height: Dimensions.paddingSizeSmall,),
                          Column(mainAxisSize: MainAxisSize.min ,crossAxisAlignment: CrossAxisAlignment.start, children: offlinePaymentTooltipTextList.map((element) => Padding(
                            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                            child: Text( "●  ${element.tr}",
                                style: ubuntuRegular.copyWith(color: Colors.white70),
                              ),
                          ),).toList(),
                          ),
                        ]),
                      ),

                      child: ( isOffline && isSelected )? InkWell( onTap: ()=> tooltipController.showTooltip(),
                        child: Icon(Icons.info, color: Theme.of(context).colorScheme.primary,),
                      ): const SizedBox(),

                    ) : const SizedBox()

                  ]),
                ),

                if( isOffline && isSelected ) SingleChildScrollView(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge),
                  scrollDirection: Axis.horizontal,
                  child: offlinePaymentMethodList.isNotEmpty ? Row(mainAxisAlignment: MainAxisAlignment.start, children: offlinePaymentMethodList.map((offlineMethod) => InkWell(
                    onTap: (){
                      if(isOffline){
                        checkoutController.changePaymentMethod(offlinePaymentModel: offlineMethod);
                      }else{
                        checkoutController.changePaymentMethod(digitalMethod : paymentList[index]);
                      }

                      bool isPartialPayment = fromPage == "custom-checkout"
                          ? Get.find<CheckOutController>().totalAmount > Get.find<CartController>().walletBalance
                          : Get.find<CartController>().totalPrice > Get.find<CartController>().walletBalance;
                      double totalAmount = fromPage == "custom-checkout" ? Get.find<CheckOutController>().totalAmount : Get.find<CartController>().totalPrice ;
                      double dueAmount = totalAmount - (isPartialPayment ? Get.find<CartController>().walletBalance : 0 );

                      checkoutController.showOfflinePaymentData(isShow: false);
                      showDialog(context: Get.context!, builder: (ctx)=> OfflinePaymentDialog(
                        totalAmount: Get.find<CartController>().walletPaymentStatus && isPartialPayment ? dueAmount : totalAmount, index: offlinePaymentMethodList.indexOf(offlineMethod),));
                    } ,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeExtraLarge),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withOpacity(
                          checkoutController.selectedOfflineMethod == offlineMethod ? 0.7 : 0.2,
                        )),
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                      child: Text(offlineMethod ?.methodName ?? ''),
                    ),
                  )).toList()) : Text("no_offline_payment_method_available".tr, style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall?.color),),
                ),

                (checkoutController.showOfflinePaymentInputData &&  isOffline && isSelected) ?
                OfflinePaymentInputDataView(customerInfoList: checkoutController.selectedOfflineMethod?.customerInformation,) : const SizedBox()

              ]),
            ),
          );
        },));
    });
  }
}

class OfflinePaymentInputDataView extends StatelessWidget {
  final List<CustomerInformation>? customerInfoList;
  const OfflinePaymentInputDataView({Key? key, required this.customerInfoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding( padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
      child: customerInfoList != null ? Column( crossAxisAlignment: CrossAxisAlignment.start , children: [

          Padding( padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
            child: Text("payment_info".tr, style: ubuntuMedium,),
          ),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: customerInfoList!.map((method) => Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(method.fieldName?.replaceAll("_", " ").capitalizeFirst ?? '', style: ubuntuRegular),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text(' :  ${Get.find<CheckOutController>().offlinePaymentInputField[customerInfoList!.indexOf(method)].text}', style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8))),
            ]),
          )).toList()),
        ],
      ) : const SizedBox(),
    );
  }
}