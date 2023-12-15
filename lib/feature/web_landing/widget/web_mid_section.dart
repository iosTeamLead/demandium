import 'package:demandium/components/custom_image.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'web_mid_section_content_item.dart';

class WebMidSection extends StatelessWidget {
  final Map<String?,String?>? textContent;
  final Map<String?,String?>? imageContent;
  final String baseUrl;
  const WebMidSection({Key? key, required this.textContent,required this.imageContent, required this.baseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.webMaxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(textContent?['web_mid_title'] != null && textContent?['web_mid_title'] != '')
          Text(
            textContent?['web_mid_title']??"",
            style: ubuntuBold.copyWith(fontSize: 26,),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(imageContent!["feature_section_image"] != null)
                CustomImage(
                  height: Dimensions.featureSectionImageSize,
                  width: Dimensions.featureSectionImageSize,
                  image:"$baseUrl/landing-page/web/${imageContent?['feature_section_image']}",
                  fit: BoxFit.fitHeight,
                ),
              const SizedBox(width: Dimensions.paddingSizeDefault,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(textContent!['mid_sub_title_1'] != null && textContent!['mid_sub_description_1'] != null)
                    WebMidSectionContentItem(title:textContent?['mid_sub_title_1']??"",subTitle:textContent?['mid_sub_description_1']??""),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                    if(textContent!['mid_sub_title_2'] != null && textContent!['mid_sub_description_2'] != null)
                      WebMidSectionContentItem(title:textContent?['mid_sub_title_2']??"",subTitle:textContent?['mid_sub_description_2']??""),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                    if(textContent!['mid_sub_title_3'] != null && textContent!['mid_sub_description_3'] != null)
                      WebMidSectionContentItem(title:textContent?['mid_sub_title_3']??"",subTitle:textContent?['mid_sub_description_3']??""),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
