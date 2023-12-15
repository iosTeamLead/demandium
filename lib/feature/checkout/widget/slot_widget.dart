import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class SlotWidget extends StatelessWidget {
  final String? title;
  final bool? isSelected;
  final Function()? onTap;
  const SlotWidget({super.key, required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
      child: InkWell(
        onTap: onTap!,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected! ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: [ BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, spreadRadius: 0.5, blurRadius: 0.5)],),
          child: Text(
            title!,
            style: ubuntuRegular.copyWith(color: isSelected! ? Theme.of(context).cardColor : Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
      ),
    );
  }
}
