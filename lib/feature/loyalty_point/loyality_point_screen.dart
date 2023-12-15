import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/loyalty_point/controller/loyalty_point_controller.dart';
import 'package:demandium/feature/loyalty_point/widgets/convert_point_dialog.dart';
import 'package:demandium/feature/loyalty_point/widgets/loyalty_point_listview.dart';
import 'package:demandium/feature/loyalty_point/widgets/loyalty_point_topcard.dart';
import 'package:demandium/feature/loyalty_point/widgets/loyalty_uses_manual_dialog.dart';
import 'package:get/get.dart';

class LoyaltyPointScreen extends StatelessWidget {
  const LoyaltyPointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: 'loyalty_point'.tr,actionWidget: InkWell(
        onTap: (){
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            transitionDuration: const Duration(milliseconds: 500),
            barrierLabel: MaterialLocalizations.of(context).dialogLabel,
            barrierColor: Colors.black.withOpacity(0.5),
            pageBuilder: (context, _, __) {
              return const LoyaltyPointUsesManualDialog();
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ).drive(Tween<Offset>(
                  begin: const Offset(0, -1.0),
                  end: Offset.zero,
                )),
                child: child,
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,0, 15, 0),
          child: Image.asset(Images.info,width: 20,height: 20,color: Colors.white,),
        ),
      ),bgColor: Theme.of(context).cardColor,),
      body: GetBuilder<LoyaltyPointController>(
        initState: (_){
          Get.find<LoyaltyPointController>().getLoyaltyPointData(1);
        },
        builder: (loyaltyPointController){

          return FooterBaseView(
            isScrollView: true,
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child:loyaltyPointController.loyaltyPointModel!=null? Column(children: [
                const Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                  LoyaltyPointTopCard(),

                  LoyaltyPointListView(),
                ]),
                if(ResponsiveHelper.isDesktop(context))
                Padding(
                  padding: const EdgeInsets.only(bottom:Dimensions.paddingSizeSmall),
                  child: CustomButton(
                    width: Dimensions.currencyConvertButtonHeight,
                    buttonText: "convert_to_currency".tr,
                    assetIcon: Images.convertPoint,
                    height: 45,
                    radius: Dimensions.radiusExtraMoreLarge,
                    onPressed: (){
                      showDialog(context: context, builder: (_){
                        return const ConvertLoyaltyPointDialog();
                      });
                    },
                  ),
                )
              ]):Center(
                child: SizedBox(
                  height: ResponsiveHelper.isDesktop(context)?100: Get.height*0.85,
                    child: const Center(child: CircularProgressIndicator(),)),
              ),
            ),
          );
      }),
      bottomSheet: GetBuilder<LoyaltyPointController>(builder: (loyaltyPointController){
        if(!ResponsiveHelper.isDesktop(context) && Get.find<LoyaltyPointController>().loyaltyPointModel!=null){
          return SizedBox(
            height: 60,
            width: Get.width,
            child: CustomButton(
              width: Dimensions.currencyConvertButtonHeight,
              buttonText: "convert_to_currency".tr,
              assetIcon: Images.convertPoint,
              height: 45,
              radius: Dimensions.radiusExtraMoreLarge,
              onPressed: (){
                showDialog(context: context, builder: (_){
                  return const ConvertLoyaltyPointDialog();
                });
              },
            ),
          );
        }else{
          return const SizedBox();
        }
      }),
    );
  }
}
