import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';


class WebHomeScreen extends StatelessWidget {
  final ScrollController? scrollController;
  const WebHomeScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {

    Get.find<BannerController>().setCurrentIndex(0, false);
    ConfigModel configModel = Get.find<SplashController>().configModel;

    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeExtraLarge,)),
        SliverToBoxAdapter(
          child: Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: WebBannerView(),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeDefault,),),
        const SliverToBoxAdapter(child: CategoryView(),),
        const SliverToBoxAdapter(
          child: Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                WebRecommendedServiceView(),
                SizedBox(width: Dimensions.paddingSizeLarge,),
                Expanded(child: WebPopularServiceView()),
              ],),
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: Dimensions.paddingSizeDefault,),
        ),

        SliverToBoxAdapter(
          child: Center(
            child: GetBuilder<ProviderBookingController>(builder: (providerController){
              return SizedBox(
                width: Dimensions.webMaxWidth,
                child: Row(
                  children:  [
                    if(configModel.content!.biddingStatus == 1)
                      SizedBox(
                        width: providerController.providerList != null && providerController.providerList!.isNotEmpty && configModel.content?.directProviderBooking==1
                            ? Dimensions.webMaxWidth/3.5 : Dimensions.webMaxWidth,
                        height:  240,
                        child: const HomeCreatePostView(),
                      ),
                    if(configModel.content?.directProviderBooking==1 && configModel.content!.biddingStatus == 1
                        && providerController.providerList != null && providerController.providerList!.isNotEmpty)
                      const SizedBox(width: Dimensions.paddingSizeLarge+5,),
                    if(configModel.content?.directProviderBooking==1)
                      Expanded(child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        child: const HomeRecommendProvider(),),
                      ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeDefault,),),
        const SliverToBoxAdapter(
          child: Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
                child: WebTrendingServiceView()
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeDefault,),),

        if(Get.find<AuthController>().isLoggedIn())
        const SliverToBoxAdapter(child: Center(
          child: SizedBox(width: Dimensions.webMaxWidth,
            child: WebRecentlyServiceView(),
          ),
        )),
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeDefault,),),

        const SliverToBoxAdapter(
          child: Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                children: [
                  SizedBox(height: Dimensions.paddingSizeLarge),
                  WebCampaignView(),
                  SizedBox(height: Dimensions.paddingSizeLarge),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: WebFeatheredCategoryView(),
            ),
          ),
        ),

        SliverToBoxAdapter(child: Center(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeSmall,
                  ),
                  child: TitleWidget(
                    title: 'all_service'.tr,
                  ),
                ),
                GetBuilder<ServiceController>(builder: (serviceController) {
                  return PaginatedListView(
                    showBottomSheet: true,
                    scrollController: scrollController!,
                    totalSize: serviceController.serviceContent != null ? serviceController.serviceContent!.total! : null,
                    offset: serviceController.serviceContent != null ? serviceController.serviceContent!.currentPage != null ? serviceController.serviceContent!.currentPage! : null : null,
                    onPaginate: (int offset) async => await serviceController.getAllServiceList(offset,false),
                    itemView: ServiceViewVertical(
                      service: serviceController.serviceContent != null ? serviceController.allService : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0,
                      ),
                      type: 'others',
                      noDataType: NoDataType.home,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),),
        const SliverToBoxAdapter(child: FooterView(),),
      ],
    );
  }
}
