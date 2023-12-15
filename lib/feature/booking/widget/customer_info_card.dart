import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class CustomerInfoCard extends GetView<UserController> {
  final String name;
  final String phone;
  final String image;

  const CustomerInfoCard( {Key? key, required this.name, required this.phone, required this.image}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
      child: Container(
        width:double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),
          color: Theme.of(context).hoverColor,
        ),
        child: Column(
          children: [
            Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraLarge)),
              child: SizedBox(
                width: Dimensions.imageSize,
                height: Dimensions.imageSize,
                child: CustomImage(image:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/serviceman/profile/$image"),
              ),
            ),
            Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
            Text(name,style:ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,)),
            Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
            Text(phone,style:ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,)),
            Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
          ],
        ),
      ),
    );
  }
}