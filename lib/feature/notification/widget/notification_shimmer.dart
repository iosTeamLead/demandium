import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 3),
      interval: const Duration(seconds: 5),
      color: Colors.white,
      colorOpacity: 0,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: SizedBox(
        height: context.height,
        width: context.width,
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Theme.of(context).shadowColor,
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault,),
                      Expanded(
                          child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).shadowColor,
                              )))
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  Container(
                      height: 25,
                      width: context.width*.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Theme.of(context).shadowColor,
                      )
                  )
                ],
              ),
            );
          },
        ),
      ),

    );
  }
}