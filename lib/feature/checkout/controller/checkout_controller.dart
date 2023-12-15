import 'dart:convert';

import 'package:demandium/components/core_export.dart';
import 'package:demandium/core/helper/string_parser.dart';
import 'package:demandium/feature/checkout/model/offline_payment_method_model.dart';
import 'package:demandium/feature/checkout/widget/payment_section/payment_method_button.dart';
import 'package:get/get.dart';


enum PageState {orderDetails, payment, complete}

enum PaymentMethodName  {digitalPayment, cos , walletMoney, offline ,none}

class CheckOutController extends GetxController implements GetxService{
 final CheckoutRepo checkoutRepo;
  CheckOutController({required this.checkoutRepo});
  PageState currentPageState = PageState.orderDetails;
  var selectedPaymentMethod = PaymentMethodName.none;
  bool showCoupon = false;
  bool cancelPayment = false;

  PostDetailsContent? postDetails;
  double totalAmount = 0.0;
  double totalVat = 0.0;

 DigitalPaymentMethod? _selectedDigitalPaymentMethod;
 DigitalPaymentMethod ? get selectedDigitalPaymentMethod => _selectedDigitalPaymentMethod;

 OfflinePaymentModel? _selectedOfflineMethod;
 OfflinePaymentModel? get selectedOfflineMethod => _selectedOfflineMethod;

 final GlobalKey<FormState> formKey = GlobalKey<FormState>();

 List<TextEditingController> _offlinePaymentInputField  = [];
 List<TextEditingController> get offlinePaymentInputField  => _offlinePaymentInputField;

 List<Map<String,String>> _offlinePaymentInputFieldValues = [];
 List<Map<String,String>> get offlinePaymentInputFieldValues => _offlinePaymentInputFieldValues;

 List<DigitalPaymentMethod> _digitalPaymentList = [];
 List<DigitalPaymentMethod> get digitalPaymentList => _digitalPaymentList;

 List<PaymentMethodButton> _othersPaymentList = [];
 List<PaymentMethodButton> get othersPaymentList => _othersPaymentList;


  bool _showOfflinePaymentInputData = false;
  bool get showOfflinePaymentInputData => _showOfflinePaymentInputData;

  bool _isPlacedOrderSuccessfully = true;
  bool get isPlacedOrderSuccessfully => _isPlacedOrderSuccessfully;

 bool _isPartialPayment = false;
 bool get isPartialPayment => _isPartialPayment;

  String _bookingReadableId = "";
  String get bookingReadableId => _bookingReadableId;

  bool _isLoading= false;
  bool get isLoading => _isLoading;


  void updateState(PageState currentPage,{bool shouldUpdate = true}){
    currentPageState=currentPage;
    if(shouldUpdate){
      update();
    }
  }

 void changePaymentMethod({DigitalPaymentMethod ? digitalMethod, OfflinePaymentModel? offlinePaymentModel, bool walletPayment = false, bool cashAfterService = false,bool shouldUpdate = true, }){

    if( offlinePaymentModel != null){

     _selectedOfflineMethod = offlinePaymentModel;
     selectedPaymentMethod = PaymentMethodName.offline;

   } else if(digitalMethod != null){
      _selectedOfflineMethod = null;
     _selectedDigitalPaymentMethod = digitalMethod;
     selectedPaymentMethod = PaymentMethodName.digitalPayment;

   }else if(walletPayment){
      _selectedDigitalPaymentMethod = null;
      _selectedOfflineMethod = null;
      selectedPaymentMethod = PaymentMethodName.walletMoney;
   } else if(cashAfterService){
      _selectedDigitalPaymentMethod = null;
      _selectedOfflineMethod = null;
      selectedPaymentMethod = PaymentMethodName.cos;
   }else{
      selectedPaymentMethod = PaymentMethodName.none;
      _selectedDigitalPaymentMethod = null;
      _selectedOfflineMethod = null;
   }

    _showOfflinePaymentInputData = false;

   if(shouldUpdate){
     update();
   }
 }

 void initializedOfflinePaymentTextField({bool shouldUpdate = false}){
   _offlinePaymentInputField = [];
   _offlinePaymentInputFieldValues = [];
   for(int i = 0; i < selectedOfflineMethod!.customerInformation!.length; i++){
     Get.find<CheckOutController>().offlinePaymentInputField.add(TextEditingController());
   }
   if(shouldUpdate){
     update();
   }
 }

 void showOfflinePaymentData({bool isShow = true}){
    _showOfflinePaymentInputData = isShow;
    update();
 }


