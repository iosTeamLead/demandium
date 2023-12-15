import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:demandium/feature/wallet/widgets/payment_item_list_widget.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class WalletTopCard extends StatelessWidget {
  final JustTheController tooltipController;
  const WalletTopCard({Key? key, required this.tooltipController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (walletController){

      double walletBalance = walletController.walletTransactionModel?.content?.walletBalance??0;

      return Container(
        margin: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault+8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.9)],
          ),
        ),

        child: Stack(alignment: AlignmentDirectional.bottomEnd,children: [
          Image.asset(Images.walletBackground,height: Dimensions.walletTopCardHeight*0.8,),
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                walletController.walletTransactionModel !=null?
                Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text('your_balance'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.white.withOpacity(0.8))),
                  Row(children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: Text(PriceConverter.convertPrice(walletBalance),style: ubuntuBold.copyWith(
                              fontSize: PriceConverter.convertPrice(walletBalance).length> 12 ? Dimensions.fontSizeExtraLarge : Dimensions.fontSizeOverLarge,color: Colors.white
                          ),overflow: TextOverflow.ellipsis,),
                        ),
                      ),
                    JustTheTooltip(
                      backgroundColor: Colors.black87, controller: tooltipController,
                      preferredDirection: AxisDirection.down, tailLength: 14, tailBaseWidth: 20,
                      content: Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child:  Column( mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start ,children: [
                          Text("add_fund_instruction".tr, style: ubuntuRegular.copyWith(color: Colors.white70),),
                        ]),
                      ),
                      child:  Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: InkWell( onTap: ()=> tooltipController.showTooltip(),
                          child: const Icon(Icons.info_outline_rounded, color: Colors.white70),
                        ),
                      )
                    )],
                  ),
                ]):
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(height: 15, width: 80,color: Colors.grey.shade300,),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                  Container(height: 20, width: 100,color: Colors.grey.shade300,),
                ],),

                ResponsiveHelper.isMobile(context) ?
                FloatingActionButton.small(
                  backgroundColor: Colors.white70,
                  onPressed: (){
                    _openAddFundDialog();
                  },
                  child: Icon(Icons.add, color: Theme.of(context).colorScheme.primary,size: 25,),
                ): FloatingActionButton.extended(
                  backgroundColor: Colors.white70,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onPressed: (){
                    _openAddFundDialog();
                  },
                  label: Text('add_fund'.tr,style: ubuntuBold.copyWith(color: Theme.of(context).colorScheme.primary),),
                  icon: Icon(Icons.add_circle_sharp, color: Theme.of(context).colorScheme.primary,size: 25,),),

              ],
            ),
          )
        ]),
      );
    });
  }

  void _openAddFundDialog() {
    showGeneralDialog(barrierColor: Colors.black.withOpacity(Get.isDarkMode ? 0.8 : 0.5 ),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: Theme.of(context).cardColor
              ),
              margin: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeLarge),
              child: const Stack(
                alignment: Alignment.topRight,
                clipBehavior: Clip.none,
                children: [
                  PaymentMethodListWidget(),
                  Positioned(top: -20,right: -20,child: Icon(Icons.cancel,color: Colors.white70,))
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: true,
    barrierLabel: '',
    context: Get.context!,
    pageBuilder: (context, animation1, animation2){
      return Container();
    });
  }
}
