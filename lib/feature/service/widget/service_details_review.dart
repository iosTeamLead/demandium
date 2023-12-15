import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';


class ServiceDetailsReview extends StatefulWidget {
  final List<ReviewData> reviewList;
  final String serviceID;
  final Rating rating;
  const ServiceDetailsReview({Key? key,required this.reviewList, required this.rating, required this.serviceID}) : super(key: key);

  @override
  State<ServiceDetailsReview> createState() => _ServiceDetailsReviewState();
}

class _ServiceDetailsReviewState extends State<ServiceDetailsReview> {


@override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double fiveStar = 0.0, fourStar = 0.0, threeStar = 0.0,twoStar = 0.0, oneStar = 0.0;
    int reviewCount =0;
    Rating rating = widget.rating;

    for(int i =0 ; i< rating.ratingGroupCount!.length; i++){
      if(rating.ratingGroupCount![i].reviewRating == 1){
        oneStar = (rating.ratingGroupCount![i].reviewRating! * rating.ratingCount!) / 100;
      }
      if(rating.ratingGroupCount![i].reviewRating == 2){
        twoStar = (rating.ratingGroupCount![i].reviewRating! * rating.ratingCount!) / 100;
      }
      if(rating.ratingGroupCount![i].reviewRating == 3){
        threeStar = (rating.ratingGroupCount![i].reviewRating! * rating.ratingCount!) / 100;
      }
      if(rating.ratingGroupCount![i].reviewRating == 4){
        fourStar = (rating.ratingGroupCount![i].reviewRating! * rating.ratingCount!) / 100;
      }
      if(rating.ratingGroupCount![i].reviewRating == 5){
        fiveStar = (rating.ratingGroupCount![i].reviewRating! * rating.ratingCount!) / 100;
      }
    }

    for(int i =0 ; i< widget.reviewList.length; i++){
      if(widget.reviewList[i].reviewComment!=null && widget.reviewList[i].reviewComment!='a'){
        reviewCount++;
      }
    }

    if(widget.reviewList.isNotEmpty) {
      return  SingleChildScrollView(
        child: Center(
          child: WebShadowWrap(
            child: SizedBox(
              width: Dimensions.webMaxWidth,

              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            boxShadow:Get.isDarkMode ? null: cardShadow
                        ),
                        child: Column(
                          children: [
                            Align(alignment: Alignment.centerLeft, child: Text("reviews".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),fontSize: Dimensions.fontSizeDefault))),
                            const Divider(),
                            Text(rating.averageRating.toString(), style: ubuntuMedium.copyWith(color:Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeForReview )),
                            Gaps.verticalGapOf(3.0),
                            RatingBar(rating: double.parse('${rating.averageRating}')),
                            Gaps.verticalGapOf(8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${rating.ratingCount.toString()} ${'ratings'.tr}",
                                  style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                                ),
                                const SizedBox(width: Dimensions.paddingSizeSmall,),
                                Text(
                                  "$reviewCount ${'reviews'.tr}",
                                  style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Gaps.verticalGapOf(24),

                    //progress_Bar
                    _progressBar(
                      title: 'excellent'.tr,
                      colr: const Color(0xFF69B469),
                      percent: fiveStar,
                    ),
                    _progressBar(
                      title: 'good'.tr,
                      colr: const Color(0xFFB0DC4B),
                      percent: fourStar,
                    ),
                    _progressBar(
                      title: 'average'.tr,
                      colr: const Color(0xFFFFC700),
                      percent: threeStar,
                    ),
                    _progressBar(
                      title: 'below_average'.tr,
                      colr: const Color(0xFFF7A41E),
                      percent: twoStar,
                    ),
                    _progressBar(
                      title: 'poor'.tr,
                      colr: const Color(0xFFFF2828),
                      percent: oneStar,
                    ),
                    const Divider(),
                    Gaps.verticalGapOf(10),

                    //ReviewList
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.reviewList.length,
                        itemBuilder: (context, index){
                          return ServiceReviewItem(reviewData: widget.reviewList.elementAt(index),);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return const EmptyReviewWidget();
  }
  Widget _progressBar(
      {required String title, required double percent, required Color colr}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8C8C8C)),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          SizedBox(
            width: 245,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: LinearProgressIndicator(
                value: percent,
                valueColor: AlwaysStoppedAnimation<Color>(colr),
                backgroundColor: const Color(0xFFEAEAEA),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
