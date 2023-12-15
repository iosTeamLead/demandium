
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? yesText;
  final String? noText;
  final String? description;
  final Color? descriptionTextColor;
  final Function()? onYesPressed;
  final bool? isLogOut;
  final Function? onNoPressed;
  final Widget? widget;

  const ConfirmationDialog({
    super.key,
    required this.icon,
    this.title,
    required this.description,
    required this.onYesPressed,
    this.isLogOut = false,
    this.onNoPressed,
    this.widget,
    this.descriptionTextColor,
    this.yesText= 'yes',
    this.noText ='no'
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: widget ?? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(icon != null)
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Image.asset(icon!, width: 60, height: 60,),),
          title != null ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              title!, textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ):
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Text(
              description!,
              style: ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: descriptionTextColor ?? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          GetBuilder<UserController>(
            builder: (userController){
              return userController.isLoading ?
              const Center(child: CircularProgressIndicator()):
              Row(children: [
                Expanded(
                    child: TextButton(
                      onPressed: () => isLogOut! ? Get.back() : onYesPressed!(),
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3),
                        minimumSize: const Size(Dimensions.webMaxWidth, 45),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),),
                      child: Text(
                        isLogOut! ? noText!.tr : yesText!.tr, textAlign: TextAlign.center,
                        style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),),
              )),
              const SizedBox(width: Dimensions.paddingSizeLarge),
              Expanded(child: CustomButton(
                buttonText: isLogOut! ? yesText!.tr : noText!.tr,
                fontSize: Dimensions.fontSizeDefault,
                onPressed: () => isLogOut! ? onYesPressed!() : onNoPressed != null ? onNoPressed!() : Get.back(),
                radius: Dimensions.radiusSmall, height: 45,
              )),
            ]);
          },),

        ]),
      )),
    );
  }
}
