import 'dart:convert';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/checkout/view/payment_screen.dart';
import 'package:demandium/feature/checkout/widget/custom_post/cart_summary.dart';
import 'package:demandium/feature/checkout/widget/custom_post/custom_post_service_info.dart';
import 'package:demandium/feature/checkout/widget/custom_post/expansion_tile.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/wallet_payment_card.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:universal_html/html.dart' as html;

class CustomPostCheckoutScreen extends StatefulWidget {
  final String postId;
  final String providerId;
  final String amount;
  const CustomPostCheckoutScreen({Key? key, required this.postId, required this.providerId, required this.amount}) : super(key: key);

  @override
  State<CustomPostCheckoutScreen> createState() => _CustomPostCheckoutScreenState();
}

class _CustomPostCheckoutScreenState extends State<CustomPostCheckoutScreen> {

  ConfigModel configModel = Get.find<SplashController>().configModel;
  final tooltipController = JustTheController();

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ScheduleController(scheduleRepo: ScheduleRepo(apiClient: Get.find())));
    Get.find<CheckOutController>().getPostDetails(widget.postId);
    Get.find<ScheduleController>().setPostId(widget.postId);
    Get.find<CheckOutController>().changePaymentMethod(shouldUpdate: false);
    Get.find<AuthController>().cancelTermsAndCondition();
    Get.find<CartController>().updateWalletPaymentStatus(false, shouldUpdate: false);
    Get.find<CheckOutController>().getPaymentMethodList();
    Get.find<SplashController>().getOfflinePaymentMethod(true);
  }
  
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()  => _exitApp(),
      child: Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer() : null,
        appBar: CustomAppBar(title: 'checkout'.tr,

          onBackPressed: (){
              if(Navigator.canPop(context)){
                Get.back();
              }else{
                Get.toNamed(RouteHelper.getMainRoute("home"));
              }
          },
        ),
        body: GetBuilder<CartController>(builder: (cartController){
          return GetBuilder<CheckOutController>(builder: (checkoutController){

            if(checkoutController.postDetails != null){
              Get.find<ScheduleController>().updateSelectedDate(checkoutController.postDetails?.bookingSchedule);
             // Get.find<LocationController>().updateSelectedAddress(checkoutController.postDetails?.serviceAddress, shouldUpdate: false);
              Get.find<CheckOutController>().calculateTotalAmount(double.tryParse(widget.amount.toString()) ?? 0 );
              return FooterBaseView(
                  isCenter: true,
                  child: WebShadowWrap(
                    child: Column(children:  [

                      CustomPostServiceInfo(postDetails: checkoutController.postDetails,),
                      DescriptionExpansionTile(
                        title: "description",
                        subTitle: checkoutController.postDetails?.serviceDescription??"",
                      ),

                      (checkoutController.postDetails != null && checkoutController.postDetails!.additionInstructions!.isNotEmpty) ?
                      DescriptionExpansionTile(
                        title: "additional_instruction",
                        additionalInstruction: checkoutController.postDetails!.additionInstructions,
                      ) : const SizedBox() ,

                      const ServiceSchedule(),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: AddressInformation(),
                      ),

                      CartSummary(postDetails: checkoutController.postDetails, amount: widget.amount,),

                      (Get.find<AuthController>().isLoggedIn() && Get.find<CartController>().walletBalance > 0 && configModel.content?.walletStatus == 1 && configModel.content?.partialPayment == 1) ?
                      const WalletPaymentCard(fromPage: "custom-checkout",) : const SizedBox(),

                      ( cartController.walletPaymentStatus && !checkoutController.isPartialPayment ) ? const SizedBox() :
                      PaymentPage(addressId: '', tooltipController: JustTheController(), fromPage: "custom-checkout",),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: ResponsiveHelper.isDesktop(context)?15:0),
                        child: const ConditionCheckBox(),
                      ),
                      if(ResponsiveHelper.isDesktop(context))
                        GetBuilder<CartController>(builder: (cartController){

                          bool isPartialPayment = checkoutController.totalAmount > cartController.walletBalance;
                          double totalAmount = checkoutController.totalAmount;
                          double dueAmount = totalAmount - (isPartialPayment ? cartController.walletBalance : 0 );

                          return SizedBox(height: 90,
                            child: Column(
                              children: [
                                Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[
                                    Text('${ cartController.walletPaymentStatus && isPartialPayment ? "due_amount".tr : "total_price".tr} ',
                                      style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeLarge,
                                        color: Theme.of(context).textTheme.bodyLarge!.color,
                                      ),
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text(PriceConverter.convertPrice( cartController.walletPaymentStatus && isPartialPayment ? dueAmount : totalAmount,isShowLongPrice: true),
                                        style: ubuntuBold.copyWith(
                                          color: Theme.of(context).colorScheme.error,
                                          fontSize: Dimensions.fontSizeLarge,
                                        ),
                                      ),
                                    )]),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      _makePayment(checkoutController, cartController);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'proceed_to_checkout'.tr,
                                          style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      SizedBox(height: ResponsiveHelper.isDesktop(context)? 70: 110,)
                    ],),
                  )
              );
            }else{
              return const FooterBaseView(
                  isCenter: true,
                  child: Center(child: CircularProgressIndicator())
              );
            }
          });
        }),

        bottomSheet: GetBuilder<CheckOutController>(builder: (checkoutController){
          return !ResponsiveHelper.isDesktop(context) && checkoutController.postDetails != null?
          GetBuilder<CartController>(builder: (cartController){

            bool isPartialPayment = checkoutController.totalAmount > cartController.walletBalance;
            double totalAmount = checkoutController.totalAmount;
            double dueAmount = totalAmount - (isPartialPayment ? cartController.walletBalance : 0 );

            return SizedBox(height: 90,
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[
                    Text('${ cartController.walletPaymentStatus && isPartialPayment ? "due_amount".tr : "total_price".tr} ',
                        style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(PriceConverter.convertPrice( cartController.walletPaymentStatus && isPartialPayment ? dueAmount : totalAmount,isShowLongPrice: true),
                          style: ubuntuBold.copyWith(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                      )]),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        _makePayment(checkoutController, cartController);
                      },
                      child: Container(
                        color: Theme.of(context).colorScheme.primary,
                        child: Center(
                          child: Text(
                            'proceed_to_checkout'.tr,
                            style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }): const SizedBox();
        }),
      ),
    );
  }

  void _makePayment(CheckOutController checkoutController, CartController cartController) async {

    AddressModel? addressModel = Get.find<LocationController>().selectedAddress ?? Get.find<LocationController>().getUserAddress();
    bool isPartialPayment = Get.find<CheckOutController>().totalAmount >  Get.find<CartController>().walletBalance;

   if(Get.find<AuthController>().acceptTerms){

     if((addressModel?.contactPersonName == "null" || addressModel?.contactPersonName == null || addressModel!.contactPersonName!.isEmpty) || (addressModel.contactPersonNumber=="null" || addressModel.contactPersonNumber == null || addressModel.contactPersonNumber!.isEmpty)){
        customSnackBar("please_input_contact_person_name_and_phone_number".tr);
      }
      else if( !isPartialPayment && cartController.walletPaymentStatus){

        Get.dialog(const CustomLoader(), barrierDismissible: false,);
        Response response = await Get.find<CreatePostController>().makePayment(
            postId : widget.postId,
            providerId : widget.providerId,
            paymentMethod : "wallet_payment",
            isPartial: 0
        );
        Get.back();

        if(response.statusCode == 200 && response.body['response_code']=="booking_place_success_200") {
          Get.offNamed(RouteHelper.getOrderSuccessRoute('success'));
        }else{
          customSnackBar(response.body['message'].toString().capitalizeFirst??response.statusText);
        }
      }
      else if(checkoutController.selectedPaymentMethod == PaymentMethodName.none){
        customSnackBar("select_payment_method".tr);
      }

      else if(checkoutController.selectedPaymentMethod == PaymentMethodName.cos) {

        Get.dialog(const CustomLoader(), barrierDismissible: false,);
        Response response = await Get.find<CreatePostController>().updatePostStatus(
            widget.postId,widget.providerId, 'accept',
            isPartial: isPartialPayment && cartController.walletPaymentStatus ? 1 : 0,
            serviceAddressId: (addressModel.id == "null") || (addressModel.id == null) ? "": addressModel.id,
            serviceAddress: jsonEncode(addressModel),
        );
        Get.back();
        if(response.statusCode == 200 && response.body['response_code'] == "default_update_200") {
          Get.offNamed(RouteHelper.getOrderSuccessRoute('success'));
        }else{
          Get.offNamed(RouteHelper.getOrderSuccessRoute('failed'));
        }
      }
      else if(checkoutController.selectedPaymentMethod == PaymentMethodName.walletMoney){

        Get.dialog(const CustomLoader(), barrierDismissible: false,);
        Response response = await Get.find<CreatePostController>().makePayment(
          postId : widget.postId,
          providerId : widget.providerId,
          paymentMethod : "wallet_payment",
          isPartial: 0
        );
        Get.back();

        if(response.statusCode == 200 && response.body['response_code']=="booking_place_success_200") {
          Get.offNamed(RouteHelper.getOrderSuccessRoute('success'));
        }else{
          customSnackBar(response.body['message'].toString().capitalizeFirst??response.statusText);
        }

      }
      else if(checkoutController.selectedPaymentMethod == PaymentMethodName.offline){

        if(checkoutController.selectedOfflineMethod != null && checkoutController.showOfflinePaymentInputData){

          Get.dialog(const CustomLoader(), barrierDismissible: false,);
          Response response = await Get.find<CreatePostController>().makePayment(
            postId : widget.postId,
            providerId : widget.providerId,
            paymentMethod: "offline_payment",
            offlinePaymentId: checkoutController.selectedOfflineMethod?.id,
            isPartial:  isPartialPayment && cartController.walletPaymentStatus ? 1 : 0,
            customerInfo : base64Url.encode(utf8.encode(jsonEncode(checkoutController.offlinePaymentInputFieldValues))),
          );

          Get.back();

          if(response.statusCode == 200 && response.body['response_code']=="booking_place_success_200") {
            Get.offNamed(RouteHelper.getOrderSuccessRoute('success'));
          }else{
            customSnackBar(response.body['message'].toString().capitalizeFirst??response.statusText);
          }

        }
        else{
          customSnackBar("provide_offline_payment_info".tr);
        }

      }
      else  if( checkoutController.selectedPaymentMethod == PaymentMethodName.digitalPayment){
        if(checkoutController.selectedDigitalPaymentMethod == null && checkoutController.selectedDigitalPaymentMethod?.gateway == "offline" ){
          customSnackBar('select_any_payment_method'.tr);
        }
        else{

          String url = '';
          String hostname = html.window.location.hostname!;
          String protocol = html.window.location.protocol;
          String port = html.window.location.port;
          String? path = html.window.location.pathname?.replaceAll(RouteHelper.customPostCheckout, "");
          String schedule = DateConverter.dateToDateOnly(Get.find<ScheduleController>().selectedData);
          String userId = Get.find<UserController>().userInfoModel.id?? Get.find<SplashController>().getGuestId();
          String encodedAddress = base64Encode(utf8.encode(jsonEncode(addressModel.toJson())));
          String addressId = (addressModel.id == "null" || addressModel.id == null) ? "" : addressModel.id ?? "";
          String  zoneId = Get.find<LocationController>().getUserAddress()?.zoneId??"";
          String callbackUrl = GetPlatform.isWeb ? "$protocol//$hostname:$port$path${RouteHelper.orderSuccess}" : AppConstants.baseUrl;
          int isPartial = cartController.walletPaymentStatus && isPartialPayment ? 1 : 0;
          String platform = ResponsiveHelper.isWeb() ? "web" : "app" ;

          url = '${AppConstants.baseUrl}/payment?payment_method=${checkoutController.selectedDigitalPaymentMethod?.gateway}&access_token=${base64Url.encode(utf8.encode(userId))}&zone_id=$zoneId'
              '&callback=$callbackUrl&payment_platform=$platform&service_address=$encodedAddress&service_address_id=$addressId&is_partial=$isPartial&service_schedule=$schedule&post_id=${widget.postId}&provider_id=${widget.providerId}';

          if (GetPlatform.isWeb) {
            printLog("url_with_digital_payment:$url");
            html.window.open(url, "_self");
          } else {
            printLog("url_with_digital_payment_mobile:$url");
            Get.to(()=> PaymentScreen(url:url, fromPage: "custom-checkout",));
          }
        }
      }
    }else{
      customSnackBar('please_agree_with_terms_conditions'.tr);
    }
  }


  Future<bool> _exitApp() async {
    Get.toNamed(RouteHelper.getMainRoute('home'));
    return true;
  }
}
