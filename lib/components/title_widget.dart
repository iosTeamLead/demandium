import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class TitleWidget extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const TitleWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title!.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: title=='recently_view_services'
          ? Colors.white:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8))),
      (onTap != null && !ResponsiveHelper.isDesktop(context)) ? InkWell(
        onTap: onTap,
        child: Text(
          'see_all'.tr,
          style: ubuntuMedium.copyWith(
              decoration: TextDecoration.underline,
              color:Get.isDarkMode ?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8):
                  title=='recently_view_services'? Colors.white
                  : Theme.of(context).colorScheme.primary,
              fontSize: Dimensions.fontSizeDefault, ),
        ),
      ) : const SizedBox(),
    ]);
  }
}
