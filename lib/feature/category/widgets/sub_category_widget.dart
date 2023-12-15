import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class SubCategoryWidget extends GetView<ServiceController> {
  final CategoryModel? categoryModel;
  const SubCategoryWidget({super.key, required this.categoryModel,});

  @override
  Widget build(BuildContext context) {
    bool desktop = ResponsiveHelper.isDesktop(context);

    return InkWell(
      onTap: () {
        Get.find<ServiceController>().cleanSubCategory();
        Get.toNamed(RouteHelper.allServiceScreenRoute(categoryModel!.id!.toString()));
      },

      child: Container(
        margin: EdgeInsets.symmetric(horizontal:ResponsiveHelper.isDesktop(context)?0: Dimensions.paddingSizeDefault),
        padding: const EdgeInsets.all(
            Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            color: Theme.of(context).cardColor,
            boxShadow: Get.isDarkMode ? null: cardShadow
        ),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            child: CustomImage(
              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/category/${categoryModel!.image}',
              height: desktop ? 120 : 78, width: desktop ? 120 : 78, fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(children: [
                  Expanded(child: Text(
                    categoryModel!.name!,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                    maxLines: desktop ? 1 : 1, overflow: TextOverflow.ellipsis,
                  )),
                ]),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Text(
                  categoryModel!.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),
                Text(
                  "${categoryModel!.serviceCount} ${'services'.tr} ",
                  style: ubuntuRegular.copyWith(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
