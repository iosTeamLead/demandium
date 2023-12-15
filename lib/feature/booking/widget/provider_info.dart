import 'package:get/get.dart';
import 'package:demandium/core/common_model/provider_model.dart';
import 'package:demandium/components/core_export.dart';

class ProviderInfo extends StatelessWidget {
  final ProviderModel provider;
  const ProviderInfo({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Text("provider_info".tr, style: ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color:Get.isDarkMode? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6): Theme.of(context).primaryColor))),
        Gaps.verticalGapOf(Dimensions.paddingSizeDefault),


        Padding(
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
                    child:  CustomImage(image:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${provider.logo}"),

                  ),
                ),
                Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
                Text("${provider.companyName}",style:ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
                Text("${provider.companyPhone}",style:ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,)),
                Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
              ],
            ),
          ),
        )

      ],
    );
  }
}
