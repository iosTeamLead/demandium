import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/cart/widget/available_provider_widgets.dart';
import 'package:get/get.dart';

class ProviderDetailsCard extends StatelessWidget {
  const ProviderDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController){
      return Column(children: [
        Text('provider_information'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3), width: 0.5),
            color: Theme.of(context).hoverColor.withOpacity(0.5),
          ),
          child:  Row(children: [
            ClipRRect( borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              child: CustomImage(
                image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${cartController.selectedProviderProfileImages}",
                height: 60,width: 60,),
            ),
            const SizedBox(width: Dimensions.paddingSizeDefault,),

            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Text(cartController.selectedProviderName, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  InkWell(
                    onTap: (){
                       showModalBottomSheet(
                         useRootNavigator: true,
                         isScrollControlled: true,
                         backgroundColor: Colors.transparent,
                         context: context, builder: (context) => const AvailableProviderWidget(),
                       );
                     },
                    child: Image.asset(Images.editButton,width: 20.0,height: 20.0,),),
                  ],
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                  child: Text('Computer repair,Laptop Repair',
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor),),
                ),
                Text.rich(TextSpan(
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),
                    children:  [
                      WidgetSpan(child: Icon(Icons.star,color: Theme.of(context).colorScheme.primaryContainer,size: 15,), alignment: PlaceholderAlignment.middle),
                      const TextSpan(text: " "),
                      TextSpan(text: cartController.selectedProviderRating.toString(),style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault))
                    ],
                )),
              ],),
            )
          ]),
        ),
      ]);
    });
  }
}
