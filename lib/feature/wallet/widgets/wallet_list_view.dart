import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/loyalty_point/model/loyalty_point_model.dart';
import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:demandium/feature/wallet/model/wallet_filter_body.dart';
import 'package:demandium/feature/wallet/widgets/wallet_list_item.dart';
import 'package:demandium/feature/wallet/widgets/wallet_shimmer.dart';
import 'package:get/get.dart';

class WalletListView extends StatelessWidget {
  final ScrollController scrollController;

  const WalletListView({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<WalletController>(builder: (walletController){
      List<LoyaltyPointTransactionData> listOfTransaction = walletController.listOfTransaction;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeSmall),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

          const SizedBox(height: Dimensions.paddingSizeDefault+5,),
          Row(children: [
            Expanded(child: Text('wallet_history'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge ,color: Theme.of(context).textTheme.bodyLarge!.color),)),
            const SizedBox(width: Dimensions.paddingSizeSmall,),

             PopupMenuButton<WalletFilterBody>(
              onSelected: (WalletFilterBody body) {
                walletController.updateWalletFilterValue(body);
                walletController.getWalletTransactionData(1, reload: true , type: body.value ?? "");
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
                   Text( walletController.selectedWalletFilter?.title?.tr?? 'filter'.tr ,
                     style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
                   ),
                   Icon(Icons.arrow_drop_down_outlined, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
                 ],),
               ),
            ),
          ],),
          const SizedBox(height: Dimensions.paddingSizeExtraLarge+5,),

          listOfTransaction.isNotEmpty && walletController.walletTransactionModel!=null?
          PaginatedListView(
            scrollController: scrollController,
            totalSize: walletController.walletTransactionModel!.content!.transactions!.total!,
            onPaginate: (int offset) async => await walletController.getWalletTransactionData(
              offset, reload: false, type: walletController.selectedWalletFilter?.value ?? ""
            ),
            offset: walletController.walletTransactionModel!.content!.transactions?.currentPage,

            itemView: ListView.builder(
              itemCount: listOfTransaction.length,
              itemBuilder: (context,index){
                return WalletListItem( transactionData: listOfTransaction[index],);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),

          ):
          listOfTransaction.isEmpty && walletController.walletTransactionModel==null ?
          const WalletShimmer() :

          NoDataScreen(text: 'no_transaction_yet'.tr,type: NoDataType.transaction,),

        ],),
      );
    });
  }
}

