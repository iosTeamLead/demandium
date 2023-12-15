import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool? value;
  const CustomCheckBox({Key? key, required this.title, this.onTap, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Text(title.tr,
          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
        ),
        SizedBox(width: 20.0,
          child: Checkbox(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            activeColor: Theme.of(context).colorScheme.primary,
            value: value,
            onChanged: (bool? isActive) => onTap!()
          ),
        ),
      ]),
    );
  }
}
