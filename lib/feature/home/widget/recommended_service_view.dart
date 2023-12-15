import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class RecommendedServiceView extends StatelessWidget {
  const RecommendedServiceView({super.key});


  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return GetBuilder<ServiceController>(
      builder: (serviceController){
        if(serviceController.recommendedServiceList != null && serviceController.recommendedServiceList!.isEmpty){
          return const SizedBox();
        }
        else{
          if(serviceController.recommendedServiceList != null){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 15, Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,),
                  child: TitleWidget(
                    title: 'recommended_for_you'.tr,
                    onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("fromRecommendedScreen")),
                  ),
                ),
                SizedBox(
                    height: 115,
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      itemCount: serviceController.recommendedServiceList!.length > 10 ? 10 : serviceController.recommendedServiceList!.length,
                      itemBuilder: (context, index){
                        Discount discountValue =  PriceConverter.discountCalculation(serviceController.recommendedServiceList![index]);
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, Dimensions.paddingSizeSmall, 2),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.getServiceRoute(serviceController.recommendedServiceList![index].id!),
                                arguments: ServiceDetailsScreen(serviceID: serviceController.recommendedServiceList![index].id!),
                              );
                            },
                            child: SizedBox(
                              height: 110, width: MediaQuery.of(context).size.width/1.20,
                              child: ServiceModelView(
                                serviceList: serviceController.recommendedServiceList!,
                                discountAmountType: discountValue.discountAmountType,
                                discountAmount: discountValue.discountAmount,
                                index: index,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,)
              ],
            );
          }else{
            return Column(
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1)],
                        ),
                        child: Center(child: Container(
                          height: ResponsiveHelper.isMobile(context)?10:ResponsiveHelper.isTab(context)?15:20,
                          color: Theme.of(context).shadowColor,
                          margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        ),),
                      ),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1)],
                        ),
                        child: Center(child: Container(
                          height: ResponsiveHelper.isMobile(context)?10:ResponsiveHelper.isTab(context)?15:20,
                          color: Theme.of(context).shadowColor,
                          margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        ),),
                      )
                    ],),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),
                const SizedBox(
                    height: 115,
                    child: RecommendedServiceShimmer(enabled: true)),
                const SizedBox(height: Dimensions.paddingSizeSmall,),
              ],
            );
          }
        }
      },
    );
  }
}

class RecommendedServiceShimmer extends StatelessWidget {
  final bool enabled;
  const RecommendedServiceShimmer({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeSmall,),
      itemCount: 10,
      itemBuilder: (context, index){
        return Container(
          width: MediaQuery.of(context).size.width/1.20,
          margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,bottom: 5),
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1)],
          ),
          child: Shimmer(
            duration: const Duration(seconds: 1),
            interval: const Duration(seconds: 1),
            enabled: enabled,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 90, width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    color: Theme.of(context).shadowColor
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 15, width: 100, color: Theme.of(context).shadowColor),
                    const SizedBox(height: 5),
                    Container(height: 10, width: 130, color: Theme.of(context).shadowColor),
                    const SizedBox(height: 5),
                    const RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                  ]),
                ),
              ),

            ]),
          ),
        );
      },
    );
  }
}