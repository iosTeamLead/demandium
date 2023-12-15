import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData notificationData;
  const NotificationItem({Key? key, required this.notificationData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.bottomSheet(Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
          insetPadding: const EdgeInsets.all(30),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall,),
            height: 500.0,
            width: Get.width,
            child: Column(
              children: [
                Text(notificationData.title!,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
                Gaps.verticalGapOf(3),
                Text(notificationData.description!,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),),
                CustomImage(
                  fit: BoxFit.cover,
                  height: 250,
                  width: Get.width,
                  image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/push-notification/${notificationData.coverImage}",),
              ],
            ),
          ),
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image(image: AssetImage(Images.notificationSmall),),
                ),
                Gaps.horizontalGapOf(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notificationData.title!,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
                      Gaps.verticalGapOf(3),
                      Text(notificationData.description!,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),)
                    ],),
                ),
                Text(DateConverter.dateMonthYearTime(DateConverter.isoStringToLocalDate(notificationData.createdAt!).toString()),
                  style: ubuntuRegular.copyWith(
                    fontSize: 12, color: Colors.black54,),textAlign: TextAlign.end,),
              ],
            ),
            Gaps.verticalGapOf(10.0),
          ],
        ),
      ),
    );
  }
}