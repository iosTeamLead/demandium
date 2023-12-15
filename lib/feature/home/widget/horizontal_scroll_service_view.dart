import 'package:get/get.dart';
import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/components/core_export.dart';

class HorizontalScrollServiceView extends GetView<ServiceController> {
  final String? fromPage;
  final List<Service>? serviceList;
  const HorizontalScrollServiceView({super.key, required this.fromPage,required this.serviceList});
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    if(serviceList != null && serviceList!.isEmpty){
      return const SizedBox();
    }else{
      if(serviceList!= null){
        return Stack(
          children: [
            if(fromPage=='recently_view_services')
            ClipPath(
              clipper: TsClip2(),
              child: Container(
                width: double.infinity,
                height: 200,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeSmall,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeExtraSmall,
                  ),
                  child: TitleWidget(
                    title: fromPage!,
                    onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute(fromPage!)),
                  ),
                ),
                SizedBox(
                  height: Get.find<LocalizationController>().isLtr ?ResponsiveHelper.isMobile(context) ? 260 :270 :  270,
                  child:ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,bottom: Dimensions.paddingSizeExtraSmall,top: Dimensions.paddingSizeExtraSmall),
                    itemCount: serviceList!.length > 10 ? 10 : serviceList!.length,
                    itemBuilder: (context, index){
                      controller.getServiceDiscount(serviceList![index]);
                      Discount discountModel =  PriceConverter.discountCalculation(serviceList![index]);
                      Service service = serviceList!.elementAt(index);
                      double lowestPrice = 0.0;
                      if(service.variationsAppFormat!.zoneWiseVariations != null){
                        lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
                        for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
                          if (service.variationsAppFormat!.zoneWiseVariations![i].price! < lowestPrice) {
                            lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
                          }
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                        child: Stack(
                          alignment:Get.find<LocalizationController>().isLtr ?  Alignment.bottomRight : Alignment.bottomLeft,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: Get.width / 2.3,
                                  decoration: BoxDecoration(
                                      color:  Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                      boxShadow:Get.isDarkMode ?null: cardShadow
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          //image and service name
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                                                    child: CustomImage(
                                                      image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.thumbnail}',
                                                      fit: BoxFit.cover,
                                                      width: MediaQuery.of(context).size.width/2.5,
                                                      height: 135,
                                                    ),
                                                  ),
                                                  discountModel.discountAmount! > 0 ?
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Container(
                                                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context).colorScheme.error,
                                                        borderRadius: const BorderRadius.only(
                                                          bottomRight: Radius.circular(Dimensions.radiusDefault),
                                                          topLeft: Radius.circular(Dimensions.radiusSmall),
                                                        ),
                                                      ),
                                                      child: Directionality(
                                                        textDirection: TextDirection.rtl,
                                                        child: Text(
                                                          PriceConverter.percentageOrAmount('${discountModel.discountAmount}','${discountModel.discountAmountType}'),
                                                          style: ubuntuRegular.copyWith(color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ):
                                                  const SizedBox(),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(Dimensions.paddingSizeEight),
                                                child: Text(
                                                    service.name!,
                                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                                    maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,

                                              children: [
                                                SizedBox(height:ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeMini: Dimensions.paddingSizeEight,),
                                                Text(
                                                  'starts_from'.tr,
                                                  style:  ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                                    if(discountModel.discountAmount! > 0)
                                                      Directionality(
                                                        textDirection: TextDirection.ltr,
                                                        child: Text(
                                                          PriceConverter.convertPrice(lowestPrice),
                                                          style: ubuntuRegular.copyWith(
                                                              fontSize: Dimensions.fontSizeSmall,
                                                              decoration: TextDecoration.lineThrough,
                                                              color: Theme.of(context).colorScheme.error.withOpacity(.8)),
                                                        ),
                                                      ),
                                                    const SizedBox(height: Dimensions.paddingSizeMini,),
                                                    discountModel.discountAmount! > 0?
                                                    Directionality(
                                                      textDirection: TextDirection.ltr,
                                                      child: Text(PriceConverter.convertPrice(
                                                          lowestPrice,
                                                          discount: discountModel.discountAmount!.toDouble(),
                                                          discountType: discountModel.discountAmountType
                                                      ),
                                                        style: ubuntuRegular.copyWith(
                                                            fontSize: Dimensions.paddingSizeDefault,
                                                            color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                                      ),
                                                    ):
                                                    Directionality(
                                                      textDirection: TextDirection.ltr,
                                                      child: Text(
                                                        PriceConverter.convertPrice(lowestPrice),
                                                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),),
                                Positioned.fill(
                                  child: RippleButton(
                                    onTap:() => Get.toNamed(RouteHelper.getServiceRoute(service.id!),
                                    ),
                                  ),)
                              ],),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  child: Icon(
                                      Icons.add,
                                      color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor,
                                      size: Dimensions.paddingSizeLarge),
                                ),
                                Positioned.fill(
                                  child: RippleButton(
                                    onTap: () {
                                      Get.find<CartController>().resetPreselectedProviderInfo();
                                      showModalBottomSheet(
                                        context: context,
                                        useRootNavigator: true,
                                        isScrollControlled: true,
                                        builder: (context) => ServiceCenterDialog(service: service,),
                                        backgroundColor: Colors.transparent

                                    );},
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ) ,
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,)
              ],
            ),
          ],
        );
      }
      else{
        return const PopularServiceShimmer(enabled: true,);
      }
    }
  }
}


class TsClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height/2);
    path.quadraticBezierTo(
        size.width / 1.3, size.height+70, size.width, size.height/1.3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class PopularServiceShimmer extends StatelessWidget {
  final bool enabled;
  const PopularServiceShimmer({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeSmall,),
        itemCount: 10,
        itemBuilder: (context, index){
          return Container(
            height: 80, width: Get.width / 2.3,
            margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,bottom: 10,top: 10),
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
            ),
            child: Shimmer(
              duration: const Duration(seconds: 1),
              interval: const Duration(seconds: 1),
              enabled: enabled,
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      color: Theme.of(context).shadowColor
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(height: 15, width: 100, color: Theme.of(context).shadowColor),
                      const SizedBox(height: 5),
                      Container(height: 10, width: 130, color: Theme.of(context).shadowColor),
                      const SizedBox(height: 5),
                      Container(height: 10, width: 130, color: Theme.of(context).shadowColor),

                    ]),
                  ),
                ),

              ]),
            ),
          );
        },
      ),
    );
  }
}

