import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import  'package:demandium/feature/provider/model/provider_model.dart';



class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  List<CartModel> _cartList = [];
  List<CartModel> _initialCartList = [];
  bool _isLoading = false;
  bool _isCartLoading = false;
  double _amount = 0.0;
  final bool _isOthersInfoValid = false;
  bool _isButton = false;

  List<CartModel> get cartList => _cartList;
  List<CartModel> get initialCartList => _initialCartList;
  double get amount => _amount;
  bool get isLoading => _isLoading;
  bool get isCartLoading  => _isCartLoading ;
  bool get isOthersInfoValid => _isOthersInfoValid;

  bool get isButton => _isButton;


  List<ProviderData>? _providerList;
  List<ProviderData>? get  providerList=> _providerList;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  double _walletBalance = 0.0;
  double get walletBalance => _walletBalance;

  double _bookingAmountWithoutCoupon = 0.0;
  double _couponAmount = 0.0;


  bool _walletPaymentStatus = false;
  bool get walletPaymentStatus => _walletPaymentStatus;


  bool preSelectedProvider = false;
  String selectedProviderRating ='';
  String selectedProviderProfileImages ='';
  String selectedProviderName ='';
  String selectedProviderId ='';
  String subcategoryId ='';

  int selectedProviderIndex = -1;

  @override
  void onInit() {
    if (Get.find<AuthController>().isLoggedIn()) {
      getCartListFromServer();
    } else {
      getCartData();
    }
    super.onInit();
  }

  Future<List<CartModel>> getCartData() async{
    _isLoading = false;
    _cartList = [];
    _cartList.addAll(cartRepo.getCartList());
    for (var cart in _cartList) {
      _amount = _amount + (cart.discountedPrice * cart.quantity);
    }

    if(_cartList.isNotEmpty){
      if(_cartList[0].provider!=null){
        preSelectedProvider = true;
        selectedProviderName =  _cartList[0].provider?.companyName??"";
        selectedProviderId =  _cartList[0].provider?.id??"";
        selectedProviderProfileImages =  _cartList[0].provider?.logo??"";
        selectedProviderRating =  _cartList[0].provider?.avgRating.toString()??"";
        subcategoryId = _cartList[0].subCategoryId;
      }
    }

    _isLoading = false;
    _cartTotalCost();
    update();
    return _cartList;

  }

  _cartTotalCost() {
    _totalPrice = 0.0;
    for (var cartModel in _cartList) {
      _totalPrice = _totalPrice + (cartModel.totalCost * cartModel.quantity) ;
    }
  }



  Future<void> getCartListFromServer({bool shouldUpdate = true})async{
    _isLoading = true;
    Response response = await cartRepo.getCartListFromServer();
    if(response.statusCode == 200){
      _cartList = [];
      response.body['content']['cart']['data'].forEach((cart){
        _cartList.add(CartModel.fromJson(cart));

      });

      if(response.body['content']['wallet_balance']!=null){
        _walletBalance = double.tryParse(response.body['content']['wallet_balance'].toString())!;
      }
      if(response.body['content']['total_cost']!=null){
        _totalPrice = double.tryParse(response.body['content']['total_cost'].toString())!;
      }

      if(_cartList.isNotEmpty){
        if(_cartList[0].provider!=null){
          preSelectedProvider = true;
          selectedProviderName =  _cartList[0].provider?.companyName??"";
          selectedProviderId =  _cartList[0].provider?.id??"";
          selectedProviderProfileImages =  _cartList[0].provider?.logo??"";
          selectedProviderRating =  _cartList[0].provider?.avgRating.toString()??"";
          subcategoryId = _cartList[0].subCategoryId;
        }
      }
    }
    else{
     // ApiChecker.checkApi(response);
    }

    _totalPrice = Get.find<SplashController>().configModel.content?.additionalCharge == 1 ? Get.find<SplashController>().configModel.content?.additionalChargeFeeAmount ?? 0.0 : 0.0;
    double couponDiscount = 0.0;
    for (var cartModel in _cartList) {
      _totalPrice = _totalPrice + cartModel.totalCost;
      couponDiscount = couponDiscount + cartModel.couponDiscountPrice;
    }
    _isLoading = false;
    if(shouldUpdate){
      update();
    }
  }

  Future<void> removeCartFromServer(String cartID)async{
    _isLoading = true;
    Response response = await cartRepo.removeCartFromServer(cartID);
    if(response.statusCode == 200){
      getCartListFromServer();
    }
    _isLoading = false;
    update();
  }


  Future<void> removeAllCartItem()async{
    Response response = await cartRepo.removeAllCartFromServer();
    if(response.statusCode == 200){
      _isLoading = false;
      getCartListFromServer(shouldUpdate: false);
    }
  }

  Future<void> updateCartQuantityToApi(String cartID, int quantity)async{
    _isCartLoading = true;
    update();


    Response response = await cartRepo.updateCartQuantity(cartID, quantity);
    if(response.statusCode == 200){
      _cartList = [];
      response.body['content']['cart']['data'].forEach((cart){
        _cartList.add(CartModel.fromJson(cart));

      });

      if(response.body['content']['wallet_balance']!=null){
        _walletBalance = double.tryParse(response.body['content']['wallet_balance'].toString())!;
      }
      if(response.body['content']['total_cost']!=null){
        _totalPrice = double.tryParse(response.body['content']['total_cost'].toString())!;
      }

      if(_cartList.isNotEmpty){
        if(_cartList[0].provider!=null){
          preSelectedProvider = true;
          selectedProviderName =  _cartList[0].provider?.companyName??"";
          selectedProviderId =  _cartList[0].provider?.id??"";
          selectedProviderProfileImages =  _cartList[0].provider?.logo??"";
          selectedProviderRating =  _cartList[0].provider?.avgRating.toString()??"";
          subcategoryId = _cartList[0].subCategoryId;
        }
      }
    }

    _isCartLoading = false;
    update();
  }

  Future<void> updateProvider()async{
    Response response = await cartRepo.updateProvider(selectedProviderId);
    if(response.statusCode == 200){
      getCartListFromServer();
    }
  }


  void removeFromCartVariation(CartModel? cartModel) {
    if(cartModel == null) {
      _initialCartList = [];
    }else{
      _initialCartList.remove(cartModel);
      update();
    }
  }

  void removeFromCartList(int cartIndex) {
    _cartList[cartIndex].quantity = _cartList[cartIndex].quantity - 1;
    update();
  }

  void updateQuantity(int index, bool isIncrement) {
    if(isIncrement){
      _initialCartList[index].quantity += 1;
      _totalPrice = _totalPrice + _initialCartList[index].totalCost;
    }else{
      if(_initialCartList[index].quantity > -1) {
        _initialCartList[index].quantity -= 1;
        _totalPrice = _totalPrice - _initialCartList[index].totalCost;
      }
    }
    _isButton = _isQuantity();
    update();
  }

 bool _isQuantity( ) {
    int count = 0;
    for (var cart in _initialCartList) {
      count += cart.quantity;
    }
    return count > 0;
  }


  void setQuantity(bool isIncrement, CartModel cart) {
    int index = _cartList.indexWhere((element) => element == cart);
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity + 1;
      _amount = _amount + _cartList[index].discountedPrice;
    } else {
      _cartList[index].quantity = _cartList[index].quantity - 1;
      _amount = _amount - _cartList[index].discountedPrice;
    }
    cartRepo.addToCartList(_cartList);

    _cartTotalCost();

    update();
  }

  void removeFromCart(int index) {
    _amount = _amount - (_cartList[index].discountedPrice * _cartList[index].quantity);
    _cartList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    update();
  }


  void clearCartList() {
    _cartList = [];
    _amount = 0;
    cartRepo.addToCartList(_cartList);
    update();
  }

  void addDataToCart(){
    if(_cartList.isNotEmpty && _initialCartList.first.subCategoryId != _cartList.first.subCategoryId) {
      Get.back();
      Get.dialog(ConfirmationDialog(
        icon: Images.warning,
        title: "are_you_sure_to_reset".tr,
        description: 'you_have_service_from_other_sub_category'.tr,
        onYesPressed: () async {
          _initialCartList.removeWhere((cart) => cart.quantity < 1);
          cartRepo.addToCartList(_initialCartList);
          _cartList = _initialCartList;
          _cartTotalCost();
          update();
          onDemandToast("successfully_added_to_cart".tr,Colors.green);
          Get.back();
        },
      ));
    }else{
      cartRepo.addToCartList(_replaceCartList());
      _cartTotalCost();
      update();
      onDemandToast("successfully_added_to_cart".tr,Colors.green);
      Get.back();
    }

  }

  Future<void> addMultipleCartToServer({bool fromServiceCenterDialog = true}) async {
    _isLoading = true;
    update();
    _replaceCartList();

    if(_initialCartList.first.subCategoryId != _cartList.first.subCategoryId){
      Get.back();
      Get.dialog(ConfirmationDialog(
        icon: Images.warning,
        title: "are_you_sure_to_reset".tr,
        description: 'you_have_service_from_other_sub_category'.tr,
        isLogOut: true,
        onNoPressed: (){
          Get.back();
        },
        onYesPressed: () async {
          Get.back();
          Get.dialog(const CustomLoader(), barrierDismissible: false,);
          await cartRepo.removeAllCartFromServer();
          if(_initialCartList.isNotEmpty){
            for (int index=0; index<_initialCartList.length;index++){
              await addToCartApi(_initialCartList[index]);
            }
          }
         await getCartListFromServer();
          _isLoading = false;
          Get.back();
          if(fromServiceCenterDialog){
            onDemandToast("successfully_added_to_cart".tr,Colors.green);
          }
        },
      ));
    }
    else{
      await cartRepo.removeAllCartFromServer();
      if(_cartList.isNotEmpty){
        for (int index=0; index<_cartList.length;index++){
          await addToCartApi(_cartList[index]);
        }
      }

      clearCartList();
      if(fromServiceCenterDialog){
        Get.back();
        customSnackBar("successfully_added_to_cart".tr,isError: false);
      }
    }
    _isLoading = false;
    update();
  }

  Future<void> addToCartApi(CartModel cartModel)async{

    if(selectedProviderId!=""){
     await cartRepo.addToCartListToServer(CartModelBody(
        serviceId:cartModel.service!.id,
        categoryId: cartModel.categoryId,
        variantKey: cartModel.variantKey,
        quantity: cartModel.quantity.toString(),
        subCategoryId: cartModel.subCategoryId,
        providerId: selectedProviderId,
        guestId: Get.find<SplashController>().getGuestId(),
      ));
    }else{
       await cartRepo.addToCartListToServer(CartModelBody(
        serviceId:cartModel.service!.id,
        categoryId: cartModel.categoryId,
        variantKey: cartModel.variantKey,
        quantity: cartModel.quantity.toString(),
        subCategoryId: cartModel.subCategoryId,
        guestId: Get.find<SplashController>().getGuestId(),
      ));
    }
  }


  void removeAllAndAddToCart(CartModel cartModel) {
    _cartList = [];
    _cartList.add(cartModel);
    _amount = cartModel.discountedPrice.toDouble() * cartModel.quantity;
    cartRepo.addToCartList(_cartList);
    update();
  }

  int isAvailableInCart(CartModel cartModel, Service service) {
    int index = -1;
    for (var cart in _cartList) {
      if(cart.service != null){
        if(cart.service!.id!.contains(service.id!)) {
          service.variationsAppFormat?.zoneWiseVariations?.forEach((variation) {
            if(variation.variantKey == cart.variantKey && variation.price == cart.serviceCost) {

              if(cart.variantKey == cartModel.variantKey) {
                index = _cartList.indexOf(cart);
              }
            }
          });

        }
      }
    }
    return index;
  }

  setInitialCartList(Service service) {
    _totalPrice = 0;
    _initialCartList = [];
    service.variationsAppFormat?.zoneWiseVariations?.forEach((variation) {
      CartModel cartModel = CartModel(
          service.id!,
          service.id!,
          service.categoryId!,
          service.subCategoryId!,
          variation.variantKey!,
          variation.price!,
          0,
          0, 0, 0,
          "",
          service.tax ?? 0,
          variation.price ?? 0,
          service
      );
      int index =  isAvailableInCart(cartModel, service);
      if(index != -1) {
        cartModel.copyWith(id: _cartList[index].id, quantity: _cartList[index].quantity);
      }
      _initialCartList.add(cartModel);
    });
    _isButton = false;

  }

  List<CartModel> _replaceCartList() {
    _initialCartList.removeWhere((cart) => cart.quantity < 0);

    for (var initCart in _initialCartList) {
      _cartList.removeWhere((cart) => cart.id.contains(initCart.id) && cart.variantKey.contains(initCart.variantKey));
    }
    _cartList.addAll(_initialCartList);
    _cartList.removeWhere((element) => element.quantity == 0);

    return _cartList;
  }

  Future<void> getProviderBasedOnSubcategory(String subcategoryId,bool reload) async {

      Response response = await cartRepo.getProviderBasedOnSubcategory(subcategoryId);
      if (response.statusCode == 200) {
        if(reload){
          _providerList = [];
        }
        List<dynamic> list =  response.body['content'];
        for (var element in list) {
          providerList!.add(ProviderData.fromJson(element));
        }

        if(selectedProviderId!="" && _providerList!=null && _providerList!.isNotEmpty){

          for(int i=0;i<_providerList!.length;i++){
            if(selectedProviderId==_providerList![i].id){
              selectedProviderIndex =i;
            }
          }
        }else{
          selectedProviderIndex = -1;
        }
      } else {
        //ApiChecker.checkApi(response);
      }
    update();
  }

  void updateProviderSelectedIndex(int index){
    selectedProviderIndex = index;
    update();
  }

  void updatePreselectedProvider(String rating, String id,String profileImage,String name){
    preSelectedProvider = true;
    selectedProviderId = id;
    selectedProviderProfileImages = profileImage;
    selectedProviderRating = rating;
    selectedProviderName= name;
    update();
  }


  void resetPreselectedProviderInfo(){
    preSelectedProvider = false;
    selectedProviderId = "";
    selectedProviderProfileImages = "";
    selectedProviderRating = "";
    update();
  }

  void setSubCategoryId(String subcategoryId){
    subcategoryId = subcategoryId;
    update();
  }

  void updateWalletPaymentStatus(bool status, {bool shouldUpdate = true}){
    _walletPaymentStatus = status;

    if(shouldUpdate){
      update();
    }
  }

  updateBookingAmountWithoutCoupon(){

    double subTotalPrice = 0;
    double disCount = 0;
    double campaignDisCount = 0;
    double couponDisCount = 0;
    double vat = 0;
    for (var cartModel in _cartList) {
      subTotalPrice = subTotalPrice + (cartModel.serviceCost * cartModel.quantity); //(without any discount and coupons)
      disCount = disCount + cartModel.discountedPrice ;
      campaignDisCount = campaignDisCount + cartModel.campaignDiscountPrice;
      couponDisCount = couponDisCount + cartModel.couponDiscountPrice;
      vat = vat + (cartModel.taxAmount );

    }
    _bookingAmountWithoutCoupon = ((subTotalPrice  - (disCount + campaignDisCount)) + vat
        + (Get.find<SplashController>().configModel.content?.additionalCharge == 1 ? Get.find<SplashController>().configModel.content?.additionalChargeFeeAmount ?? 0 : 0  ));
    _couponAmount = couponDisCount;
  }


  bool isOpenPartialPaymentPopup = true;

  void updateIsOpenPartialPaymentPopupStatus(bool status, {bool shouldUpdate = true}){
    isOpenPartialPaymentPopup = status;
    if(shouldUpdate){
      update();
    }
  }


  Future<void> openWalletPaymentConfirmDialog() async {
    bool initialCheck;
    bool checkAfterUsingCoupon;

    if(_bookingAmountWithoutCoupon > walletBalance){
      initialCheck = true;
    }else{
      initialCheck = false;
    }
    if(_bookingAmountWithoutCoupon > (walletBalance + _couponAmount)){
      checkAfterUsingCoupon =  true;
    }else{
      checkAfterUsingCoupon = false;
    }

    if(initialCheck != checkAfterUsingCoupon && walletPaymentStatus && isOpenPartialPaymentPopup){
      showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: Center(
                child: Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        color: Theme.of(context).cardColor
                    ),

                    child: Stack(
                      alignment: Alignment.topRight,
                      clipBehavior: Clip.none,
                      children: [
                        const WalletPaymentConfirmDialog(),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: (){
                            Get.back();
                            updateWalletPaymentStatus(false);
                          },
                          icon :  const Icon(Icons.cancel),color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: Get.context!,
        pageBuilder: (context, animation1, animation2){
          return Container();
        },
      );
    }
  }


  void showMinimumAndMaximumOrderValueToaster() {
    ConfigModel configModel = Get.find<SplashController>().configModel;

    Get.closeAllSnackbars();

    if(configModel.content!.minBookingAmount !=0 && configModel.content!.minBookingAmount! > Get.find<CartController>().totalPrice && Get.find<CartController>().cartList.isNotEmpty){
      customSnackBar("message",
        customWidget: Row(children: [
          Icon(Icons.circle, color: Colors.white.withOpacity(0.8),size: 16,),
          Text("  ${'minimum_booking_amount'.tr} ${PriceConverter.convertPrice(Get.find<SplashController>().configModel.content!.minBookingAmount!)}",
            style: ubuntuRegular.copyWith(color: Colors.white),
          ),
        ],),
        backgroundColor: Colors.black87,
      );
    }else{
      if(configModel.content!.maxBookingAmount !=0 && configModel.content!.maxBookingAmount! < Get.find<CartController>().totalPrice &&  Get.find<CartController>().cartList.isNotEmpty){
        customSnackBar("message",
          customWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Icon(Icons.warning_outlined, color: Theme.of(Get.context!).cardColor.withOpacity(0.6),size: 16,),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                Flexible(child: Text(" ${'maximum_order_amount_exceed'.tr} ""(${'${'maximum_order_amount'.tr}'
                    ' ${PriceConverter.convertPrice(Get.find<SplashController>().configModel.content!.maxBookingAmount!)}'}) ${"admin_will_verify_this_order".tr}",
                  style: ubuntuRegular.copyWith(color: Colors.white),
                )),
              ],),
            ],
          ),
          backgroundColor: Colors.black87,
        );
      }
    }
  }
}
