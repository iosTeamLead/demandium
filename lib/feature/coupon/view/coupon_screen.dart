import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';


class CouponScreen extends StatefulWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> with TickerProviderStateMixin{
  TabController? _couponTabController;


  @override
  initState() {
    _couponTabController = TabController(vsync: this, length: 2, initialIndex: 0);
    Get.find<CouponController>().getCouponList();
    _couponTabController?.addListener(() {
      Get.find<CouponController>().updateTabBar(
        _couponTabController?.index == 0 ?  CouponTabState.currentCoupon : CouponTabState.usedCoupon,
      );
    });

    Get.find<CouponController>().updateSelectedCouponIndex(-1, shouldUpdate: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(
        title: "voucher".tr,
        centerTitle: true,
        onBackPressed: (){
          Get.find<CartController>().updateIsOpenPartialPaymentPopupStatus(false);
          Get.back();
        },
      ),
      body: GetBuilder<CouponController>(
          builder: (couponController){
            List<CouponModel>? activeCouponList = couponController.activeCouponList;
            List<CouponModel>? expiredCouponList = couponController.expiredCouponList;
            return FooterBaseView(
              isScrollView: ResponsiveHelper.isWeb()?true:false,
              isCenter: (activeCouponList == null || activeCouponList.isEmpty),
              child: WebShadowWrap(
                child: Container(
                    child: ((activeCouponList != null && activeCouponList.isEmpty) && (expiredCouponList != null && expiredCouponList.isEmpty)) ?
                    NoDataScreen(text: "no_coupon_found".tr,type: NoDataType.coupon):
                    (activeCouponList != null && expiredCouponList!=null) ?
                    Column(children: [
                      if(activeCouponList.isNotEmpty || expiredCouponList.isNotEmpty)
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              height: 91,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: AssetImage(Images.offerBanner),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: 91,
                              color: Colors.black54,
                              width: Get.width,
                            ),
                          ],
                        ),

                      TabBar(
                        controller: _couponTabController,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorWeight: 3,
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Get.isDarkMode?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5):Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        labelColor: Get.isDarkMode?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8):Theme.of(context).primaryColor,
                        unselectedLabelColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5),
                        unselectedLabelStyle: ubuntuMedium.copyWith(
                          color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge,
                        ),

                        labelStyle: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).primaryColor,
                        ),
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: Text(
                              'current_voucher'.tr,
                              style: ubuntuMedium,
                            ),
                          ),
                          Padding(
                            padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: Text('used_voucher'.tr,
                              style: ubuntuMedium,),
                          ),
                        ],
                      ),
                      Container(height: 1,color: Theme.of(context).hintColor),
                      if(!ResponsiveHelper.isWeb())
                      Expanded(
                        child: TabBarView(
                          controller: _couponTabController,
                            children: [
                          _couponList(context, activeCouponList),
                          _couponList(
                              context, expiredCouponList,isExpired: true
                          )
                        ]),
                      ),
                      if(ResponsiveHelper.isWeb())
                      _couponTabController?.index == 0?
                      _couponList(
                        context, activeCouponList
                      ):_couponList(
                          context, expiredCouponList,isExpired: true
                      ),
                    ],): const Center(child: CircularProgressIndicator(),)),
              ),
            );
          }

      ),
    );
  }

  Widget _couponList(BuildContext context, List<CouponModel> couponList,{bool isExpired = false}) {
    return couponList.isNotEmpty ?
    GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: Dimensions.paddingSizeLarge,
        mainAxisSpacing: ResponsiveHelper.isDesktop(context) ?
        Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall,
        childAspectRatio: ResponsiveHelper.isMobile(context) ? 3.2 : 4,
        crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
        mainAxisExtent:Get.find<LocalizationController>().isLtr ?  130 : 162,
      ),
      itemBuilder: (context, index) {
        return Voucher(
          isExpired: isExpired,
          couponModel: couponList[index],
          index: index,
        );
      },
      itemCount: couponList.length,
    ) : SizedBox(
        height:Get.height*0.6,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Text(
              isExpired?'no_expired_coupon_found'.tr:'no_active_coupon_found'.tr,
            ),
          ),
        ),
    );
  }
}
