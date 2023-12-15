import 'package:get/get.dart';
import 'package:demandium/components/custom_snackbar.dart';
import 'package:demandium/core/helper/route_helper.dart';
import 'package:demandium/feature/auth/controller/auth_controller.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      if(Get.currentRoute != RouteHelper.getSignInRoute('splash')){
        Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.main));
      }
    }else{
      customSnackBar("${response.statusCode!}".tr);
    }
  }
}