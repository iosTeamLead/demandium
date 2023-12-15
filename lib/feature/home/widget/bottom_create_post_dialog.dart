import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/create_post/widget/custom_date_time_picker.dart';
import 'package:get/get.dart';

class BottomCreatePostDialog extends StatelessWidget {
  const BottomCreatePostDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(ResponsiveHelper.isDesktop(context)) {
      return  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: pointerInterceptor(),
      );
    }
    return pointerInterceptor();
  }

  pointerInterceptor(){
    return Container(
      width:ResponsiveHelper.isDesktop(Get.context!)? Dimensions.webMaxWidth/2:Dimensions.webMaxWidth,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusLarge),
            topRight: Radius.circular(Dimensions.radiusLarge),
          ),
          color: Theme.of(Get.context!).cardColor
      ),padding: const EdgeInsets.all(15),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          (ResponsiveHelper.isDesktop(Get.context)) ?
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 40, width: 40, alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white70.withOpacity(0.6),
                    boxShadow:Get.isDarkMode?null:[BoxShadow(
                      color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1,
                    )]
                ),
                child: InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black54,

                    )
                ),
              ),
            ],
          ) : Container(
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).hintColor,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 4 , width: 80,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault,),
          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
            child: Image.asset(Images.bottomCreatePostMan,height: 100, width: 70,),
          ),

          Text("can't_find_mindful_service".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            maxLines: 1, overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall,),
          Text("create_post_text_bottom".tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(Get.context!).textTheme.bodyLarge!.color!.withOpacity(0.6)),maxLines: 5,
            overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,
          ),

          const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
          CustomButton(
            buttonText: "create_post".tr,
            height: ResponsiveHelper.isDesktop(Get.context!)? 45: 40,
            width: 200,
            radius: Dimensions.radiusExtraMoreLarge,
            onPressed: (){
              Get.back();
              if(Get.find<AuthController>().isLoggedIn()){
                showModalBottomSheet(backgroundColor: Colors.transparent, isScrollControlled: true, context: Get.context!, builder: (BuildContext context){
                  return const CustomDateTimePicker();
                });
              }else{
                Get.toNamed(RouteHelper.getNotLoggedScreen(RouteHelper.main,"create_post"));
              }
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge,),
        ],),
    );
  }
}
