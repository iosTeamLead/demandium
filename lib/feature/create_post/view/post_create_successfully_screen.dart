import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class PostCreateSuccessfullyScreen extends StatelessWidget {
  const PostCreateSuccessfullyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'create_post'.tr),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: FooterBaseView(
        isCenter: true,
        child: WebShadowWrap(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: Image.asset(Images.rightMark,height: 70,width: 70,color: Theme.of(context).colorScheme.primary,),
            ),

            Text("your_post_has_been_created_successfully".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Text("see_who_is_responding_to_your_post".tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),maxLines: 5,
              overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,
            ),

            Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge,bottom: Dimensions.paddingSizeSmall),
              child: CustomButton(
                buttonText: "view_post".tr,
                height: ResponsiveHelper.isDesktop(context)? 45 :35 , width: ResponsiveHelper.isDesktop(context)? 150 : 130,
                radius: Dimensions.radiusExtraMoreLarge,
                onPressed: (){
                  Get.offNamed(RouteHelper.getMyPostScreen());
                },
              ),
            ),
            TextButton(
              onPressed: (){
                Get.offAllNamed(RouteHelper.getMainRoute(''));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50,30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('go_back_to_home'.tr, style: ubuntuRegular.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: Dimensions.fontSizeDefault,
              )),
            )
          ]),
        ),
      ),
    );
  }
}
