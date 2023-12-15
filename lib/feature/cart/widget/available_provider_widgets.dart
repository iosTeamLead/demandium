import 'package:demandium/feature/cart/widget/provider_item_view.dart';
import 'package:demandium/feature/provider/model/provider_model.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class AvailableProviderWidget extends StatefulWidget {
  const AvailableProviderWidget({super.key});
  @override
  State<AvailableProviderWidget> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<AvailableProviderWidget> {
  @override
  void initState() {
    super.initState();
    if(Get.find<CartController>().subcategoryId!=""){
      Get.find<CartController>().getProviderBasedOnSubcategory(Get.find<CartController>().subcategoryId, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(ResponsiveHelper.isDesktop(context)) {
      return  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: pointerInterceptor(),
      );
    }
    return pointerInterceptor();
  }

  pointerInterceptor(){
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveHelper.isWeb()? 0 :Dimensions.cartDialogPadding),
      child: PointerInterceptor(
        child: Container(
          width:ResponsiveHelper.isDesktop(context)? Dimensions.webMaxWidth/2:Dimensions.webMaxWidth,
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
          ),
          child:  GetBuilder<CartController>(builder: (cartControllerInit) {
            List<ProviderData> providerList = cartControllerInit.providerList??[];
            return GetBuilder<ServiceController>(builder: (serviceController) {
              if(1==1) {
                return Stack(children: [
                Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault, left:  Dimensions.paddingSizeDefault, top:  80,),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(padding: EdgeInsets.only(top: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.paddingSizeDefault,
                            bottom:  Dimensions.paddingSizeExtraMoreLarge,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: Dimensions.paddingSizeLarge),
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        cartControllerInit.updateProviderSelectedIndex(-1);
                                        cartControllerInit.resetPreselectedProviderInfo();
                                        },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.5),width: 0.5),
                                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                                        ),
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                                        margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                        child: Row(children: [
                                          ClipRRect( borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                            child: Image.asset(Images.providerImage,height: 50,width: 50,),
                                          ),
                                          const SizedBox(width: Dimensions.paddingSizeDefault,),
                                          Text('${'let'.tr} ${AppConstants.appName} ${'choose_for_you'.tr}'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                                        ]),
                                      ),
                                    ),
                                    if(cartControllerInit.selectedProviderIndex==-1)
                                    Positioned(
                                        top: 7,
                                        right: Get.find<LocalizationController>().isLtr?10:null,
                                        left: Get.find<LocalizationController>().isLtr? null :10,
                                        child: Icon(Icons.check_circle_rounded,color:Get.isDarkMode?Colors.white60: Theme.of(context).primaryColor,)
                                    ),
                                  ],
                                ),

                                const SizedBox(height: Dimensions.paddingSizeSmall,),
                                ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge,),
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: providerList.length,
                                    itemBuilder: (context, index) {
                                      return ProviderCartItemView(providerData: providerList[index],index: index,);
                                 }),
                                const SizedBox(height: Dimensions.paddingSizeLarge),
                           ]),
                        ),
                      ]
                    ),
                  ),
                ),
                Positioned(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const SizedBox(width: Dimensions.paddingSizeLarge,),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                          child: Hero(tag: "provider_image",
                            child: Image.asset(Images.providerImage,width: 50,height: 50,),
                          ),
                        ),
                        Container(
                          height: 40, width: 40, alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70.withOpacity(0.6),
                              boxShadow:Get.isDarkMode?null:[BoxShadow(
                                color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1,
                              )]
                          ),
                          child: InkWell(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.close,
                                color: Colors.black54,

                              )
                          ),
                        )]
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeEight,),
                            Text(
                              "available_providers".tr,
                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            const SizedBox(height: Dimensions.paddingSizeMini,),
                            Text(
                              "${providerList.length} ${'options_available'.tr}",
                              style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
                            ),
                          ]),
                    ],
                  ),
                ),),
                Positioned(left:0, right: 0, bottom:  0,
                  child:  Container(height: 70, color: Theme.of(context).cardColor,),),
                Positioned(
                    left: Dimensions.paddingSizeDefault,
                    right: Dimensions.paddingSizeDefault,
                    bottom:  Dimensions.paddingSizeDefault,
                    child:  GetBuilder<CartController>(builder: (cartController) {
                      return cartController.isLoading ? const Center(child: CircularProgressIndicator()) :
                      CustomButton(
                        height: ResponsiveHelper.isDesktop(context)? 50 : 45,
                        onPressed: () {
                          cartController.updateProvider();
                           Get.back();
                          },
                        buttonText: 'confirm'.tr
                      );
                    }))
              ]);
              }
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 20,
                    child: Container(
                      height: 40, width: 40, alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white70.withOpacity(0.6),
                          boxShadow:[BoxShadow(
                            color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!, blurRadius: 2, spreadRadius: 1,
                          )]
                      ),
                      child: InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.close)),
                    ),
                  ),
                  SizedBox(
                      height: Get.height / 7,
                      child: Center(child: Text('no_variation_is_available'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)))
                ],
              );
            });
          }
          ),
        ),
      ),
    );
  }
}
