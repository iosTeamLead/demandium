import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/create_post/widget/custom_date_time_picker.dart';
import 'package:get/get.dart';

class HomeCreatePostView extends StatelessWidget {
  const HomeCreatePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
      margin: const EdgeInsets.only(top: Dimensions.paddingSizeLarge,bottom: Dimensions.paddingSizeDefault),
      child: Stack(
        alignment:Get.find<LocalizationController>().isLtr? Alignment.bottomLeft: Alignment.bottomRight,
        children:[
          Image.asset(Images.homeCreatePostMan,height: 120, width: 110,),
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [

              const SizedBox(width: 100,),
              Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text("post_for_customized_service".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall,),
                  Text("create_post_text".tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  CustomButton(
                    buttonText: "create_post".tr,
                    height: 40,
                    width: 130,
                    radius: Dimensions.radiusExtraMoreLarge,
                    onPressed: (){
                      if(Get.find<AuthController>().isLoggedIn()){
                        showModalBottomSheet(backgroundColor: Colors.transparent, isScrollControlled: true, context: context, builder: (BuildContext context){
                          return const CustomDateTimePicker();
                        });
                        Get.find<CreatePostController>().resetCreatePostValue();
                      }else{
                        Get.toNamed(RouteHelper.getNotLoggedScreen(RouteHelper.main.tr,"create_post"));
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge,),

                ]),
              )
            ]),
          ),
      ],),
    );
  }
}
