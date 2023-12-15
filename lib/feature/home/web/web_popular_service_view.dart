import 'package:demandium/components/service_center_dialog.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class WebPopularServiceView extends StatelessWidget {
  const WebPopularServiceView({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(

      builder: (serviceController){
        if(serviceController.popularServiceList != null && serviceController.popularServiceList!.isEmpty){
          return const SizedBox();
        }else{
          if(serviceController.popularServiceList != null){
            List<Service>? serviceList = serviceController.popularServiceList;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('popular_services'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                      InkWell(
                        onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("popular_services")),
                        child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                          decoration: TextDecoration.underline,
                          color:Get.isDarkMode ?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                        )),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio:ResponsiveHelper.isMobile(context) ? 0.78:0.89,
                    crossAxisSpacing: Dimensions.paddingSizeDefault,
                    mainAxisSpacing: Dimensions.paddingSizeDefault,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  itemCount: serviceList!.length > 7 ? 8 : serviceList.length,
                  itemBuilder: (context, index){
                    Discount discount = PriceConverter.discountCalculation(serviceController.popularServiceList![index]);
                    return InkWell(
                      onTap: () {
                        //TODO: Product Details
                        Get.toNamed(
                          RouteHelper.getServiceRoute(serviceList[index].id!),
                          arguments: ServiceDetailsScreen(serviceID: serviceList[index].id!),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall-2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          boxShadow: Get.isDarkMode ? null: cardShadow,
                        ),
                        child: Column(children: [


                          Expanded(flex: 2,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                    child: CustomImage(
                                      image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${serviceList[index].thumbnail}',
                                      fit: BoxFit.cover, width: double.maxFinite
                                    ),
                                  ),

                                  if( discount.discountAmount != null && discount.discountAmountType!=null && discount.discountAmount! > 0) Positioned.fill(
                                    child: Align(alignment: Alignment.topRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.error,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(Dimensions.radiusDefault),
                                            topRight: Radius.circular(Dimensions.radiusSmall),
                                          ),
                                        ),
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text(
                                            PriceConverter.percentageOrAmount('${discount.discountAmount}', discount.discountAmountType!),
                                            style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                              Text(
                                serviceList[index].name!,
                                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                              Text(
                                serviceList[index].shortDescription!,
                                style: ubuntuLight.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                                maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall),


                              RatingBar(
                                rating: double.parse(serviceList[index].avgRating.toString()), size: 15,
                                ratingCount: serviceList[index].ratingCount,
                              ),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if(serviceList[index].variationsAppFormat!.defaultPrice != null )
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text(
                                        PriceConverter.convertPrice(
                                          double.parse(serviceList[index].variationsAppFormat!.defaultPrice.toString()),
                                          discount: 2.0, discountType: "DiscountType",
                                        ),
                                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                  InkWell(
                                    onTap: () {
                                      Get.find<CartController>().resetPreselectedProviderInfo();
                                      showModalBottomSheet(
                                          useRootNavigator: true,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) => ServiceCenterDialog(service: serviceList[index])
                                      );
                                    },
                                    child: Icon
                                      (Icons.add,
                                        color: Get.isDarkMode?light.cardColor: Theme.of(context).primaryColor,
                                        size: Dimensions.paddingSizeLarge
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ]),
                      ),
                    );
                  },
                )
              ],
            );
          }
          else{
            return  Padding(padding: const EdgeInsets.only(top: 65),
              child: GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.paddingSizeDefault,
                  mainAxisSpacing:  Dimensions.paddingSizeDefault,
                  childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 1 : .70,
                  crossAxisCount: 4,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap:  true,
                itemCount: 8,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return const ServiceShimmer(isEnabled: true, hasDivider: true);
                },
              ),
            );
          }
        }
      },
    );
  }
}
