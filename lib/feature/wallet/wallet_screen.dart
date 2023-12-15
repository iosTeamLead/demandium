import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:demandium/feature/wallet/wallet_screen_web.dart';
import 'package:demandium/feature/wallet/widgets/wallet_promotional_banner.dart';
import 'package:demandium/feature/wallet/widgets/wallet_top_card.dart';
import 'package:demandium/feature/wallet/widgets/wallet_list_view.dart';
import 'package:demandium/feature/wallet/widgets/wallet_uses_manual_dialog.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class WalletScreen extends StatefulWidget {
  final String? status;
  final String? token;
  const WalletScreen({Key? key, required this.status, this.token}) : super(key: key);
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  final tooltipController = JustTheController();

  @override
  void initState() {
    super.initState();
    Get.find<WalletController>().getWalletTransactionData(1);
    Get.find<WalletController>().getBonusList(false);
    Get.find<WalletController>().insertFilterList();


    Future.delayed(const Duration(seconds: 1)).then((value){
      if(widget.status != null && widget.status!.contains("success") && Get.find<WalletController>().getWalletAccessToken() != widget.token){
        customSnackBar("message", customWidget: Row(children: [
          const SizedBox(width: Dimensions.paddingSizeDefault,),
          const Icon(Icons.check_circle, color: Colors.white70,),
          const SizedBox(width: Dimensions.paddingSizeDefault,),
          Text("fund_added_successfully".tr, style: ubuntuRegular.copyWith(color: Colors.white70,),)
        ]),
            backgroundColor: Colors.black87,
            borderRadius: Dimensions.radiusExtraMoreLarge
        );
      }
    }).then((value) {
      Get.find<WalletController>().setWalletAccessToken(widget.token ?? "");
    });

  }
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      endDrawer : ResponsiveHelper.isDesktop(context) ? const MenuDrawer() : null,

      appBar: CustomAppBar(title: 'my_wallet'.tr, actionWidget: InkWell(
        onTap: () {
          showGeneralDialog(
            context: context, barrierDismissible: true, transitionDuration: const Duration(milliseconds: 500),
            barrierLabel: MaterialLocalizations.of(context).dialogLabel, barrierColor: Colors.black.withOpacity(0.5),
            pageBuilder: (context, _, __) {
              return const WalletUsesManualDialog();
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition( position: CurvedAnimation(parent: animation, curve: Curves.easeOut,
                ).drive(Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero,)),
                child: child,
              );
            },
          );
        },
        child: Padding( padding: const EdgeInsets.fromLTRB(15,0, 15, 0),
          child: Image.asset(Images.info, width: 20, height: 20, color: Colors.white,),
        ),
      )),

      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<WalletController>().insertFilterList();
          Get.find<WalletController>().getWalletTransactionData(1, reload: true);
        },
        child: GetBuilder<WalletController>(
          builder: (walletController){
            return ResponsiveHelper.isDesktop(context) ? WalletScreenWeb (scrollController: scrollController, tooltipController: tooltipController,) :

            SingleChildScrollView(
              controller: scrollController,
              child: Column(children: [
                WalletTopCard(tooltipController: tooltipController,),
                const WalletPromotionalBannerView(),
                WalletListView(scrollController: scrollController,),
              ],),
            );
        }),
      ),
    );
  }
}
