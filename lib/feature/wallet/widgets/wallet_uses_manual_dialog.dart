import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:get/get.dart';

class WalletUsesManualDialog extends StatelessWidget {
  const WalletUsesManualDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> noteList =[
      "earn_money_to_your_wallet_by_completing_the_offer".tr,
      "convert_your_loyalty_point_into_wallet_money".tr,
      "admin_also_reward_their_top_customer_with_wallet_money".tr,
      "send_your_wallet_money_while_order".tr
    ];

    return GetBuilder<WalletController>(builder: (controller){

      return Padding(
        padding: ResponsiveHelper.isMobile(context)? const EdgeInsets.fromLTRB(20,70,20,0) : EdgeInsets.zero,
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(ResponsiveHelper.isMobile(context))
                      InkWell(child: const Row(mainAxisAlignment: MainAxisAlignment.end,children: [Icon(Icons.highlight_remove,size: 20,)]),
                        onTap: ()=>Get.back(),
                      ),

                      Padding(
                          padding: const EdgeInsets.fromLTRB(0,Dimensions.paddingSizeSmall,0,Dimensions.paddingSizeSmall),
                          child: Text('how_to_use'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Get.isDarkMode?Colors.white70 :  Theme.of(context).primaryColor),)),
                      Column(
                        children: noteList.map((item) => Column(children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            const Padding(padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall,top: 5),
                              child: Icon(Icons.circle,size: 7,),
                            ),
                            Expanded(child: Text(item,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall!.color),)),
                          ]),
                          const SizedBox(height: Dimensions.paddingSizeSmall,),
                        ],)).toList(),
                      ),
                    ],),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}


