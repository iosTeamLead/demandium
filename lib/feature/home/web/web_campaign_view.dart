import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/home/web/web_banner_shimmer.dart';
import 'package:get/get.dart';

class WebCampaignView extends GetView<BannerController> {
  const WebCampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;

    final PageController pageController = PageController();
    return GetBuilder<CampaignController>(
      builder: (campaignController){
        if(campaignController.campaignList != null && campaignController.campaignList!.isEmpty){
          return const SizedBox();
        }else{
          return Container(
            alignment: Alignment.center,
            child: SizedBox(
                width: Dimensions.webMaxWidth,
                height: 250,
                child: campaignController.campaignList != null ?

            campaignController.campaignList!.length == 1 ?

            InkWell(
              onTap: () {
                if(isRedundentClick(DateTime.now())){
                  return;
                }
                campaignController.navigateFromCampaign(campaignController.campaignList![0].id!,campaignController.campaignList![0].discount!.discountType!);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: CustomImage(
                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/campaign/${campaignController.campaignList![0].coverImage}',
                  fit: BoxFit.fill,
                  height: 220,
                ),
              ),):

            Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [

                PageView.builder(
                  controller: pageController,
                  itemCount: (campaignController.campaignList!.length/2).ceil(),
                  itemBuilder: (context, index) {
                    String? baseUrl =  Get.find<SplashController>().configModel.content!.imageBaseUrl;
                    int index1 = index * 2;
                    int index2 = (index * 2) + 1;
                    bool hasSecond = index2 < campaignController.campaignList!.length;
                    return Row(children: [
                      Expanded(child: InkWell(
                        onTap: () {
                          if(isRedundentClick(DateTime.now())){
                            return;
                          }
                          campaignController.navigateFromCampaign(campaignController.campaignList![index1].id!,campaignController.campaignList![index1].discount!.discountType!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          child: CustomImage(
                            image: '$baseUrl/campaign/${campaignController.campaignList![index1].coverImage}', fit: BoxFit.cover, height: 220,
                          ),
                        ),
                      )),

                      const SizedBox(width: Dimensions.paddingSizeLarge),

                      Expanded(child: hasSecond ? InkWell(
                        onTap: () {
                          if(isRedundentClick(DateTime.now())){
                            return;
                          }
                          campaignController.navigateFromCampaign(campaignController.campaignList![index2].id!,campaignController.campaignList![index2].discount!.discountType!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          child: CustomImage(
                            image: '$baseUrl/campaign/${campaignController.campaignList![index2].coverImage}', fit: BoxFit.cover, height: 220,
                          ),
                        ),
                      ) :(!hasSecond && campaignController.campaignList!.length> 2 ) ? InkWell(
                        onTap: () {
                          if(isRedundentClick(DateTime.now())){
                            return;
                          }
                          campaignController.navigateFromCampaign(campaignController.campaignList![0].id!,campaignController.campaignList![0].discount!.discountType!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          child: CustomImage(
                            image: '$baseUrl/campaign/${campaignController.campaignList![0].coverImage}', fit: BoxFit.cover, height: 220,
                          ),
                        ),
                      ) :const SizedBox()),

                    ]);
                  },
                  onPageChanged: (int index) => campaignController.setCurrentIndex(index, true),
                ),

                campaignController.currentIndex != 0 ?
                Positioned(
                  top: 0, bottom: 0, left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                    child: InkWell(
                      onTap: () => pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                      child: Container(
                        height: 40, width: 40, alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white70.withOpacity(0.6),
                            boxShadow:cardShadow,
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(
                            left: isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                            right: !isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                          ),
                          child: Icon(
                              Icons.arrow_back_ios,
                              size: Dimensions.webArrowSize,
                              color: dark.cardColor
                          ),
                        ),
                      ),
                    ),
                  ),
                ) :
                const SizedBox(width: 0.0,),

                campaignController.currentIndex != ((campaignController.campaignList!.length/2).ceil()-1) ?
                Positioned(
                  top: 0, bottom: 0, right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                    child: InkWell(
                      onTap: () => pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                      child: Container(
                        height: 40, width: 40, alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white70.withOpacity(0.6),
                            boxShadow:cardShadow,
                        ),
                        child: Icon(
                            Icons.arrow_forward_ios,
                            size: Dimensions.webArrowSize,
                            color: dark.cardColor
                        ),
                      ),
                    ),
                  ),
                ) :
                const SizedBox(width: 0.0,),

              ],
            ) : const WebBannerShimmer()),
          );
        }

      },
    );
  }
}


class WebCampaignShimmer extends StatelessWidget {
  final bool enabled;
  const WebCampaignShimmer({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.webMaxWidth / 3.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimensions.paddingSizeDefault,),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault,)),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault,),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Container(
                  height: 130, width: 200,
                  margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1)],
                  ),
                  child: Shimmer(
                    duration: const Duration(seconds: 2),
                    interval: const Duration(seconds: 1),
                    enabled: enabled,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Container(
                        height: 120, width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            color: Theme.of(context).shadowColor
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start, children: [
                          Container(height: 15, width: 100, color:Theme.of(context).shadowColor),
                          const SizedBox(height: 5),
                          const RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                          const SizedBox(height: 5),
                          Container(height: 10, width: 130, color:Theme.of(context).shadowColor),
                          const SizedBox(height: 20),
                          Container(height: 10, width: 30, color: Theme.of(context).shadowColor),
                        ]),
                      ),
                    ]),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}