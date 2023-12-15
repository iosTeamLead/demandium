import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/utils/html_type.dart';

class HtmlViewerScreen extends StatelessWidget {
  final HtmlType? htmlType;
  const HtmlViewerScreen({super.key, @required this.htmlType});

  @override
  Widget build(BuildContext context) {
    String imageBaseUrl = Get.find<SplashController>().configModel.content!.imageBaseUrl!;

    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: htmlType == HtmlType.termsAndCondition ? 'terms_and_conditions'.tr
          : htmlType == HtmlType.aboutUs ? 'about_us'.tr :
      htmlType == HtmlType.privacyPolicy ? 'privacy_policy'.tr :
      htmlType == HtmlType.cancellationPolicy ? 'cancellation_policy'.tr :
      htmlType == HtmlType.refundPolicy ? 'refund_policy'.tr :
      'no_data_found'.tr),


      body: GetBuilder<HtmlViewController>(
        initState: (state){
          Get.find<HtmlViewController>().getPagesContent();
        },
        builder: (htmlViewController){
          String? data;
          if(htmlViewController.pagesContent != null){
             data = htmlType == HtmlType.termsAndCondition ? htmlViewController.pagesContent!.termsAndConditions!.liveValues!
                : htmlType == HtmlType.aboutUs ? htmlViewController.pagesContent!.aboutUs!.liveValues!
                : htmlType == HtmlType.privacyPolicy ? htmlViewController.pagesContent!.privacyPolicy!.liveValues!
                : htmlType == HtmlType.refundPolicy ? htmlViewController.pagesContent!.refundPolicy!.liveValues!
                : htmlType == HtmlType.cancellationPolicy ? htmlViewController.pagesContent!.cancellationPolicy!.liveValues!
                : null;

               if(data != null) {
                 data = data.replaceAll('href=', 'target="_blank" href=');

               return FooterBaseView(
                 isScrollView:ResponsiveHelper.isMobile(context) ? false: true,
                 isCenter:true,
                 child: WebShadowWrap(
                   child: SizedBox(
                     width: Dimensions.webMaxWidth,
                     height: Get.height,
                     child:SingleChildScrollView(
                       padding: const EdgeInsets.all(Dimensions.paddingSizeSmall,
                       ),
                       physics: const BouncingScrollPhysics(),
                       child: Column(
                         children: [
                          if( ResponsiveHelper.isDesktop(context))
                           Padding(
                             padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                             child: Text(
                                 htmlType == HtmlType.termsAndCondition ? 'terms_and_conditions'.tr
                                     : htmlType == HtmlType.aboutUs ? 'about_us'.tr :
                                 htmlType == HtmlType.privacyPolicy ? 'privacy_policy'.tr :
                                 htmlType == HtmlType.cancellationPolicy ? 'cancellation_policy'.tr :
                                 htmlType == HtmlType.refundPolicy ? 'refund_policy'.tr:'',
                               style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                             ),
                           ),
                           Html(
                             data: data,
                             style: {
                               "p": Style(
                                 fontSize: FontSize.medium,
                               ),

                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
               );
             }else{
               return const SizedBox();
             }
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        hoverColor:Colors.black26,
        onPressed: (){
          if(isRedundentClick(DateTime.now())){
            return;
          }
          String userId = Get.find<SplashController>().configModel.content!.adminDetails!.id!;
          String phone = Get.find<SplashController>().configModel.content?.businessPhone??"";
          String name = "${Get.find<SplashController>().configModel.content!.adminDetails!.firstName!} ${Get.find<SplashController>().configModel.content!.adminDetails!.lastName!}";
          String image = "$imageBaseUrl/user/profile_image/${Get.find<SplashController>().configModel.content!.adminDetails!.profileImage!}";
          Get.find<ConversationController>().createChannel(userId, "",name: name,image: image,fromBookingDetailsPage: true,phone: phone);
        },
        child: Center(child: Image.asset(Images.adminChat,scale: 2.8,)),
      ),
    );
  }
}
