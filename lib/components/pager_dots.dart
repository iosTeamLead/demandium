import 'package:demandium/utils/dimensions.dart';
import 'package:flutter/material.dart';

class PagerDot extends StatelessWidget {
  const PagerDot({Key? key, required this.index, required this.currentIndex}) : super(key: key);
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: Dimensions.paddingSizeDefault,
      width: Dimensions.paddingSizeDefault,
      decoration: BoxDecoration(
        color: currentIndex == index ? Theme.of(context).colorScheme.primary : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}