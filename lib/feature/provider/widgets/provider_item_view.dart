import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/provider/model/provider_model.dart';
import 'package:get/get.dart';

class ProviderItemView extends StatelessWidget {
  final  bool fromHomePage;
  final ProviderData providerData;
  const ProviderItemView({Key? key, this.fromHomePage = true, required this.providerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> subcategory=[];
    providerData.subscribedServices?.forEach((element) {
      if(element.subCategory!=null){
        subcategory.add(element.subCategory?.name??"");
      }
    });

    String subcategories = subcategory.toString().replaceAll('[', '');
    subcategories = subcategories.replaceAll(']', '');
    subcategories = subcategories.replaceAll('&', ' and ');

    return GestureDetector(
      onTap: ()=>Get.toNamed(RouteHelper.getProviderDetails(providerData.id!,subcategories)),
      child: Padding(padding:EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.isDesktop(context) && fromHomePage?5:Dimensions.paddingSizeSmall,
          vertical: fromHomePage?0:Dimensions.paddingSizeEight),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Row(children: [

              ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusExtraMoreLarge),
                child: CustomImage(height: 40, width: 40, fit: BoxFit.cover,
                    image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/provider/logo/${providerData.logo}"),
              ),

              const SizedBox(width: Dimensions.paddingSizeSmall,),

              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
                  Text(providerData.companyName??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                  if(subcategories.isNotEmpty)
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                    child: Text(subcategories,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).secondaryHeaderColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(children: [
                      RatingBar(rating: providerData.avgRating),
                      Gaps.horizontalGapOf(5),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          providerData.avgRating!.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: Dimensions.fontSizeSmall,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],),
              )
            ],),

            Row(children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                child: Image.asset(Images.iconLocation, height:12,),),

              Flexible(
                child: Text(providerData.companyAddress??"",
                    style: ubuntuMedium.copyWith(color:Get.isDarkMode? Theme.of(context).secondaryHeaderColor:Theme.of(context).primaryColorDark,fontSize: Dimensions.fontSizeSmall,
                    ),overflow: TextOverflow.ellipsis,),
              ),

            ],)
          ]),
        ),
      ),
    );
  }
}

