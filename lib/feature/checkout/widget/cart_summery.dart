import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/checkout/widget/row_text.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class CartSummery extends StatelessWidget {
  const CartSummery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tooltipController = JustTheController();
    ConfigModel configModel = Get.find<SplashController>().configModel;

    return GetBuilder<CartController>(
        builder: (cartController){

          List<CartModel> cartList = cartController.cartList;
          double additionalCharge = configModel.content?.additionalCharge == 1 ? configModel.content?.additionalChargeFeeAmount ?? 0.0 : 0.0;
          double subTotalPrice = 0;
          double disCount = 0;
          double campaignDisCount = 0;
          double couponDisCount = 0;
          double vat = 0;

          double walletBalance = cartController.walletBalance;
          double bookingAmount = cartController.totalPrice;

          bool isPartialPayment = walletBalance < bookingAmount;
          double paidAmount = isPartialPayment ? walletBalance : bookingAmount;

          bool walletPaymentStatus = cartController.walletPaymentStatus;


          for (var cartModel in cartController.cartList) {
            subTotalPrice = subTotalPrice + (cartModel.serviceCost * cartModel.quantity); //(without any discount and coupons)
            disCount = disCount + cartModel.discountedPrice ;
            campaignDisCount = campaignDisCount + cartModel.campaignDiscountPrice;
            couponDisCount = couponDisCount + cartModel.couponDiscountPrice;
            vat = vat + (cartModel.taxAmount );

          }
          double grandTotal = ((subTotalPrice  - (couponDisCount + disCount + campaignDisCount)) + vat + additionalCharge );
          double dueAmount = (grandTotal - ( walletPaymentStatus ? paidAmount :0 ));


          return Column(
            children: [
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Text(
                'cart_summary'.tr,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault,),
              Container(
                decoration: BoxDecoration(color: Get.isDarkMode? Theme.of(context).hoverColor : Theme.of(context).cardColor, boxShadow:Get.isDarkMode ?null: shadow),
                child: Padding(
                  padding: const EdgeInsets.all( Dimensions.paddingSizeDefault),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: cartList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          double totalCost = cartList.elementAt(index).serviceCost.toDouble() * cartList.elementAt(index).quantity;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RowText(title: cartList.elementAt(index).service!.name!, quantity: cartList.elementAt(index).quantity, price: totalCost),
                              SizedBox(
                                width:Get.width / 2.5,
                                child: Text(
                                  cartList.elementAt(index).variantKey,
                                  style: ubuntuMedium.copyWith(
                                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.4),
                                      fontSize: Dimensions.fontSizeSmall),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeDefault,)
                            ],
                          );
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      RowText(title: 'sub_total'.tr, price: subTotalPrice),
                      RowText(title: 'discount'.tr, price: disCount),
                      RowText(title: 'campaign_discount'.tr, price: campaignDisCount),
                      RowText(title: 'coupon_discount'.tr, price: couponDisCount),
                      RowText(title: 'vat'.tr, price: vat),


                      (configModel.content?.additionalChargeLabelName != "" && configModel.content?.additionalCharge == 1) ?
                      GetBuilder<CheckOutController>(builder: (controller){
                        return  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                          Expanded(
                            child: Row(children: [
                              Flexible(child: Text(configModel.content?.additionalChargeLabelName ?? "", style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),overflow: TextOverflow.ellipsis,)),
                              JustTheTooltip(
                                backgroundColor: Colors.black87, controller: tooltipController,
                                preferredDirection: AxisDirection.down, tailLength: 14, tailBaseWidth: 20,
                                content: Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  child:  Column( mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start ,children: [
                                    Text(configModel.content?.additionalChargeLabelName ?? "", style: ubuntuRegular.copyWith(color: Colors.white70),),
                                  ]),
                                ),
                                child:  Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                  child: InkWell( onTap: ()=> tooltipController.showTooltip(),
                                    child: const Icon(Icons.info_outline_rounded, size: Dimensions.paddingSizeDefault,),
                                  ),
                                )
                              ),
                            ],),
                          ),
                          Text("(+) ${PriceConverter.convertPrice( additionalCharge, isShowLongPrice: true)}", style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)
                        ],);
                      }): const SizedBox(),

                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Divider(
                        height: 1,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      RowText(title:'grand_total'.tr , price: grandTotal),
                      if(Get.find<CartController>().walletPaymentStatus)
                        RowText(title:'paid_by_wallet'.tr , price: paidAmount),
                      if(Get.find<CartController>().walletPaymentStatus && isPartialPayment)
                        RowText(title:'due_amount'.tr , price: dueAmount),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: ConditionCheckBox(),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault,),
            ],
          );
        }
    );
  }
}
