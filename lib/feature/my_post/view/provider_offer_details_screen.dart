import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/create_post/model/provider_offer_model.dart';
import 'package:get/get.dart';

class ProviderOfferDetailsScreen extends StatelessWidget {
  final ProviderOfferData? providerOfferData;
  final String? postId;
  const ProviderOfferDetailsScreen({Key? key, required this.providerOfferData, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "provider_offers".tr),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: FooterBaseView(
        child: WebShadowWrap(
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                Container(decoration: BoxDecoration(color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
                ),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            child: CustomImage(height: 65, width: 65, fit: BoxFit.cover,
                              image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}"
                                  "/provider/logo/${providerOfferData?.provider?.logo??""}",
                            ),
                        ),

                        const SizedBox(width: Dimensions.paddingSizeSmall,),
                        Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Text(providerOfferData?.provider?.companyName??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                          Row(
                            children: [
                              Icon(Icons.star,color: Theme.of(context).colorScheme.primary,size: 10,),
                              Directionality(textDirection: TextDirection.ltr,
                                child: Text(" ${providerOfferData?.provider?.avgRating??""}",style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5)),),
                              ),
                              const SizedBox(width: Dimensions.paddingSizeSmall,),
                              InkWell(
                                child: Text('${providerOfferData?.provider?.ratingCount??""} ${'reviews'.tr}', style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5))),
                              ),

                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("price_offered".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).colorScheme.error),),
                              const SizedBox(width: Dimensions.paddingSizeSmall,),
                              Text(PriceConverter.convertPrice(double.tryParse(providerOfferData?.offeredPrice??"0")),
                                style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context).colorScheme.primary),
                              ),

                            ],
                          ),

                        ],)
                      ],),
                      const SizedBox(height: Dimensions.paddingSizeDefault,),

                      Text("description".tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).secondaryHeaderColor),),

                      const SizedBox(height: Dimensions.paddingSizeSmall,),

                      Text(providerOfferData?.providerNote??"",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),),
                      const SizedBox(height: Dimensions.paddingSizeLarge),


                      Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                        Expanded(
                          child: GestureDetector(
                            onTap:() async {

                              Get.dialog( ConfirmationDialog(
                                icon: Images.ignore,
                                title: 'decline'.tr,
                                description: 'do_you_want_to_decline_this_request'.tr,
                                yesText: 'decline',
                                descriptionTextColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                                onYesPressed: () async {
                                  Get.back();
                                  Get.dialog(const CustomLoader(), barrierDismissible: false,);
                                  await Get.find<CreatePostController>().updatePostStatus(postId??"", providerOfferData?.provider?.id??"", 'deny');
                                  Get.back();
                                  Get.offAllNamed(RouteHelper.getMyPostScreen());
                                },
                              ),useSafeArea: true);
                            },
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
                              child: Center(child: Text('decline'.tr,style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.error),)),
                            ),
                          ),
                        ),

                        const SizedBox(width: Dimensions.paddingSizeSmall,),

                        Expanded(
                          child: GestureDetector(
                            onTap:() async {
                              Get.toNamed(RouteHelper.getCustomPostCheckoutRoute(
                                  postId??"",providerOfferData?.provider?.id??"",providerOfferData?.offeredPrice??""
                              ));
                            },
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
                              child: Center(child: Text('accept'.tr,style: ubuntuRegular.copyWith(color: Colors.white),)),
                            ),
                          ),
                        ),
                      ],),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
