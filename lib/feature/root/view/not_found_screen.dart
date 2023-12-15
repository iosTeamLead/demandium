import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TweenAnimationBuilder(
        curve: Curves.bounceOut,
        duration: const Duration(seconds: 2),
        tween: Tween<double>(begin: 12.0,end: 30.0),
        builder: (BuildContext context, dynamic value, Widget? child){
              return Text('page_not_found'.tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: value));
        }),
      ),
    );
  }
}
