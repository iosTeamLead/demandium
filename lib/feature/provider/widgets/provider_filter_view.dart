import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/provider/widgets/custom_checkbox.dart';
import 'package:demandium/feature/provider/widgets/filter_rating_widgets.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ProviderFilterView extends StatefulWidget {

  const ProviderFilterView({super.key});
  @override
  State<ProviderFilterView> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProviderFilterView> {

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
      child: GetBuilder<ProviderBookingController>(builder: (providerBookingController){
        return PointerInterceptor(
          child: Container(
            width:ResponsiveHelper.isDesktop(context)? Dimensions.webMaxWidth/2:Dimensions.webMaxWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
            ),
            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                          const SizedBox(),
                          Text('filter_data'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
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
                          ),
                        ],
                      ),

                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: Text('sort_by'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
                      ),

                      SizedBox(height: 38, child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: providerBookingController.sortBy.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                        return InkWell(
                          onTap: ()=>providerBookingController.updateSortByIndex(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              color: index == providerBookingController.selectedSortByIndex?
                              Theme.of(context).colorScheme.primary.withOpacity(0.2): null,
                              border: Border.all( color: index == providerBookingController.selectedSortByIndex?
                              Theme.of(context).colorScheme.primary.withOpacity(0.6): Theme.of(context).hintColor.withOpacity(0.4)),
                            ),
                            child: Center(child: Text(providerBookingController.sortBy[index].tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                          ),
                        );},
                      )),
                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      if(providerBookingController.categoryList.isNotEmpty)
                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: Text('categories'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
                      ),


                      SizedBox(height: Get.height*0.35,
                        child: ListView.builder(itemBuilder: (context,index){
                          return CustomCheckBox(title:  providerBookingController.categoryList[index].name??"",
                            value: providerBookingController.categoryCheckList[index],
                            onTap: ()=>providerBookingController.toggleFromCampaignChecked(index),
                          );
                        },itemCount: providerBookingController.categoryList.length,
                        ),
                      ),

                      Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: Text('ratings'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                      )),

                      const Center(child: FilterRatingWidgets()),
                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      CustomButton(buttonText: 'search'.tr,onPressed: () async{
                        Get.back();
                        Get.dialog(const CustomLoader(), barrierDismissible: false,);
                        await providerBookingController.getProviderList(1, true);
                        Get.back();
                      },),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
