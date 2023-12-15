import 'package:demandium/components/custom_image.dart';
import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/feature/web_landing/controller/web_landing_controller.dart';
import 'package:demandium/feature/web_landing/model/web_landing_model.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestimonialWidget extends StatelessWidget {
  final WebLandingController webLandingController;
  final Map<String?,String?>? textContent;
  final String baseUrl;
  final PageController _pageController = PageController();

   TestimonialWidget({
    Key? key,
    required this.webLandingController,
    required this.textContent,
    required this.baseUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;

    return Container(
      color: Theme.of(context).hoverColor,
      height: Dimensions.webLandingTestimonialHeight, width: Get.width,
      child: Align( alignment: Alignment.center, child: SizedBox(width: Dimensions.webMaxWidth, child: Row( mainAxisAlignment: MainAxisAlignment.center, children: [

        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
          child: InkWell( onTap: () => _pageController.previousPage( duration: const Duration(seconds: 1), curve: Curves.easeInOut),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: Dimensions.webLandingIconContainerHeight, width: Dimensions.webLandingIconContainerHeight, alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.15)),
              child: Padding(padding:  EdgeInsets.only(
                  left: isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                  right: !isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                ),
                child: Icon(Icons.arrow_back_ios, size: Dimensions.webArrowSize,
                    color:webLandingController.currentPage! > 0? Theme.of(context).colorScheme.primary :Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
                ),
              ),
            ),
          ),
        ),

        Expanded( child: PageView.builder(
          controller: _pageController,
          itemCount: webLandingController.webLandingContent!.testimonial!.length,
          itemBuilder: (context, index) {
            Testimonial testimonial =  webLandingController.webLandingContent!.testimonial!.elementAt(index);
            return Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Column( mainAxisAlignment: MainAxisAlignment.spaceAround, children: [

                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                    Column( mainAxisSize: MainAxisSize.min,  crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Text(textContent?['testimonial_title']??"",
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeOverLarge), textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 70,),

                      SizedBox( width: Get.width / 4,
                        child: Text(testimonial.review!, style: ubuntuMedium.copyWith(fontStyle: FontStyle.italic, fontSize: Dimensions.fontSizeDefault,),),
                      ),
                      const SizedBox(height: 24,),

                      Text("- ${testimonial.name!}",
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault), textAlign: TextAlign.center,
                      ),
                    ]),
                    CustomImage(image: "$baseUrl/landing-page/${testimonial.image}", height: 214, width:214),
                ]),

                Text("${index+1}/${webLandingController.webLandingContent!.testimonial!.length}")
              ]),
            );
          },
          onPageChanged: (int index){
            webLandingController.setPageIndex(index);
          },
        )),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
          child: InkWell(
            onTap: () => _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
            child: Container(
              height: Dimensions.webLandingIconContainerHeight, width: Dimensions.webLandingIconContainerHeight, alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.15),
              ),
              child: Icon(
                  Icons.arrow_forward_ios,
                  size: Dimensions.webArrowSize,
                  color:webLandingController.currentPage!+1 < webLandingController.webLandingContent!.testimonial!.length
                      ? Theme.of(context).colorScheme.primary :Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
              ),
            ),
          ),
        )

      ]))),
    );
  }
}
