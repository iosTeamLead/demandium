import 'package:demandium/feature/profile/controller/edit_profile_tab_controller.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class ProfileHeader extends GetView<UserController> {
  final UserInfoModel userInfoModel;
   const ProfileHeader({Key? key,required this.userInfoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Get.find<AuthController>().isLoggedIn();
    return GetBuilder<UserController>(builder: (userController){
      return SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: Stack(
              children: [
                SizedBox(
                  width: Get.width,
                  child: Column(children: [
                    const SizedBox(height:Dimensions.paddingSizeDefault),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(150.0)),
                          child: CustomImage(
                            width: 130.0,
                            height: 130.0,
                            image:isLoggedIn ? userController.userInfoModel.image != null ? "${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/user/profile_image/${userController.userInfoModel.image!}" : '':'',
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(width: Dimensions.paddingSizeLarge, height: Dimensions.paddingSizeExtraLarge,),
                    if(!isLoggedIn)
                      Text('guest_user'.tr,
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.5)),
                      ),
                    if( isLoggedIn && userInfoModel.fName != null && userInfoModel.lName != null )
                      Text("${userInfoModel.fName!} ${userInfoModel.lName!}",
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).textTheme.bodyMedium!.color),
                      ),

                    const SizedBox(width: Dimensions.paddingSizeLarge, height: Dimensions.paddingSizeExtraLarge,),
                    isLoggedIn ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(userInfoModel.bookingsCount != null)
                          ColumnText(
                            amount: userInfoModel.bookingsCount!,
                            title: 'bookings'.tr,
                          ),
                        ColumnText(
                          isProfileTimeAgo: true,
                          accountAgo: Get.find<UserController>().createdAccountAgo.tr,
                          amount: 340,
                          title: 'since_joined'.tr,
                        ),
                      ],
                    ) : const SizedBox(height: Dimensions.paddingSizeSmall),
                  ],),
                ),

                isLoggedIn ? Positioned(
                  right:Get.find<LocalizationController>().isLtr ? Dimensions.paddingSizeDefault : null,
                  left:Get.find<LocalizationController>().isLtr ?null: Dimensions.paddingSizeDefault,
                  top:Dimensions.paddingSizeSmall,
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.profileEdit);
                      Get.find<EditProfileTabController>().resetPasswordText();
                    },
                    child: Row(
                      children: [
                        Text('edit'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Theme.of(context).colorScheme.primary),),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                        Icon(Icons.edit,color: Theme.of(context).colorScheme.primary,size: Dimensions.fontSizeExtraLarge,)
                      ],
                    ),
                  ),
                ): const SizedBox()
              ],
            ),
          ));
    });
  }
}
