import 'package:get/get.dart';
import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/components/core_export.dart';

class ServiceViewVertical extends GetView<ServiceController> {
  final List<Service>? service;
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final NoDataType? noDataType;
  final String? fromPage;

  final Function(String type)? onVegFilterTap;
  const ServiceViewVertical({super.key, this.fromPage="", required this.service, this.isScrollable = false, this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall), this.noDataText, this.type, this.onVegFilterTap, this.noDataType});

  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    int length = 0;

    isNull = service == null;
    if(!isNull){
      length = service!.length;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
        children: [
          !isNull ? length > 0 ?
          GridView.builder(
            key: UniqueKey(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: Dimensions.paddingSizeDefault,
              mainAxisSpacing:  Dimensions.paddingSizeDefault,
              childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? .9 :  .70,
              mainAxisExtent:ResponsiveHelper.isMobile(context) ?  235 : 260 ,
              crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,),
            physics: isScrollable! ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            shrinkWrap: isScrollable! ? false : true,
            itemCount: service!.length,
            padding: padding,
            itemBuilder: (context, index) {
              bool isAvailable = service![index].isActive == 0 ? false:true;
              controller.getServiceDiscount(service![index]);
              return ServiceWidgetVertical(service: service![index],  isAvailable: isAvailable,fromType: '',fromPage: fromPage??"");
              },
          ):
          SizedBox(
            height: MediaQuery.of(context).size.height*.6,
            child: NoDataScreen(
                text: noDataText ?? 'no_services_found'.tr,
                type: noDataType),
          ):
          GridView.builder(
            key: UniqueKey(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: Dimensions.paddingSizeDefault,
              mainAxisSpacing:  Dimensions.paddingSizeDefault,
              childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 1 : .70,
              crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
            ),
            physics: isScrollable! ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            shrinkWrap: isScrollable! ? false : true,
            itemCount: shimmerLength,
            padding: padding,
            itemBuilder: (context, index) {
              return ServiceShimmer(isEnabled: true, hasDivider: index != shimmerLength! - 1);
        },
      ),
    ]);
  }
}
