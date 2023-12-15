import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class WebFeatheredCategoryView extends StatefulWidget {
  const WebFeatheredCategoryView({Key? key}) : super(key: key);

  @override
  State<WebFeatheredCategoryView> createState() => _WebFeatheredCategoryViewState();
}

class _WebFeatheredCategoryViewState extends State<WebFeatheredCategoryView> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(builder: (serviceController){
      return SizedBox(
        height:Get.find<LocalizationController>().isLtr? serviceController.categoryList.length*315 : serviceController.categoryList.length*325,
        child: ListView.builder(itemBuilder: (context,categoryIndex){

          int serviceItemCount;
            serviceItemCount = serviceController.categoryList[categoryIndex].servicesByCategory!.length>4?4
                : serviceController.categoryList[categoryIndex].servicesByCategory!.length;

          return Container(
            height: Get.find<LocalizationController>().isLtr?305:315,
            width: Get.width,
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
                    Padding(padding: const EdgeInsets.only(bottom:Dimensions.paddingSizeSmall),
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
                Row(children: [
                  if(ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context))
                  SizedBox(
                    height: Get.find<LocalizationController>().isLtr?245:255,
                    width: Get.find<LocalizationController>().isLtr?245:255,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      child: CustomImage(
                      image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/category/${serviceController.categoryList[categoryIndex].image}',
                    ),),
                  ),
                  if(ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context))
                  const SizedBox(width: Dimensions.paddingSizeLarge,),

                  Expanded(
                    child: GridView.builder(
                      key: UniqueKey(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: Dimensions.paddingSizeDefault,
                        mainAxisSpacing:  Dimensions.paddingSizeDefault,
                        mainAxisExtent: Get.find<LocalizationController>().isLtr?235:250,
                        crossAxisCount:ResponsiveHelper.isDesktop(context) ?4 :ResponsiveHelper.isTab(context)? 3:2,
                      ),
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: serviceItemCount,
                      itemBuilder: (context, index) {
                        return ServiceWidgetVertical(service: serviceController.categoryList[categoryIndex].servicesByCategory![index],  isAvailable: true,fromType: '',);
                      },
                    ),
                  )
                ],),
              ],
            ),
          );
        },itemCount: serviceController.categoryList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      );
    });
  }
}
