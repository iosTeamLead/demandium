import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class ServiceView extends StatelessWidget {
  final List<Service>? service;
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final Function(String type)? onVegFilterTap;
  const ServiceView({super.key, required this.service, this.isScrollable = false, this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall), this.noDataText, this.type, this.onVegFilterTap});

  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    int length = 0;
    isNull = service == null;
    if(!isNull) {
      length = service!.length;
    }

    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.fontSizeDefault),
        child: Text('sub_categories'.tr,style: ubuntuBold.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).primaryColor),),
      ),
      !isNull ? length > 0 ? GridView.builder(
        key: UniqueKey(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: Dimensions.paddingSizeLarge,
          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall,
          childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 3.5,
          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
        ),
        physics: isScrollable! ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        shrinkWrap: isScrollable! ? false : true,
        itemCount: length,
        padding: padding,
        itemBuilder: (context, index) {
          return ServiceWidget(service: service![index]);
        },
      ) : NoDataScreen(
        text: noDataText ?? 'no_services_found'.tr,
      ) : GridView.builder(
        key: UniqueKey(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: Dimensions.paddingSizeLarge,
          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : 0.01,
          childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 4,
          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
        ),
        physics: isScrollable! ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        shrinkWrap: isScrollable! ? false : true,
        itemCount: shimmerLength,
        padding: padding,
        itemBuilder: (context, index) {
          return ServiceShimmer(isEnabled: isNull, hasDivider: index != shimmerLength!-1);
        },
      ),

    ]);
  }
}
