import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class FeatheredCategoryView extends StatefulWidget {
  const FeatheredCategoryView({Key? key}) : super(key: key);

  @override
  State<FeatheredCategoryView> createState() => _FeatheredCategoryViewState();
}

class _FeatheredCategoryViewState extends State<FeatheredCategoryView> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(builder: (serviceController){
      return SizedBox(
        height: serviceController.categoryList.length*345,
        child: ListView.builder(itemBuilder: (context,categoryIndex){

          int serviceItemCount;
          serviceItemCount = serviceController.categoryList[categoryIndex].servicesByCategory!.length>5?5
                : serviceController.categoryList[categoryIndex].servicesByCategory!.length;

          return  Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            ),
            margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom:ResponsiveHelper.isMobile(context)?Dimensions.paddingSizeSmall:0,left: 7,right: 7),
                      child: Text(serviceController.categoryList[categoryIndex].name??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getFeatheredCategoryService(
                            serviceController.categoryList[categoryIndex].name??"", serviceController.categoryList[categoryIndex]));
                      },
                      child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                        decoration: TextDecoration.underline,
                        color:Get.isDarkMode ?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 270,
                  width: Get.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: serviceItemCount,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        child: SizedBox(
                           width: Get.width / 2.3,child: ServiceWidgetVertical(service: serviceController.categoryList[categoryIndex].servicesByCategory![index],
                          isAvailable: true,fromType: '',)
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault)
              ],
            ),
          );
        },itemCount: serviceController.categoryList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
        ),
      );
    });
  }
}
