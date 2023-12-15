import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class CustomPostServiceInfo extends StatelessWidget {
  final PostDetailsContent? postDetails;
  const CustomPostServiceInfo({Key? key, required this.postDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SizedBox(height: Dimensions.paddingSizeDefault,),
        Text("service_details".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Container(
          padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
          width: Get.width,
          color: Theme.of(context).hoverColor,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: CustomImage(height: 65, width: 65, fit: BoxFit.cover,
                    image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}"
                        "/service/${postDetails?.service?.thumbnail??""}")),

            const SizedBox(width: Dimensions.paddingSizeDefault,),
            Expanded( child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,children: [
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
              Text(postDetails?.service?.name??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Text(postDetails?.subCategory?.name??"",style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5)),),
            ],),
            ),
          ],),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
      ],
    );
  }
}
