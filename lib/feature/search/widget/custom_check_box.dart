import 'package:demandium/components/core_export.dart';

class CustomCheckBox extends StatelessWidget {
  final String? title;
  final bool? value;
  final Function()? onClick;
  const CustomCheckBox({super.key, @required this.title, @required this.value, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(children: [
        Checkbox(
          value: value,
          onChanged: (bool? isActive) => onClick!(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), side: BorderSide.none),
        ),
        Text(title!, style: ubuntuRegular),
      ]),
    );
  }
}
