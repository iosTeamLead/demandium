import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/create_post/widget/custom_date_picker.dart';
import 'package:demandium/feature/create_post/widget/custom_time_picker.dart';
import 'package:get/get.dart';

class CustomDateTimePicker extends StatelessWidget {
  const CustomDateTimePicker({super.key});

  @override
  Widget build(BuildContext context) {

    Get.find<CreatePostController>().resetSchedule();

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
      child: GetBuilder<CreatePostController>(builder: (createPostController){
        return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(Get.context!).hintColor,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 4 , width: 80,
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: Text('select_booking_schedule'.tr, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(Get.context!).colorScheme.primary,
                  ),
              ),
            ),
            const CustomDatePicker(),
            Padding(padding: EdgeInsets.symmetric(
                horizontal:  ResponsiveHelper.isDesktop(Get.context!)?Dimensions.paddingSizeLarge*2:0),
              child: const CustomTimePicker(),
            ),
            Padding(padding: EdgeInsets.symmetric(
                horizontal:  ResponsiveHelper.isDesktop(Get.context!)?Dimensions.paddingSizeLarge*3:0),
              child: actionButtonWidget(Get.context!, createPostController),
            ),
          ],
        ),
      );
      }),
    );
  }

  Row actionButtonWidget(BuildContext context, CreatePostController createPostController) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [

      TextButton(style: TextButton.styleFrom(padding: EdgeInsets.zero,
        minimumSize: const Size(50,30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: ()=> Get.back(),
          child:  Text(
          'cancel'.tr.toUpperCase(),
          style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.primary),
        )),
      const SizedBox(width: Dimensions.paddingSizeDefault,),

      CustomButton(
        width: ResponsiveHelper.isDesktop(context)?90:70,
        height: ResponsiveHelper.isDesktop(context)?45:35,
        radius: Dimensions.radiusExtraMoreLarge,
        buttonText: "ok".tr.toUpperCase(),
        onPressed: (){

          createPostController.buildSchedule();

          DateTime selectedDateTime = DateConverter.dateTimeStringToDate(createPostController.scheduleTime);
          DateTime currentDateTime = DateTime.now();

          Duration  difference = selectedDateTime.difference(currentDateTime);

          if(difference.inHours<3){
            customSnackBar("${"schedule_time_should_be".tr} ${AppConstants.scheduleTime} ${"later_from_now".tr}");
          }else{
            Get.back();
            Get.toNamed(RouteHelper.getCreatePostScreen(schedule: Get.find<CreatePostController>().scheduleTime));
          }},
      ),
    ]);
  }
}