import 'package:get/get.dart';
import 'package:demandium/feature/review/controller/submit_review_controller.dart';
import 'package:demandium/feature/review/repo/submit_review_repo.dart';

class SubmitReviewBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => SubmitReviewController(submitReviewRepo: SubmitReviewRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  }

}