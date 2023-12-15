import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/loyalty_point/controller/loyalty_point_controller.dart';
import 'package:get/get.dart';

class ConvertLoyaltyPointDialog extends StatelessWidget {

  const ConvertLoyaltyPointDialog({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> noteList =[
      "convert_point_hint_text".tr,
      "${'minimum'.tr} ${Get.find<LoyaltyPointController>().loyaltyPointModel?.content?.minLoyaltyPointToTransfer?? 0}"
          " ${'points_required_to_convert_point'.tr}",
      "once_you_convert_point_to_money".tr,
      "pont_can_use_for_get_money".tr
    ];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      insetPadding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Theme.of(context).cardColor,
      child: SizedBox(width: 500, child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SingleChildScrollView(
          child: GetBuilder<LoyaltyPointController>(builder: (loyaltyPointController){
            return Column(mainAxisSize: MainAxisSize.min, children: [

              Row(mainAxisAlignment: MainAxisAlignment.end,children: [InkWell(
                child: const Icon(Icons.highlight_remove,size: 22,),
                onTap: ()=> Get.back(),
              )]),

              Center(child: Padding(padding: const EdgeInsets.all(8.0),
                child: Text("enter_point_amount".tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
              )),

              Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.12), blurRadius: 1,
                        spreadRadius: 1, offset: const Offset(0,0))]
                ),
                child: Column(
                  children: [
                    Text('convert_point_to_wallet_money'.tr, style: ubuntuMedium.copyWith(color:Get.isDarkMode?Colors.white70 :  Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),),
                    Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: SizedBox(height: 50,child: TextFormField(
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                        controller: loyaltyPointController.loyaltyPointController,
                        decoration: InputDecoration(
                          hintText: 'enter_point'.tr,
                          hintStyle: ubuntuRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(.5)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:  BorderSide(width: 0.5,
                                color: Theme.of(context).hintColor.withOpacity(0.5)),
                          ),
                        ),
                      ),),
                    ),

                    Row(children: [
                      Text('${'available_point'.tr} '
                          ,style: ubuntuRegular.copyWith(color:Get.isDarkMode?Colors.white70 :  Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeDefault),
                        ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(' ${loyaltyPointController.loyaltyPointModel?.content?.loyaltyPoint?.toStringAsFixed(2)??0}'
                          ,style: ubuntuRegular.copyWith(color:Get.isDarkMode?Colors.white70 :  Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeDefault),
                        ),
                      ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: Dimensions.paddingSizeDefault,),

              Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,Dimensions.paddingSizeSmall),
                      child: Text('note'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Get.isDarkMode?Colors.white70 : Theme.of(context).primaryColor),)),

                  Column(
                    children: noteList.map((item) => Column(children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        const Padding(padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall,top: 5),
                          child: Icon(Icons.circle,size: 7,),
                        ),
                        Expanded(child: Text(item,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall!.color),)),
                      ]),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),
                    ],)).toList(),
                  ),
                ],),
              ),

              const SizedBox(height: Dimensions.paddingSizeLarge,),

              loyaltyPointController.isLoading== false?
              CustomButton(
                height: ResponsiveHelper.isDesktop(context)?45 : 40,
                fontSize: Dimensions.fontSizeSmall,
                width: Dimensions.currencyConvertButtonHeight-20,
                buttonText: "convert_to_currency".tr,
                assetIcon: Images.convertPoint,
                radius: Dimensions.radiusExtraMoreLarge,
                onPressed: (){
                  double inputAmount = double.tryParse(loyaltyPointController.loyaltyPointController.text)??0;
                  double availAblePoint = loyaltyPointController.loyaltyPointModel?.content?.loyaltyPoint??0;
                  double minimumConvertAblePoint = double.tryParse(loyaltyPointController.loyaltyPointModel?.content?.minLoyaltyPointToTransfer??"0")??0;

                  if(loyaltyPointController.loyaltyPointController.text.isEmpty){
                    customSnackBar('enter_point_amount'.tr);
                  }else if(inputAmount> availAblePoint){
                    customSnackBar('insufficient_point_amount'.tr);
                  }else if(inputAmount < minimumConvertAblePoint){
                    customSnackBar('${"minimum_convert_able_point".tr} $minimumConvertAblePoint'.tr);
                  } else{
                    loyaltyPointController.convertLoyaltyPoint();
                  }
                },
              ):const CircularProgressIndicator(),
              const SizedBox(height: Dimensions.paddingSizeLarge,),
            ]);
          })
        ),
      )),
    );
  }
}
