import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/category/widgets/sub_category_widget.dart';

class SubCategoryView extends GetView<CategoryController> {
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final Function(String type)? onVegFilterTap;
  const SubCategoryView({super.key,
    this.isScrollable = false,
    this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall),
    this.noDataText, this.type,
    this.onVegFilterTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
     builder: (categoryController){
       if(categoryController.subCategoryList == null){
         return  SliverGrid(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisSpacing: Dimensions.paddingSizeLarge,
             mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeSmall,
             crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 3,
             mainAxisExtent: ResponsiveHelper.isMobile(context) ? 115 : 120,
           ),
           delegate: SliverChildBuilderDelegate((context, index) {
               return SubCategoryShimmer(isEnabled: true, hasDivider: index != shimmerLength!-1);
             },
             childCount: 6,
           ),
         );
       }else{
         List<CategoryModel> subCategoryList = categoryController.subCategoryList ?? [];
         return subCategoryList.isNotEmpty ? SliverGrid(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisSpacing:ResponsiveHelper.isTab(context) ? 0.0 : Dimensions.paddingSizeSmall,
             mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeSmall,
             crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 3,
             mainAxisExtent: ResponsiveHelper.isMobile(context) ? 118 : 120,
           ),
           delegate: SliverChildBuilderDelegate((context, index) {
             return SubCategoryWidget(categoryModel: subCategoryList[index]);
             },
             childCount: subCategoryList.length,
           ),
         ):
         SliverToBoxAdapter(
           child: SizedBox(
             height: Get.height / 1.5,
             child: NoDataScreen(
               text: noDataText ?? 'no_category_found'.tr,
               type: NoDataType.categorySubcategory,
             ),
           ),
         );
       }
     },
    );
  }
}


class SubCategoryShimmer extends StatelessWidget {
  final bool? isEnabled;
  final bool? hasDivider;
  const SubCategoryShimmer({super.key, required this.isEnabled, required this.hasDivider});

  @override
  Widget build(BuildContext context) {
    bool desktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.all(Dimensions.paddingSizeSmall)
          : const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: Get.isDarkMode? null: [BoxShadow(color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1)],
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        enabled: isEnabled!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: desktop ? 70 : 50,
                  width: desktop ? 70 : 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault,),
                Expanded(
                  flex: 5,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      height: desktop ? 20 : 20,
                      decoration: BoxDecoration(
                          color: Theme.of(context).shadowColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Container(
                      height: desktop ? 12 : 8,
                      margin: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
                      decoration: BoxDecoration(
                          color: Theme.of(context).shadowColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Container(
                      height: desktop ? 12 : 8,
                      margin: const EdgeInsets.only(right: 100),
                      decoration: BoxDecoration(
                          color: Theme.of(context).shadowColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

