import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class CategoryBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => ServiceController(serviceRepo: ServiceRepo(apiClient: Get.find())));

  }
}