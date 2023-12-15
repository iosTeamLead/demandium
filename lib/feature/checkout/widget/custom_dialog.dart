import 'package:flutter/material.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';

class CustomDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  final Function()? onYesPressed;
  final Function()? onNoPressed;
  const CustomDialog({super.key, required this.icon,this.title,required this.description,this.onYesPressed, this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding:  const  EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding:  const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Image.asset(icon, width: 50, height: 50),
          ),

          title != null ? Padding(
            padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              title!, textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ) : const SizedBox(),

          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Text(description, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
            TextButton(
              onPressed:onNoPressed,
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize:  const Size(Dimensions.paddingSizeLarge, 40),
                padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeLarge ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
              ),
              child: Text(
                "No", textAlign: TextAlign.center,
                style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
            ),

            const SizedBox(width: Dimensions.paddingSizeLarge),

            TextButton(
              onPressed: onYesPressed,
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor, minimumSize:  const Size(Dimensions.paddingSizeLarge, 40),
                padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeLarge ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
              ),
              child: Text(
                "Yes", textAlign: TextAlign.center,
                style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
            ),
          ]),
        ]),
      )),
    );
  }
}