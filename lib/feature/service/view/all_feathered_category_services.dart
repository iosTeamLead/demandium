import 'package:demandium/feature/service/model/feathered_service_model.dart';
import 'package:get/get.dart';
import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/components/core_export.dart';

class AllFeatheredCategoryServiceView extends StatefulWidget {
  final String fromPage;
  final CategoryData categoryData;
  const AllFeatheredCategoryServiceView({super.key, required this.fromPage,required this.categoryData});

  @override
  State<AllFeatheredCategoryServiceView> createState() => _AllFeatheredCategoryServiceViewState();
}

class _AllFeatheredCategoryServiceViewState extends State<AllFeatheredCategoryServiceView> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(
        title:widget.fromPage ,showCart: true,),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: _buildBody(widget.fromPage,context,scrollController),
    );
  }

  Widget _buildBody(String fromPage,BuildContext context,ScrollController scrollController){
    return GetBuilder<ServiceController>(

      builder: (serviceController){
        return _buildWidget( widget.categoryData.servicesByCategory ,context);
      },
    );

  }

  Widget _buildWidget(List<Service>? serviceList,BuildContext context){
    return FooterBaseView(
      isCenter:(serviceList == null || serviceList.isEmpty),
      child: SizedBox(
        width: Dimensions.webMaxWidth,
        child: (serviceList != null && serviceList.isEmpty) ?  NoDataScreen(text: 'no_services_found'.tr,type: NoDataType.service,) :  serviceList != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            slivers: [

              if(ResponsiveHelper.isDesktop(context))
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.paddingSizeDefault,
                      Dimensions.fontSizeDefault,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall,
                    ),
                    child: TitleWidget(
                      title: widget.categoryData.name??"",
                    ),
                  ),
                ),

              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.paddingSizeDefault,
                  mainAxisSpacing:  Dimensions.paddingSizeDefault,
                  childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? .9 : .75,
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                  mainAxisExtent: 240,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    Get.find<ServiceController>().getServiceDiscount(serviceList[index]);
                    return ServiceWidgetVertical(service: serviceList[index],  isAvailable: true,fromType: widget.fromPage,);
                  },
                  childCount: serviceList.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: Dimensions.webCategorySize,)),
            ],
          ),
        ) : GridView.builder(
          key: UniqueKey(),
          padding: const EdgeInsets.only(
            top: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeDefault,
            left: Dimensions.paddingSizeDefault,
            right: Dimensions.paddingSizeDefault,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.paddingSizeDefault,
            mainAxisSpacing:  Dimensions.paddingSizeDefault,
            childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 1 : .70,
            crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ServiceShimmer(isEnabled: true, hasDivider: false);
          },
        ),
      ),
    );
  }
}

