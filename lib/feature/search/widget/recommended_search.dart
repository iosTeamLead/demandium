import 'dart:math';
import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class RecommendedSearch extends StatefulWidget {
  const RecommendedSearch({Key? key}) : super(key: key);

  @override
  State<RecommendedSearch> createState() => _RecommendedSearchState();
}

class _RecommendedSearchState extends State<RecommendedSearch> {
  @override
  void initState() {
    super.initState();
    Get.find<ServiceController>().getRecommendedSearchList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
      builder: (serviceController){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('recommended_for_you'.tr,style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).colorScheme.primary),),
                InkWell(
                  onTap: (){
                    serviceController.getRecommendedSearchList(reload: true);
                  },
                  child: Row(
                    children: [
                      Text('change'.tr,style: ubuntuMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5),
                      ),),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                      const Icon(Icons.cached,size: 16,)
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault,),

           (serviceController.recommendedSearchList!=null)?
            ListView.builder(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             itemBuilder: (context,index){
               return Padding(
                 padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                 child: SizedBox(
                   child: InkWell(
                     hoverColor: Colors.transparent,
                     onTap: (){
                       Get.find<AllSearchController>().searchData(
                           serviceController.recommendedSearchList?[index].name??''
                       );

                       Get.find<AllSearchController>().populatedSearchController(
                           serviceController.recommendedSearchList?[index].name??''
                       );
                     },
                     child: Text(
                       serviceController.recommendedSearchList?[index].name??"",
                       style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8)),
                     ),
                   ),
                 ),
               );
             },itemCount: serviceController.recommendedSearchList!.length
           ):const RecommendedSearchShimmer(),
          ],
        );
    });
  }
}

class RecommendedSearchShimmer extends StatelessWidget {
  const RecommendedSearchShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer(
          duration: const Duration(seconds: 3),
          interval: const Duration(seconds: 5),
          color: Theme.of(context).colorScheme.background,
          colorOpacity: 0,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
            child: Padding(
              padding:  EdgeInsets.only(right: Random().nextDouble() * Get.width*0.4),
              child: Container(
                height: 20,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  color: Theme.of(context).shadowColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


