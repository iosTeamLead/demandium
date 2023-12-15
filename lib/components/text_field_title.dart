import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class TextFieldTitle extends StatelessWidget {
  final String title;
  final bool requiredMark;
  const TextFieldTitle({Key? key, required this.title, this.requiredMark = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeDefault),
      child: RichText(
          text:
          TextSpan(children: <TextSpan>[
            TextSpan(text: title, style: ubuntuRegular.copyWith(color: Theme.of(Get.context!).textTheme.bodyLarge!.color!.withOpacity(0.9))),
            TextSpan(text: requiredMark?' *':"", style: ubuntuRegular.copyWith(color: Colors.red)),
          ])),
    );
  }
}
