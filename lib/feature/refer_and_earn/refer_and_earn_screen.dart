import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/refer_and_earn/widgets/refer_hint_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnScreen extends StatelessWidget {
  const ReferAndEarnScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> shareItem = [Images.share ];
    final List<String> hintList = ['invite_your_friends'.tr, '${'they_register'.tr} ${AppConstants.appName} ${'with_special_offer'.tr}', 'you_made_your_earning'.tr];
    return Scaffold(

      appBar:  CustomAppBar(title: 'refer_and_earn'.tr),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body:Center(
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: ExpandableBottomSheet(
            background: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
                    child: Image.asset(Images.referAndEarn, height: Get.height * 0.2),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),

                  Text('invite_friend_and_businesses'.tr,
                    textAlign: TextAlign.center, style: ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeOverLarge,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                  Text('copy_your_code'.tr, textAlign: TextAlign.center, style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                  )),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

                  Text('your_personal_code'.tr, textAlign: TextAlign.center,
                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).secondaryHeaderColor),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge,),

                  Padding(padding:  EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context)?Dimensions.webMaxWidth*0.15:0),
                    child: DottedBorder(padding: const EdgeInsets.all(3), borderType: BorderType.RRect,
                      radius: const Radius.circular(20), dashPattern: const [5, 5], color:Get.isDarkMode?Colors.grey :Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      strokeWidth: 1,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          child: Text(Get.find<UserController>().referCode, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: Get.find<UserController>().referCode));
                            customSnackBar('referral_code_copied'.tr,isError: false);
                          },
                          child: Container(
                            width: 85,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(60),
                            ),
                            child: Text('copy'.tr,style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white.withOpacity(0.9),
                            )),
                          ),
                        ),

                      ]),
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

                  Text('or_share'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),

                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: shareItem.map((item) => GestureDetector(
                      onTap: () => Share.share(Get.find<UserController>().referCode,
                        subject: 'email',
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        child: Image.asset(item, height: 50, width: 50,
                        ),
                      ),
                    )).toList(),),
                  ),
                ],
              ),
            ),
            persistentContentHeight: 80,
            expandableContent: ReferHintView(hintList: hintList),


          ),
        ),
      ),
    );
  }
}
