import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final Function()? onTap;
  const QuantityButton({super.key, required this.isIncrement, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController){
      return InkWell(
        onTap: cartController.isCartLoading ? null : onTap,
        child: Container(
          height: 30, width: 30,
          margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cartController.isCartLoading ? Theme.of(context).disabledColor : Theme.of(context).colorScheme.secondary
          ),
          alignment: Alignment.center,
          child: Icon(
            isIncrement ? Icons.add : Icons.remove,
            size: 15,
            color:Theme.of(context).cardColor ,
          ),
        ),
      );
    });
  }
}