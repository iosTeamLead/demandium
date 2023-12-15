import 'package:demandium/components/custom_text_form_field.dart';
import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class AdditionalInstructionDialog extends StatelessWidget {
  const AdditionalInstructionDialog({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController additionalInstructionController = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GetBuilder<CreatePostController>(builder: (createPostController){
        return SizedBox(
          width: Dimensions.webMaxWidth/1.5,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [

                const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

                Padding(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('add_additional_instruction'.tr,style:  ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.primary
                    ),),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge,)
                  ]),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
                  child: CustomTextFormField(
                    hintText: "write_something".tr,
                    inputType: TextInputType.text,
                    controller: additionalInstructionController,
                    maxLines: 3,
                    isShowBorder: true,
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(
                    buttonText: "add".tr, height: ResponsiveHelper.isDesktop(context)? 40 : 35, width: ResponsiveHelper.isDesktop(context)? 100 :  80,
                    radius: Dimensions.radiusExtraMoreLarge,
                    fontSize: Dimensions.fontSizeDefault,
                    onPressed: (){
                      String value = additionalInstructionController.text;
                      if(value.isNotEmpty){
                        createPostController.addAdditionalInstruction(value);
                      }else{
                        customSnackBar('enter_additional_instruction'.tr);
                      }
                      Get.back();
                    },
                  ),
                ),
              ]),

              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: GestureDetector(
                  onTap: ()=> Get.back(),

                  child: Icon(Icons.close,size: 25,color: Theme.of(context).primaryColor,),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
