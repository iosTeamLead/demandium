import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class UpdateScreen extends StatelessWidget {
  final bool? isUpdate;

  const UpdateScreen({super.key, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              isUpdate! ? Images.update : Images.maintenance,
              width: Dimensions.logoSize,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
            ),

            Text(
              isUpdate! ? 'update_is_available'.tr : 'we_are_under_maintenance'.tr,
              style: ubuntuBold.copyWith(fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.023, color: Theme
                  .of(context).colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.02),

            Text(
              isUpdate! ? 'your_app_needs_to_update'.tr : 'we_will_be_right_back'
                  .tr,
              style: ubuntuRegular.copyWith(fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.0175, color: Theme
                  .of(context)
                  .disabledColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isUpdate! ? MediaQuery
                .of(context)
                .size
                .height * 0.03 : 0),

            isUpdate! ? CustomButton(
                buttonText: 'update_now'.tr, onPressed: () async {
              String appUrl = 'https://google.com';
              if (GetPlatform.isAndroid) {
                appUrl = Get
                    .find<SplashController>()
                    .configModel
                    .content!
                    .appUrlAndroid!;
              } else if (GetPlatform.isIOS) {
                appUrl = Get
                    .find<SplashController>()
                    .configModel
                    .content!
                    .appUrlIos!;
              }

              _launchUrl(Uri.parse(appUrl));

              if (await launchUrl(Uri.parse(appUrl))) {
                launchUrl(Uri.parse(appUrl));
              } else {
                customSnackBar('${'can_not_launch'.tr} $appUrl');
              }
            }) : const SizedBox(),

          ]),
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}