import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ChooseLanguageBottomSheet extends StatelessWidget {
  const ChooseLanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Get.find<AuthController>().isLoggedIn();

    final List<MenuModel> menuList = [
      MenuModel(icon: Images.profile, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      MenuModel(icon: Images.customerCare, title: 'help_&_support'.tr, route: RouteHelper.getSupportRoute()),
    ];

    menuList.add(MenuModel(icon: Images.logout, title: isLoggedIn ? 'logout'.tr : 'sign_in'.tr, route: ''));

    return PointerInterceptor(
      child: GetBuilder<LocalizationController>(
        builder: (localizationController){
          return Container(
            width: Dimensions.webMaxWidth,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              color: Theme.of(context).cardColor,
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.verticalGapOf(Dimensions.paddingSizeExtraLarge),
                  Text("select_language".tr,style: ubuntuMedium.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeDefault),),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTab(context) ? 3 : 2,
                      childAspectRatio: (1/1),
                    ),
                    itemCount: localizationController.languages.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => LanguageWidget(
                      languageModel: localizationController.languages[index],
                      localizationController: localizationController, index: index,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  Gaps.verticalGapOf(Dimensions.paddingSizeExtraLarge),
                ],
              ),
              SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : 0),
            ]),
          );
        },
      ),
    );
  }
}
