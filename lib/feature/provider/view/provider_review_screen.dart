import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/provider/widgets/provider_details_top_card.dart';
import 'package:get/get.dart';

class ProviderReviewScreen extends StatelessWidget {
  final String subCategories;
  final String providerId;
  const ProviderReviewScreen({Key? key, required this.subCategories, required this.providerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'provider_review'.tr),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: GetBuilder<ProviderBookingController>(

        initState: (_){
          Get.find<ProviderBookingController>().getProviderDetailsData(providerId, false);
        },
          builder: (providerBookingController){


        return FooterBaseView(
          isScrollView: true,
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: providerBookingController.providerDetailsContent!=null ?
            Column(children: [
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.05),
                child: ProviderDetailsTopCard(isAppbar: false,subcategories: subCategories,providerId: providerId,),
              ),
              Column(children: [
                Image.asset(Images.reviewIcon,width: 60,),
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                     child: Text(providerBookingController.providerDetailsContent!.provider!.avgRating.toString(),style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeOverLarge,color: Theme.of(context).colorScheme.primary),)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${providerBookingController.providerDetailsContent!.provider!.ratingCount} ${'ratings'.tr}",
                      style: ubuntuMedium.copyWith(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: Dimensions.fontSizeSmall
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall,),
                    Text(
                      "${providerBookingController.providerDetailsContent!.provider!.ratingCount} ${'reviews'.tr}",
                      style: ubuntuMedium.copyWith(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: Dimensions.fontSizeSmall
                      ),
                    ),
                  ],
                ),
                providerBookingController.providerDetailsContent!.provider!.reviews!=null && providerBookingController.providerDetailsContent!.provider!.reviews!.isNotEmpty?
                Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: providerBookingController.providerDetailsContent!.provider!.reviews!.length,
                    itemBuilder: (context, index){
                      return ServiceReviewItem(reviewData: providerBookingController.providerDetailsContent!.provider!.reviews![index],
                      );
                    },
                  ),
                ):SizedBox(height: Get.height*.4,child: const Center(child: EmptyReviewWidget())),
              ])
            ],
            ):const Center(child: CircularProgressIndicator()),
          ),
        );
      }),
    );
  }
}
