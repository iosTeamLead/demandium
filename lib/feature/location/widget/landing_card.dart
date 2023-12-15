import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';

class LandingCard extends StatelessWidget {
  final String? icon;
  final String? title;
  const LandingCard({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, alignment: Alignment.center,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: Theme.of(context).primaryColor.withOpacity(0.05),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        Image.asset(icon!, width: 45, height: 45),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        Text(title!, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center),

      ]),
    );
  }
}