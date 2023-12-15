import 'package:demandium/core/helper/price_converter.dart';
import 'package:flutter/material.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';

class DiscountTag extends StatelessWidget {
  final num? discount;
  final String? discountType;
  final double? fromTop;
  final double? fontSize;
  final bool? freeDelivery;
  final Color? color;
  const DiscountTag({super.key, required this.discount, required this.discountType, this.fromTop = 5, this.fontSize, this.freeDelivery = false, this.color});

  @override
  Widget build(BuildContext context) {
    return (discount! > 0 || freeDelivery!) ? Positioned(
      top: fromTop, right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: color?? Theme.of(context).colorScheme.error.withOpacity(0.9),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(Dimensions.radiusSmall),
              bottomLeft: Radius.circular(Dimensions.radiusSmall),
          ),
        ),
        child: Text(
          PriceConverter.percentageOrAmount('$discount','$discountType'),
          style: ubuntuRegular.copyWith(color: Colors.white),
        ),
      ),
    ) : const SizedBox();
  }
}
