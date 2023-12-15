import 'package:demandium/feature/home/model/banner_model.dart';
import 'package:demandium/feature/home/web/web_banner_shimmer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class WebBannerView extends GetView<BannerController> {
  final PageController _pageController = PageController();

  WebBannerView({super.key});
  @override
  Widget build(BuildContext context) {
    bool isLtr = Get.find<LocalizationController>().isLtr;
    String? baseUrl =  Get.find<SplashController>().configModel.content!.imageBaseUrl;
    return GetBuilder<BannerController>(

      builder: (bannerController){
        if(bannerController.banners != null && bannerController.banners!.isEmpty){
          return const SizedBox();
        }else{
          return Container(
            alignment: Alignment.center,
            child: SizedBox(
                width: Dimensions.webMaxWidth,
                height: 220,
                child: bannerController.banners != null ? bannerController.banners!.length == 1 ?
                InkWell(
                  onTap: () {
                    BannerModel bannerModel = bannerController.banners![0];
                    String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                    String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                    String name = bannerModel.category != null ? bannerModel.category!.name! : "";
                    bannerController.navigateFromBanner(
                        bannerModel.resourceType!,
                        id,
                        link,
                        bannerModel.resourceId != null ? bannerModel.resourceId! : '',
                        categoryName: name
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    child: CustomImage(
                      image: '$baseUrl/banner/${bannerController.banners![0].bannerImage}',
                      fit: BoxFit.fill,
                       height: 220,
                    ),
                  ),

                ) : Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    PageView.builder(
                      onPageChanged: (int index) => bannerController.setCurrentIndex(index, true),
                      controller: _pageController,
                      itemCount: (bannerController.banners!.length/2).ceil(),
                      itemBuilder: (context, index) {
                        String? baseUrl =  Get.find<SplashController>().configModel.content!.imageBaseUrl;
                        int index1 = index * 2;
                        int index2 = (index * 2) + 1;
                        bool hasSecond = index2 < bannerController.banners!.length;
                        return Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      BannerModel bannerModel = bannerController.banners![index1];
                                      String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                                      String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                                      String name = bannerModel.category != null ? bannerModel.category!.name! : "";

                                      bannerController.navigateFromBanner(
                                          bannerModel.resourceType!,
                                          id,
                                          link,
                                          bannerModel.resourceId != null ? bannerModel.resourceId! : '',
                                          categoryName: name);},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                      child: CustomImage(
                                        image: '$baseUrl/banner/${bannerController.banners![index1].bannerImage}',
                                        fit: BoxFit.cover,
                                        height: 220,
                                      ),

                                    ),
                                  ),
                              ),
                              const SizedBox(width: Dimensions.paddingSizeLarge),
                              Expanded(child: hasSecond ?
                              InkWell(
                                onTap: () {
                                  BannerModel bannerModel = bannerController.banners![index2];
                                  String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                                  String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                                  String name = bannerModel.category != null ? bannerModel.category!.name! : "";
                                  bannerController.navigateFromBanner(
                                      bannerModel.resourceType!,
                                      id,
                                      link,
                                      bannerModel.resourceId != null ? bannerModel.resourceId! : '',
                                      categoryName: name);},
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  child: CustomImage(
                                    image: '$baseUrl/banner/${bannerController.banners![index2].bannerImage}',
                                    fit: BoxFit.cover,
                                    height: 220,
                          ),
                        ),):
                              (!hasSecond && bannerController.banners!.length>2)?
                              InkWell(
                                onTap: () {
                                  BannerModel bannerModel = bannerController.banners![0];
                                  String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                                  String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                                  String name = bannerModel.category != null ? bannerModel.category!.name! : "";
                                  bannerController.navigateFromBanner(
                                      bannerModel.resourceType!,
                                      id,
                                      link,
                                      bannerModel.resourceId != null ? bannerModel.resourceId! : '',
                                      categoryName: name);},
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  child: CustomImage(
                                    image: '$baseUrl/banner/${bannerController.banners![0].bannerImage}',
                                    fit: BoxFit.cover,
                                    height: 220,),),):
                              const SizedBox()),
                    ]);},),
                    bannerController.currentIndex != 0 ?
                    Positioned(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                      child: InkWell(
                        onTap: () => _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                        child: Container(
                          height: 40, width: 40, alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70.withOpacity(0.6),
                              boxShadow:cardShadow,
                          ),
                          child: Center(
                            child: Padding(
                              padding:  EdgeInsets.only(
                                  left: isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                                  right: !isLtr ?  Dimensions.paddingSizeSmall : 0.0,
                              ),
                              child: Icon(
                                  Icons.arrow_back_ios,
                                  color: dark.cardColor
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ) :
                    const SizedBox(),
                    bannerController.currentIndex != ((bannerController.banners!.length/2).ceil()-1) ?
                    Positioned(child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                      child: InkWell(
                        onTap: () => _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                        child: Container(
                          height: 40, width: 40, alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70.withOpacity(0.6),
                              boxShadow: cardShadow
                          ),
                          child: Icon(
                              Icons.arrow_forward_ios,
                              size: Dimensions.webArrowSize,
                              color: dark.cardColor
                          ),
                        ),
                      ),
                    ),
                  ),):
                    const SizedBox(),
              ]): const WebBannerShimmer()),
          );
        }
      },
    );
  }
}



