import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/image_dialog.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandium/components/custom_app_bar.dart';
import 'package:demandium/components/custom_image.dart';
import 'package:demandium/core/helper/date_converter.dart';
import 'package:demandium/feature/notification/controller/notification_controller.dart';
import 'package:demandium/feature/notification/widget/notification_shimmer.dart';
import 'package:demandium/feature/root/view/no_data_screen.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: "notifications".tr, isBackButtonExist: true,),
        body: GetBuilder<NotificationController>(
          initState: (state){
            Get.find<NotificationController>().getNotifications(1);
          },
          builder: (controller) {
            return FooterBaseView(
                isScrollView:true,
                scrollController: scrollController,
                isCenter: Get.find<NotificationController>().notificationList.isEmpty ? true:false,
                child: WebShadowWrap(
                  child: SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: controller.isLoading? const NotificationShimmer(): controller.dateList.isEmpty ?
                    NoDataScreen(text: 'no_notification_found'.tr,type: NoDataType.notification,):
                    PaginatedListView(
                      scrollController: scrollController,
                      totalSize: controller.notificationModel!.content!.total!,
                      onPaginate: (int offset) async => await controller.getNotifications(
                        offset,
                        reload: false,
                      ),
                      offset: controller.notificationModel?.content?.currentPage,

                      itemView: ListView.builder(
                        padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        itemBuilder: (context, index0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding:  const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeExtraSmall,
                                vertical: Dimensions.paddingSizeSmall,
                              ),
                                child: Text(
                                  Get.find<NotificationController>().dateList[index0].toString(),
                                  style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7)),
                                  textDirection: TextDirection.ltr,

                                ),
                              ),
                              if(controller.notificationList.isNotEmpty)
                                Card(
                                  color: Theme.of(context).hoverColor,
                                  elevation: 0,
                                  child: ListView.builder(
                                    itemBuilder: (context, index1) {
                                      return InkWell(
                                        onTap: () => showDialog(context: context, builder: (ctx)  =>
                                          ImageDialog(
                                            imageUrl:'${Get.find<SplashController>().configModel.content!.imageBaseUrl}/push-notification/${controller.notificationList[index0][index1].coverImage}',
                                            title: controller.notificationList[index0][index1].title.toString().trim(),
                                            subTitle: "${controller.notificationList[index0][index1].description}",
                                          )
                                        ),
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeSmall),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: CustomImage(
                                                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                                            '/push-notification/${controller.notificationList[index0][index1].coverImage}',
                                                        height: 30,
                                                        width: 30,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(controller.notificationList[index0][index1].title.toString().trim(),
                                                              style: ubuntuMedium.copyWith(color: Theme.of(context).
                                                              textTheme.bodyLarge!.color!.withOpacity(0.7) ,
                                                                  fontSize: Dimensions.fontSizeDefault
                                                              )),
                                                          const SizedBox(height: Dimensions.paddingSizeSmall,),
                                                          Text("${controller.notificationList[index0][index1].description}",
                                                              maxLines: 2,
                                                              style: ubuntuRegular.copyWith(color: Theme.of(context).
                                                              textTheme.bodyLarge!.color!.withOpacity(0.5) ,
                                                                  fontSize: Dimensions.fontSizeDefault
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: 40, width: 60,
                                                        child: Text(DateConverter.convertStringTimeToDate(DateConverter.isoUtcStringToLocalDate(controller.notificationList[index0][index1].createdAt)))),
                                                  ],
                                                ),
                                              ],
                                            )
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.notificationList[index0].length,
                                  ),
                                )
                            ],
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.dateList.length,
                      ),
                    ),
                  ),
                )
            );
          },
        ));
  }
}










