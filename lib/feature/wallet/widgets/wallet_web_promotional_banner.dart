import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:demandium/feature/wallet/widgets/wallet_banner_view.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class WalletWebPromotionalBannerView extends GetView<BannerController> {
  final PageController _pageController = PageController();

  WalletWebPromotionalBannerView({super.key});
  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;
    return GetBuilder<WalletController>(
      builder: (walletController){
        if(walletController.bonusList != null && walletController.bonusList!.isEmpty){
          return const SizedBox();
        }else{
          return Container(alignment: Alignment.center,
            margin: const EdgeInsets.only(top: Dimensions.paddingSizeLarge,left: 5, right: 5),
            child: SizedBox(width: Dimensions.webMaxWidth, height: 100,
              child: walletController.bonusList != null ? walletController.bonusList!.length == 1 ?
              WalletBannerView(bonusModel: walletController.bonusList?[0],) :
              Stack(clipBehavior: Clip.none, fit: StackFit.expand, children: [
                PageView.builder(
                  onPageChanged: (int index) => walletController.setCurrentIndex(index, true),
                  controller: _pageController,
                  itemCount: (walletController.bonusList!.length/2).ceil(),
                  itemBuilder: (context, index) {
                    int index1 = index * 2;
                    int index2 = (index * 2) + 1;
                    bool hasSecond = index2 < walletController.bonusList!.length;
                    return Row(children: [
                      Expanded(child: WalletBannerView(bonusModel: walletController.bonusList?[index1],)),
                      const SizedBox(width: Dimensions.paddingSizeLarge),
                      Expanded(child: hasSecond
                        ? WalletBannerView(bonusModel: walletController.bonusList?[index2],)
                        : (!hasSecond && walletController.bonusList!.length > 2)
                        ? WalletBannerView(bonusModel: walletController.bonusList?[0],)
                        : const SizedBox(),),
                    ]);
                  },
                ),
                walletController.currentIndex != 0 ?
                Positioned(
                  child: Align(alignment: Alignment.centerLeft,
                    child: Padding(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                      child: InkWell(
                        onTap: () => _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                        child: Container(
                          height: 30, width: 30, alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                            color: Colors.white70.withOpacity(0.6), boxShadow:cardShadow,
                          ),
                          child: Center(child: Padding(padding:  EdgeInsets.only(
                            left: isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                            right: !isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                          ),
                            child: Icon(Icons.arrow_back_ios, color: dark.cardColor, size: 17),
                          ),),
                        ),
                      ),
                    ),
                  ),
                ) :
                const SizedBox(),
                walletController.currentIndex != ((walletController.bonusList!.length/2).ceil()-1) ?
                Positioned(child: Align(alignment: Alignment.centerRight,
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                    child: InkWell(
                      onTap: () => _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                      child: Container(height: 30, width: 30, alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white70.withOpacity(0.6), boxShadow: cardShadow),
                        child: Icon(Icons.arrow_forward_ios, size: 17, color: dark.cardColor),),
                    ),
                  ),
                ),

                ): const SizedBox(),],

              ): const WebWalletShimmer(),),
          );
        }
      },
    );
  }
}

class WebWalletShimmer extends StatelessWidget {
  const WebWalletShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08))
        ),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault),
        child: Shimmer(
          duration: const Duration(seconds: 2),
          enabled: true,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(height: 10, width: 20, decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 10),

                Container(height: 10, width: 50, decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 10),
                Container(height: 10, width: 70, decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(2))),
              ]),

            ],
          ),
        ),
      )),
      const SizedBox(width: Dimensions.paddingSizeLarge),
      Expanded(child: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08))
        ),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault),
        child: Shimmer(
          duration: const Duration(seconds: 2),
          enabled: true,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(height: 10, width: 20, decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 10),

                Container(height: 10, width: 50, decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 10),
                Container(height: 10, width: 70, decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(2))),
              ]),

            ],
          ),
        ),
      )),
    ]);
  }
}



