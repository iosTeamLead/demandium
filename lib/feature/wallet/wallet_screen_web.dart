import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/loyalty_point/model/loyalty_point_model.dart';
import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:demandium/feature/wallet/model/wallet_filter_body.dart';
import 'package:demandium/feature/wallet/widgets/wallet_list_item.dart';
import 'package:demandium/feature/wallet/widgets/wallet_shimmer.dart';
import 'package:demandium/feature/wallet/widgets/wallet_top_card.dart';
import 'package:demandium/feature/wallet/widgets/wallet_uses_manual_dialog.dart';
import 'package:demandium/feature/wallet/widgets/wallet_web_promotional_banner.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class WalletScreenWeb extends StatelessWidget {
  final JustTheController tooltipController;
  final ScrollController scrollController;
  const WalletScreenWeb({Key? key, required this.scrollController, required this.tooltipController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FooterBaseView(
      child: GetBuilder<WalletController>(builder: (walletController){
        List<LoyaltyPointTransactionData> listOfTransaction = walletController.listOfTransaction;
        return Center(
          child: SizedBox(width: Dimensions.webMaxWidth, child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Expanded(flex: 2,child: WebShadowWrap(child: Column(children: [

              WalletTopCard(tooltipController: tooltipController,),
              const WalletUsesManualDialog(),
              const SizedBox(height: 190,)

            ]))),
            const SizedBox(width: Dimensions.paddingSizeDefault,),
            Expanded(flex: 3,child: Column(children: [

              WalletWebPromotionalBannerView(),

              WebShadowWrap( maxHeight: Get.height * 0.7, child: Column(children: [
                const SizedBox(height: Dimensions.paddingSizeSmall,),
                Row(children: [
                  Expanded(child: Text('wallet_history'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge ,color: Theme.of(context).textTheme.bodyLarge!.color),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),

                  PopupMenuButton<WalletFilterBody>(
                    onSelected: (WalletFilterBody body) {
                      walletController.updateWalletFilterValue(body);
                      walletController.getWalletTransactionData(1, reload: true, type: body.value ?? "" );
                    },
                    itemBuilder: (BuildContext context) {
                      return walletController.walletFilterList.map((WalletFilterBody option) {
                        return PopupMenuItem<WalletFilterBody>(
                          value: option,
                          child: Text(option.title?.tr??""),
                        );
                      }).toList();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge),
                          border: Border.all(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.7), width: 0.8)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall-2),
                      child: Row(children: [
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                        Text( walletController.selectedWalletFilter?.title?.tr ?? 'filter'.tr ,
                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
                        ),
                        Icon(Icons.arrow_drop_down_outlined, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
                      ],),
                    ),
                  ),
                ],),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge + 5,),

                listOfTransaction.isNotEmpty && walletController.walletTransactionModel != null?
                Expanded(
                  child: PaginatedListView(
                    scrollController: scrollController,
                    totalSize: walletController.walletTransactionModel!.content!.transactions!.total!,
                    onPaginate: (int offset) async => await walletController.getWalletTransactionData(
                      offset, reload: false, type: walletController.selectedWalletFilter?.value ?? ""
                    ),
                    offset: walletController.walletTransactionModel!.content!.transactions?.currentPage,
                    bottomPadding: 0,
                    itemView: Expanded(
                      child: ListView.builder(
                        itemCount: listOfTransaction.length,
                        itemBuilder: (context,index){
                          return WalletListItem( transactionData: listOfTransaction[index],);
                        },

                      ),
                    ),

                  ),
                ):
                listOfTransaction.isEmpty && walletController.walletTransactionModel==null ?
                const Expanded(child: WalletShimmer()) :

                NoDataScreen(text: 'no_transaction_yet'.tr,type: NoDataType.transaction,),
              ],))
            ]))
          ])),
        );
      }),
    );
  }
}
