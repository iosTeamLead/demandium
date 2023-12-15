import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class WebRecentlyServiceView extends StatelessWidget {
  const WebRecentlyServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
        builder: (serviceController){
      if(serviceController.recentlyViewServiceList != null && serviceController.recentlyViewServiceList!.isEmpty){
        return const SizedBox();
      }else{
        if(serviceController.recentlyViewServiceList != null){
          return  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('recently_view_services'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                  InkWell(
                    onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("recently_view_services")),
                    child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      decoration: TextDecoration.underline,
                      color:Get.isDarkMode ?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge,),
              GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.paddingSizeDefault,
                  mainAxisSpacing:  Dimensions.paddingSizeDefault,
                  childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 0.92 : .70,
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                ),
                physics:const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: serviceController.recentlyViewServiceList!.length>5?5:serviceController.recentlyViewServiceList!.length,
                itemBuilder: (context, index) {
                  return ServiceWidgetVertical(service: serviceController.recentlyViewServiceList![index],  isAvailable: true,fromType: '',);
                },
              )
            ],
          );
        }
        else{
          return const SizedBox();
        }
      }
    });
  }
}
