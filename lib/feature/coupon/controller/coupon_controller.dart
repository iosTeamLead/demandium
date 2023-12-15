import 'package:get/get.dart';
import '../../../components/core_export.dart';


class CouponController extends GetxController implements GetxService{
  final CouponRepo couponRepo;
  CouponController({required this.couponRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  List<CouponModel>? _activeCouponList;
  List<CouponModel>? get activeCouponList => _activeCouponList;

  List<CouponModel>? _expiredCouponList;
  List<CouponModel>? get expiredCouponList => _expiredCouponList;

  int _selectedCouponIndex = -1;
  int get selectedCouponIndex => _selectedCouponIndex;


  TabController? voucherTabController;
  CouponTabState __couponTabCurrentState = CouponTabState.currentCoupon;
  CouponTabState get couponTabCurrentState => __couponTabCurrentState;

  Future<void> getCouponList() async {
    _isLoading = true;
    Response response = await couponRepo.getCouponList();
    if (response.statusCode == 200) {
      _activeCouponList = [];
      _expiredCouponList = [];
      response.body["content"]['active_coupons']["data"].forEach((category) {
          _activeCouponList!.add(CouponModel.fromJson(category));
      });
      response.body["content"]['expired_coupons']["data"].forEach((category) {
        _expiredCouponList!.add(CouponModel.fromJson(category));
      });
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel> applyCoupon(CouponModel couponModel) async {
    _isLoading = true;
    update();

    Response response = await couponRepo.applyCoupon(couponModel.couponCode!);
    if(response.statusCode == 200 && response.body['response_code'] == 'default_200'){

      await Get.find<CartController>().getCartListFromServer();
      Get.find<CartController>().updateBookingAmountWithoutCoupon();

      _isLoading = false;
      update();
      return ResponseModel(true, "coupon_applied_successfully");
    }else{
      _isLoading = false;
      update();

      return ResponseModel(false, "this_coupon_is_not_valid_for_your_cart");
    }
  }



  Future<void> removeCoupon() async {
    _isLoading = true;
    update();
    Response response = await couponRepo.removeCoupon();
    if(response.statusCode == 200 && response.body['response_code'] == 'default_update_200'){
      await Get.find<CartController>().getCartListFromServer();
      customSnackBar("coupon_removed_successfully".tr, isError: false);
    }else{

    }
    _isLoading = false;
    update();
  }



  void updateTabBar(CouponTabState couponTabState, {bool isUpdate = true}){
    __couponTabCurrentState = couponTabState;
    if(isUpdate){
      update();
    }
  }

  updateSelectedCouponIndex(int index,{bool shouldUpdate = true}){
    _selectedCouponIndex = index;
    if(shouldUpdate){
      update();
    }
  }
}

enum CouponTabState {
  currentCoupon,
  usedCoupon
}