import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

void customSnackBar(String? message, {bool isError = true, double margin = Dimensions.paddingSizeSmall,int duration =2, Color? backgroundColor, Widget? customWidget, double borderRadius = Dimensions.radiusSmall}) {
  if(message != null && message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: backgroundColor ?? (isError ? Colors.red : Colors.green),
      message: customWidget ==null ? message.tr : null,
      messageText: customWidget,
      maxWidth: Dimensions.webMaxWidth,
      duration: Duration(seconds: duration),
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.only(
          top: Dimensions.paddingSizeSmall,
          left: ResponsiveHelper.isDesktop(Get.context) ? Dimensions.webMaxWidth/2: Dimensions.paddingSizeSmall,
          right: ResponsiveHelper.isDesktop(Get.context) ? (Get.width-Dimensions.webMaxWidth)/2: Dimensions.paddingSizeSmall,
          bottom: margin),
      borderRadius: borderRadius,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}