import 'package:demandium/core/helper/route_helper.dart';
import 'package:demandium/feature/auth/controller/auth_controller.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveChatButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isBorderActive;
  const LiveChatButton({Key? key, required this.title, required this.iconData, required this.isBorderActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri launchUri =  Uri(
      scheme: 'tel',
      path: Get.find<SplashController>().configModel.content!.businessPhone.toString(),
    );
    return ElevatedButton(
      onPressed: () async {
        if(!isBorderActive) {

          if(Get.find<AuthController>().isLoggedIn()){
            Get.toNamed(RouteHelper.getInboxScreenRoute());
          }else{
            Get.toNamed(RouteHelper.getNotLoggedScreen(RouteHelper.chatInbox, 'inbox'));
          }

        } else{
          await launchUrl(launchUri,mode: LaunchMode.externalApplication);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:isBorderActive ? Colors.transparent : Theme.of(context).colorScheme.primary,
        side: BorderSide(color:Theme.of(context).colorScheme.primary), elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius:BorderRadius.all(Radius.circular(Dimensions.radiusDefault)
          ),
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(8.0), child: Row(children: [

        Icon(iconData,color: isBorderActive ? Theme.of(context).colorScheme.primary : Theme.of(context).primaryColorLight),
        const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

        Text(title,style: ubuntuRegular.copyWith(color:isBorderActive ? Theme.of(context).colorScheme.primary : Theme.of(context).primaryColorLight ))
      ])),
    );
  }
}
