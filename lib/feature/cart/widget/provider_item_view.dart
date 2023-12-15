import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/provider/model/provider_model.dart';
import 'package:get/get.dart';

class ProviderCartItemView extends StatelessWidget {
  final ProviderData providerData;
  final int index;
  const ProviderCartItemView({Key? key, required this.providerData, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController){
      return GestureDetector(
        onTap: (){
          cartController.updateProviderSelectedIndex(index);
          cartController.updatePreselectedProvider(
            providerData.avgRating.toString(),
            providerData.id.toString(),
            providerData.logo.toString(),
            providerData.companyName.toString()
          );},
        child: Stack(
          children: [

            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),

              child:  Row(children: [
                ClipRRect( borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  child: CustomImage(
                    image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providerData.logo}",
                    height: 60,width: 60,),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault,),

                Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
                  Text(providerData.companyName??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                      maxLines: 1, overflow: TextOverflow.ellipsis),

                  Text.rich(TextSpan(
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),
                      children:  [


                        WidgetSpan(child: Icon(Icons.star,color: Theme.of(context).colorScheme.primaryContainer,size: 15,), alignment: PlaceholderAlignment.middle),
                        const TextSpan(text: " "),
                        TextSpan(text: providerData.avgRating.toString(),style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault))

                      ])),
                ],)
              ]),
            ),

            if(cartController.selectedProviderIndex==index)
              Positioned(
                  top: 15,
                  right: Get.find<LocalizationController>().isLtr?10:null,
                  left: Get.find<LocalizationController>().isLtr? null :10,
                  child: Icon(Icons.check_circle_rounded,color: Get.isDarkMode?Colors.white60: Theme.of(context).primaryColor,)),
          ],
        ),
      );
    });
  }
}
