import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';


class EmptyReviewWidget extends StatelessWidget {
  const EmptyReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebShadowWrap(
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Images.emptyReview,scale:Dimensions.paddingSizeSmall,color: Get.isDarkMode ?  Theme.of(context).primaryColorLight: Theme.of(context).primaryColor,),
                const SizedBox(height: 20.0,),
                Text("no_review_yet".tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),),
                const SizedBox(height: 50.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
