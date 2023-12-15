import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class PagerContent extends StatelessWidget {
  const PagerContent({Key? key, required this.image, required this.text, required this.subText}) : super(key: key);

  final String image;
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        SizedBox( child: Image.asset(image)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(text,
                textAlign: TextAlign.center,
                style: ubuntuBold.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: Dimensions.fontSizeLarge),),
              const SizedBox(height: Dimensions.paddingSizeDefault,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                child: Text(subText,
                  textAlign: TextAlign.center,
                  style: ubuntuRegular.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Dimensions.fontSizeDefault),),
              ),
            ],
          )
        ),
        SizedBox(height: context.height*0.15),
      ],
    );
  }
}