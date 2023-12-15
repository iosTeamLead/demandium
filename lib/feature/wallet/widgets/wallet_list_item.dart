import 'package:demandium/components/custom_divider.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/loyalty_point/model/loyalty_point_model.dart';
import 'package:get/get.dart';

class WalletListItem extends StatelessWidget {
  final LoyaltyPointTransactionData transactionData;
  const  WalletListItem({Key? key, required this.transactionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String transactionType;
    if(transactionData.toUserAccount!=null && transactionData.toUserAccount=="balance_pending"){
      transactionType = transactionData.toUserAccount!.tr;
    }else{
      transactionType = transactionData.trxType.toString().tr;
    }

    double transactionAmount = transactionData.debit!=null && transactionData.debit!=0
        ? transactionData.debit?? 0 : transactionData.credit??0;
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Tooltip(
          message: transactionData.id,
          child: Row(
            children: [
              Text('XID  '.tr,
                overflow: TextOverflow.ellipsis,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                ),
              ),

              SizedBox(
                width: ResponsiveHelper.isDesktop(context)?Get.width*0.20:Get.width*0.5,
                child: Text('${transactionData.id}',
                  overflow: TextOverflow.ellipsis,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(transactionData.createdAt!)),
          textDirection: TextDirection.ltr,
          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).secondaryHeaderColor),
        )
      ]),
      Row(children: [
        SizedBox(height:90 ,width: 13,child: CustomDivider(height: 5,dashWidth: 0.7,axis: Axis.vertical,color: Get.isDarkMode?Colors.grey:Theme.of(context).colorScheme.primary,)),
        const SizedBox(width: Dimensions.paddingSizeSmall,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                border: Border.all(color: Theme.of(context).hintColor,width: 0.5)),
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,vertical: Dimensions.paddingSizeDefault),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Text(transactionType.tr,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)),),

                  Text.rich(
                    TextSpan(text: transactionData.debit!=0?"- ${PriceConverter.convertPrice(transactionAmount).replaceAll("-", "")}":"+ ${PriceConverter.convertPrice(transactionAmount)}",
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color:transactionData.debit!=0?Theme.of(context).colorScheme.error :Colors.green,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ]),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              const Divider()
            ],
          ),
        ),
      ],),
    ]);
  }
}
