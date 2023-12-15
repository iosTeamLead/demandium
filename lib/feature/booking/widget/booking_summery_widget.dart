import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class BookingSummeryWidget extends StatelessWidget{
  final BookingDetailsContent bookingDetailsContent;
  const BookingSummeryWidget({Key? key, required this.bookingDetailsContent}) : super(key: key);

  @override
  Widget build(BuildContext context){
    double serviceDiscount = 0;
    bookingDetailsContent.detail?.forEach((service) {
      serviceDiscount = serviceDiscount + service.discountAmount!;
    });

    return GetBuilder<BookingDetailsController>(
        builder:(bookingDetailsController){
          if(!bookingDetailsController.isLoading) {

            double paidAmount = 0;

            double totalBookingAmount = bookingDetailsContent.totalBookingAmount ?? 0;
            bool isPartialPayment = bookingDetailsContent.partialPayments !=null && bookingDetailsContent.partialPayments!.isNotEmpty;

            if(isPartialPayment) {
              bookingDetailsContent.partialPayments?.forEach((element) {
              paidAmount = paidAmount + (element.paidAmount ?? 0);
              });
            }else{
              paidAmount  = totalBookingAmount - (bookingDetailsContent.additionalCharge ?? 0);
            }
            double dueAmount = totalBookingAmount - paidAmount;
            double additionalCharge = isPartialPayment ? totalBookingAmount - paidAmount : bookingDetailsContent.additionalCharge ?? 0;


            return Column( crossAxisAlignment: CrossAxisAlignment.start, children: [

              Padding(padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault),
                child: Text(
                    'booking_summery'.tr,
                    style:ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color))
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeDefault),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeEight),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeEight),
                  color: Theme.of(context).cardColor,
                  height: 40,
                  child:  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('service_info'.tr, style:ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyLarge!.color!,decoration: TextDecoration.none,
                    )),
                    Text('service_cost'.tr,style:ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyLarge!.color!,decoration: TextDecoration.none,
                    )),
                  ]),
                ),
              ),

              ListView.builder(itemBuilder: (context, index){
                return ServiceInfoItem(
                  bookingDetailsContent: bookingDetailsContent,
                  bookingService : bookingDetailsController.bookingDetailsContent!.detail![index],
                  bookingDetailsController: bookingDetailsController,
                  index: index,
                );
              },
                itemCount: bookingDetailsController.bookingDetailsContent!.detail?.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),

              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Divider(height: 2, color: Colors.grey,),
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('sub_total'.tr,
                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color,),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      PriceConverter.convertPrice(bookingDetailsController.allTotalCost,isShowLongPrice: true),
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                  ),
                ]),
              ),

              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'service_discount'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                        overflow: TextOverflow.ellipsis
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        "(-) ${PriceConverter.convertPrice(serviceDiscount)}",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'coupon_discount'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                      overflow: TextOverflow.ellipsis,),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text('(-) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalCouponDiscountAmount!.toDouble())}',
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),

              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'campaign_discount'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                      overflow: TextOverflow.ellipsis,),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text('(-) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalCampaignDiscountAmount!.toDouble())}',
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),

              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'service_vat'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                      overflow: TextOverflow.ellipsis,),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text('(+) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalTaxAmount!.toDouble(),isShowLongPrice: true)}',
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),

              if(bookingDetailsContent.extraFee != null && bookingDetailsContent.extraFee! > 0)
                Padding(
                  padding: const EdgeInsets.only(left : Dimensions.paddingSizeDefault , right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text( Get.find<SplashController>().configModel.content?.additionalChargeLabelName ?? "",style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge?.color),overflow: TextOverflow.ellipsis,
                      ),
                      Text("(+) ${PriceConverter.convertPrice( bookingDetailsController.bookingDetailsContent?.extraFee ?? 0,
                          isShowLongPrice:true)}",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color
                        ),
                      ),
                    ],
                  ),
                ),

              if(bookingDetailsContent.additionalCharge != null && additionalCharge < 0 && (bookingDetailsContent.paymentMethod != "cash_after_service" || bookingDetailsContent.partialPayments!.isNotEmpty ))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("refund".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge?.color),overflow: TextOverflow.ellipsis,
                      ),
                      Text(PriceConverter.convertPrice(additionalCharge, isShowLongPrice:true),
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color
                        ),
                      ),
                    ],
                  ),
                ),

              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Divider(height: 2, color: Colors.grey,),
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),

              !isPartialPayment && bookingDetailsContent.paymentMethod != "wallet_payment" ? (additionalCharge == 0) ||  bookingDetailsContent.paymentMethod == "cash_after_service" ?
              Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('grand_total'.tr,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalBookingAmount!.toDouble(),isShowLongPrice: true),
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),),
                  ),
                ],),
              ) : Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: DottedBorder(
                  dashPattern: const [8, 4],
                  strokeWidth: 1.1,
                  borderType: BorderType.RRect,
                  color: Theme.of(context).colorScheme.primary,
                  radius: const Radius.circular(Dimensions.radiusDefault),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.02),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                    child: Column(
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('grand_total'.tr,
                            style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.primary,),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              PriceConverter.convertPrice( totalBookingAmount ,isShowLongPrice: true),
                              style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color : Theme.of(context).colorScheme.primary,),),
                          ),
                        ],),

                        const SizedBox(height: Dimensions.paddingSizeSmall,),

                        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        //   Text("${"paid_amount".tr} (${bookingDetailsContent.paymentMethod.toString().tr})",
                        //     style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                        //     overflow: TextOverflow.ellipsis,),
                        //   Directionality(
                        //     textDirection: TextDirection.ltr,
                        //     child: Text( PriceConverter.convertPrice( paidAmount, isShowLongPrice: true),
                        //       style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                        //   )]
                        // ),
                        //
                        // SizedBox(height: additionalCharge > 0 ? Dimensions.paddingSizeSmall : 0),

                        additionalCharge > 0 ?
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text("${(bookingDetailsContent.bookingStatus == "pending"  || bookingDetailsContent.bookingStatus == "accepted" || bookingDetailsContent.bookingStatus == "ongoing")
                              ? "due_amount".tr : "paid_amount".tr} (${"cash_after_service".tr})",
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                            overflow: TextOverflow.ellipsis,),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text( PriceConverter.convertPrice (additionalCharge, isShowLongPrice: true),
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                          )]
                        ): const SizedBox()
                      ],
                    ),
                  ),
                ),
              ) :

              !isPartialPayment && bookingDetailsContent.paymentMethod == "wallet_payment" ?
              Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column( children: [

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('grand_total'.tr,
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.primary,),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                          PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalBookingAmount!.toDouble(),isShowLongPrice: true),
                          style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.primary,)),
                    ),
                  ],),

                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                  DottedBorder(
                    dashPattern: const [8, 4],
                    strokeWidth: 1.1,
                    borderType: BorderType.RRect,
                    color: Theme.of(context).colorScheme.primary,
                    radius: const Radius.circular(Dimensions.radiusDefault),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.02),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start ,children: [

                        Text( (bookingDetailsContent.additionalCharge! <= 0) ? 'total_order_amount_has_been_paid_by_customer'.tr : "has_been_paid_by_customer".tr,
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.primary,),
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: Dimensions.paddingSizeSmall,),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Row(children: [

                            Image.asset(Images.walletSmall,width: 17,),
                            const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                            Text( 'via_wallet'.tr,
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                              overflow: TextOverflow.ellipsis,),
                          ],),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              PriceConverter.convertPrice( paidAmount ,isShowLongPrice: true),
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                          )]
                        ),

                        if(additionalCharge > 0 )
                          Padding( padding: const EdgeInsets.only(top : 8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text("${(bookingDetailsContent.bookingStatus == "pending"  || bookingDetailsContent.bookingStatus == "accepted" || bookingDetailsContent.bookingStatus == "ongoing")
                                  ? "due_amount".tr : "paid_amount".tr} (${"cash_after_service".tr})",
                                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                                overflow: TextOverflow.ellipsis,),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  PriceConverter.convertPrice( additionalCharge, isShowLongPrice: true),
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                              )]
                            ),
                          )

                      ]),
                    ),
                  ),
                ]),
              )  :

              isPartialPayment ?
              Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: DottedBorder(
                  dashPattern: const [8, 4],
                  strokeWidth: 1.1,
                  borderType: BorderType.RRect,
                  color: Theme.of(context).colorScheme.primary,
                  radius: const Radius.circular(Dimensions.radiusDefault),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.02),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                    child: Column(
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('grand_total'.tr,
                            style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.primary,),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              PriceConverter.convertPrice( totalBookingAmount, isShowLongPrice: true),
                              style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color : Theme.of(context).colorScheme.primary,),),
                          ),
                        ],),

                        const SizedBox(height: Dimensions.paddingSizeSmall,),

                        ListView.builder(itemBuilder: (context, index){
                          String payWith = bookingDetailsContent.partialPayments?[index].paidWith ?? "";

                          return  Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Row(children: [

                                Image.asset(Images.walletSmall, width: 15,),

                                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                                Text( '${ payWith == "cash_after_service" ? "paid_amount".tr : payWith == "digital" && bookingDetailsContent.paymentMethod == "offline_payment" ? ""  :'paid_by'.tr} ''${payWith == "digital" ? "${bookingDetailsContent.paymentMethod}".tr : (payWith == "cash_after_service" ? "(${'cash_after_service'.tr})" : payWith).tr }',
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                                  overflow: TextOverflow.ellipsis,),
                              ],),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  PriceConverter.convertPrice( bookingDetailsContent.partialPayments?[index].paidAmount ?? 0,isShowLongPrice: true),
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                              )]),
                          );
                        },itemCount: bookingDetailsContent.partialPayments?.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),

                        bookingDetailsContent.partialPayments?.length == 1 && dueAmount > 0 ?
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text("${(bookingDetailsContent.bookingStatus == "pending"  || bookingDetailsContent.bookingStatus == "accepted" || bookingDetailsContent.bookingStatus == "ongoing")
                              ? "due_amount".tr : "paid_amount".tr} (${"cash_after_service".tr})",
                            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                            overflow: TextOverflow.ellipsis,),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              PriceConverter.convertPrice( dueAmount, isShowLongPrice: true),
                              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                          )]) : const SizedBox(),

                        // bookingDetailsContent.partialPayments?.length == 2 && dueAmount > 0 ?
                        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        //   Text("${bookingDetailsContent.isPaid == 1 ? "paid_amount".tr : "due_amount".tr} (${"cash_after_service".tr})",
                        //     style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                        //     overflow: TextOverflow.ellipsis,),
                        //   Directionality(
                        //     textDirection: TextDirection.ltr,
                        //     child: Text(
                        //       PriceConverter.convertPrice( dueAmount, isShowLongPrice: true),
                        //       style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                        //   )]) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ) : Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('grand_total'.tr,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      PriceConverter.convertPrice( totalBookingAmount,isShowLongPrice: true),
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),),
                  ),
                ],),
              ),

              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            ],
          );
          }
          return const SizedBox();
        });
  }
}


