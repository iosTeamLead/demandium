import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';

class WebMidSectionContentItem extends StatelessWidget {
  final String title;
  final String subTitle;
  const WebMidSectionContentItem({Key? key, required this.title,required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, textAlign: TextAlign.center,
          style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
        Text(
          subTitle, textAlign: TextAlign.start,
          style: ubuntuRegular.copyWith(
              color: Theme.of(context).disabledColor,
              fontSize: Dimensions.fontSizeSmall
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeLarge),
      ],
    );
  }
}