 Future<void> placeBookingRequest({
   required String paymentMethod,required String schedule, int isPartial = 0, required AddressModel address,
   String? offlinePaymentId, String? customerInformation
 })async{
   String zoneId = Get.find<LocationController>().getUserAddress()!.zoneId.toString();

   _isLoading = true;
   update();

   if(Get.find<CartController>().cartList.isNotEmpty){
     Response response = await checkoutRepo.placeBookingRequest(
       paymentMethod : paymentMethod,
       zoneId : zoneId,
       schedule : schedule,
       serviceAddressID : address.id == "null" ? "" : address.id,
       serviceAddress: address,
       isPartial: isPartial,
       offlinePaymentId: offlinePaymentId ?? "",
       customerInformation: customerInformation ?? ""
     );
     if(response.statusCode == 200 && response.body["response_code"] == "booking_place_success_200"){
       _isPlacedOrderSuccessfully = true;

       updateState(PageState.complete);
       if(ResponsiveHelper.isWeb()) {
         Get.toNamed(RouteHelper.getCheckoutRoute('cart',Get.find<CheckOutController>().currentPageState.name,"null"));
       }else{

       }
       Get.find<CartController>().getCartListFromServer();
       Get.find<CartController>().clearCartList();
       customSnackBar('${response.body['message']}'.tr,isError: false,margin: 55);
       _bookingReadableId = response.body['content']['readable_id'].toString();

     }else{
       _isPlacedOrderSuccessfully = false;
       _bookingReadableId = "";
       updateState(PageState.complete);
       if(ResponsiveHelper.isWeb()) {
         Get.toNamed(RouteHelper.getCheckoutRoute('cart',Get.find<CheckOutController>().currentPageState.name,"null"));
       }else{

       }
     }
   }
   else{
     Get.offNamed(RouteHelper.getOrderSuccessRoute('fail'));
   }

   _isLoading  = false;
   update();
 }


  Future<void> getPostDetails(String postID) async {
    totalAmount = 0.0;
    postDetails = null;
    Response response = await checkoutRepo.getPostDetails(postID);
    if (response.body['response_code'] == 'default_200' ) {
      postDetails = PostDetailsContent.fromJson(response.body['content']);
      totalAmount = postDetails?.service?.tax ?? 0;
      if(postDetails?.serviceAddress != null){
        Get.find<LocationController>().updateSelectedAddress(postDetails?.serviceAddress, shouldUpdate: false);
      }
    } else {
      postDetails = PostDetailsContent();
      if(response.statusCode != 200){
        ApiChecker.checkApi(response);
      }
    }
    update();
  }



  void calculateTotalAmount(double amount){
    _isPartialPayment = false;
    totalAmount = 0.00;
    totalVat = 0.00;
    double serviceTax = postDetails?.service?.tax ?? 1;
    double extraFee = Get.find<SplashController>().configModel.content?.additionalCharge == 1 ? Get.find<SplashController>().configModel.content?.additionalChargeFeeAmount ?? 0.0 : 0.0;
    totalAmount = amount + ((amount*serviceTax)/100) + extraFee;
    totalVat = (amount*serviceTax)/100;
    _isPartialPayment = totalAmount > Get.find<CartController>().walletBalance;

  }

  void getPaymentMethodList({bool shouldUpdate = false , bool isPartialPayment = false}){


    final ConfigModel configModel = Get.find<SplashController>().configModel;
    _digitalPaymentList = [];
    _othersPaymentList = [];
    _isLoading = false;

    if(isPartialPayment && configModel.content?.partialPaymentCombinator != "all"){

      if(configModel.content?.partialPaymentCombinator == "digital_payment"){
        _othersPaymentList = [];
        if(configModel.content?.digitalPayment == 1){
          digitalPaymentList.addAll( configModel.content?.paymentMethodList ?? []);
        }
      }

      else if(configModel.content?.partialPaymentCombinator == "cash_after_service"){

        _digitalPaymentList = [];
        _othersPaymentList = [
          if(configModel.content?.cashAfterService == 1)
            PaymentMethodButton(title: "pay_after_service".tr,paymentMethodName: PaymentMethodName.cos,assetName: Images.cod,),
        ];
      }
      else if(configModel.content?.partialPaymentCombinator == "offline_payment"){
        _othersPaymentList = [];
        if(configModel.content?.offlinePayment == 1){
          digitalPaymentList.add(DigitalPaymentMethod(
            gateway: "offline",
            gatewayImage: "",
          ));
        }
      }

    }else{
      _othersPaymentList = [
        if(configModel.content?.cashAfterService == 1)
          PaymentMethodButton(title: "pay_after_service".tr,paymentMethodName: PaymentMethodName.cos,assetName: Images.cod,),

        if(configModel.content?.walletStatus == 1 && !Get.find<CartController>().walletPaymentStatus && Get.find<AuthController>().isLoggedIn())
          PaymentMethodButton(title: "pay_via_wallet".tr,paymentMethodName: PaymentMethodName.walletMoney,assetName: Images.walletMenu,),
      ];

      if(configModel.content?.digitalPayment == 1){
        digitalPaymentList.addAll( configModel.content?.paymentMethodList ?? []);
      }
      if(configModel.content?.offlinePayment == 1){
        digitalPaymentList.add(DigitalPaymentMethod(
          gateway: "offline",
          gatewayImage: "",
        ));
      }
    }
    if(shouldUpdate){
      update();
    }
  }


  void parseBookingIdFromToken(String token){

    _bookingReadableId = StringParser.parseString(utf8.decode(base64Url.decode(token)), "attribute_id");
  }

  void updateBookingPlaceStatus({bool status = true, bool shouldUpdate = false}){
    _isPlacedOrderSuccessfully = status;
    if(shouldUpdate){
      update();
    }

  }
}