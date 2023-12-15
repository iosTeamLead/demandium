import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class OfferScreen extends GetView<ServiceController> {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(
        isBackButtonExist: false,
        title: 'offers'.tr,
      ),
      body: GetBuilder<ServiceController>(
        initState: (state) async {
         await controller.getOffersList(1,true);
        },
        builder: (serviceController){
          if( serviceController.offerBasedServiceList == null){
            return const Center(child: FooterBaseView(child: WebShadowWrap(child: Center(child: CircularProgressIndicator()))));
          }else{
            List<Service> serviceList = serviceController.offerBasedServiceList!;
              return Stack(
                children: [

                  FooterBaseView(
                    scrollController: scrollController,
                    isCenter: (serviceList.isEmpty),
                    child:serviceList.isNotEmpty ?  Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.paddingForChattingButton),
                      child: SizedBox(
                        width: Dimensions.webMaxWidth,
                        child: Column(
                          children: [
                            !ResponsiveHelper.isMobile(context)?Padding(
                              padding: EdgeInsets.fromLTRB(
                                Dimensions.paddingSizeDefault,
                                Dimensions.fontSizeDefault,
                                Dimensions.paddingSizeDefault,
                                Dimensions.paddingSizeSmall,
                              ),
                              child: TitleWidget(
                                title: 'current_offers'.tr,
                              ),
                            ):const SizedBox.shrink(),
                            ResponsiveHelper.isMobile(context)?const SizedBox(height: 120,):const SizedBox.shrink(),
                            PaginatedListView(
                              scrollController: scrollController,
                              totalSize: serviceController.offerBasedServiceContent != null ? serviceController.offerBasedServiceContent!.total! : null,
                              offset: serviceController.offerBasedServiceContent != null ? serviceController.offerBasedServiceContent!.currentPage != null ? serviceController.offerBasedServiceContent!.currentPage! : null : null,
                              onPaginate: (int offset) async => await serviceController.getOffersList(offset, false),
                              itemView: ServiceViewVertical(
                                service: serviceList,
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault,
                                  vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0,
                                ),
                                type: 'others',
                                noDataType: NoDataType.home,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ):
                    WebShadowWrap(
                      child: NoDataScreen(
                        text: "no_offer_found".tr,
                        type:  NoDataType.offers,
                      ),
                    ),
                  ),
                 ResponsiveHelper.isMobile(context) && serviceList.isNotEmpty
                     ? Align(
                   alignment: Alignment.topCenter,
                   child: Stack(
                     children: [
                       Container(
                         height: 120,
                         width: MediaQuery.of(context).size.width,
                         color: Theme.of(context).scaffoldBackgroundColor,
                       ),
                       Image.asset(
                         Images.offerBanner,
                         width: Get.width,
                         fit: BoxFit.cover,
                         height: 100,
                       ),
                       Container(
                         color: Colors.black54,
                         height: 100,
                         child: Center(
                           child: Text('current_offers'.tr,style: ubuntuMedium.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeExtraLarge),),
                         ),
                       )
                     ],
                   ),
                 )
                     :const SizedBox.shrink(),
                ],
              );
          }
        },
      ),
    );
  }
}