class ServiceInfoItem extends StatelessWidget {
  final BookingDetailsContent bookingDetailsContent;
  final int index;
  final BookingDetailsController bookingDetailsController;
  final BookingContentDetailsItem bookingService;
  const ServiceInfoItem({Key? key,required this.bookingService,required this.bookingDetailsController, required this.index, required this.bookingDetailsContent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double unitTotalCost = 0;
    try{
      unitTotalCost = bookingDetailsController.unitTotalCost[index];
    }catch(error) {
      if (kDebugMode) {
        print('error : $error');
      }
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width / 2,
                      child: Text(bookingService.serviceName != null ?bookingService.serviceName!:'',
                        style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color),
                        overflow: TextOverflow.ellipsis,),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        PriceConverter.convertPrice(unitTotalCost,isShowLongPrice: true),
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                SizedBox(
                  width: Get.width / 1.5,
                  child: Text(bookingService.variantKey??"",
                    style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
                    ),),
                ),
                Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
                priceText('unit_price'.tr, bookingService.serviceCost!.toDouble(), context,mainAxisAlignmentStart: true),
                Row(
                  children: [
                    Text('quantity'.tr,
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)),),
                    Text(" :  ${bookingService.quantity}",style: ubuntuRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                        fontSize: Dimensions.fontSizeExtraSmall),)
                  ],
                ),
                bookingService.discountAmount! > 0 ?
                priceText('discount'.tr,bookingService.discountAmount!.toDouble(), context,mainAxisAlignmentStart: true) : const SizedBox(),
                bookingService.campaignDiscountAmount! > 0 ?
                priceText('campaign'.tr, bookingService.campaignDiscountAmount!.toDouble(), context,mainAxisAlignmentStart: true) : const SizedBox(),
                bookingService.overallCouponDiscountAmount! > 0 ?
                priceText('coupon'.tr, bookingService.overallCouponDiscountAmount!.toDouble(), context,mainAxisAlignmentStart: true) : const SizedBox(),

              ],
            ),
          ],

        ));
  }

}


Widget priceText(String title,double amount,context, {bool mainAxisAlignmentStart = false}){
  return Column(
    children: [
      Row(
        mainAxisAlignment:mainAxisAlignmentStart?MainAxisAlignment.start: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title :   ',
            style: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeExtraSmall,
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(PriceConverter.convertPrice(amount,isShowLongPrice: true),style: ubuntuRegular.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
              fontSize: Dimensions.fontSizeExtraSmall
            ),),
          )
        ],
      ),
      Gaps.verticalGapOf(Dimensions.paddingSizeMini),
    ],
  );
}
