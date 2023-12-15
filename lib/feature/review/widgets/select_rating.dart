import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/review/controller/submit_review_controller.dart';

class SelectRating extends StatelessWidget {
  final String revivedId;
  final bool clickable;
  const SelectRating({Key? key, required this.revivedId, this.clickable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmitReviewController>(
        builder: (submitReviewController) {
      return SizedBox(
        height: 50.0,
        child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return starWidget(submitReviewController,index);
            },shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics()
          ,),
      );
    });
  }

  Widget starWidget(SubmitReviewController submitReviewController,int index) {
    return IconButton(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      onPressed: clickable? () {
        submitReviewController.selectReview(index+1,revivedId);
      }:null,
      icon: Image.asset(
        index <int.parse(submitReviewController.selectedRating[revivedId].toString()) ? Images.starFill:Images.starBorder,
        width: 24.0,
        height: 24.0,
      ),
    );
  }
}
