import 'dart:convert';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/checkout/view/payment_screen.dart';
import 'package:demandium/feature/wallet/controller/wallet_controller.dart';
import 'package:universal_html/html.dart' as html;
import 'package:get/get.dart';

class PaymentMethodListWidget extends StatefulWidget {
  const PaymentMethodListWidget({Key? key}) : super(key: key);

  @override
  State<PaymentMethodListWidget> createState() => _PaymentMethodListWidgetState();
}

class _PaymentMethodListWidgetState extends State<PaymentMethodListWidget> {

  final TextEditingController inputAmountController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isTextFieldEmpty = true;


  @override
  void initState() {
    super.initState();
    Get.find<WalletController>().isTextFieldEmpty('', isUpdate: false);
    Get.find<WalletController>().changeDigitalPaymentName('', isUpdate: false);
  }


  @override
  Widget build(BuildContext context) {

    bool isRightSide = Get.find<SplashController>().configModel.content?.currencySymbolPosition == 'right';

    return GetBuilder<WalletController>(builder: (walletController){
      return SizedBox(width: Dimensions.webMaxWidth/2,
        child: Padding(padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge,horizontal: ResponsiveHelper.isMobile(context)? Dimensions.paddingSizeSmall : Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: Dimensions.paddingSizeLarge),

            Text('add_fund_to_wallet'.tr, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            Text('add_fund_form_secured_digital_payment_gateways'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              ),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
              child: Center(
                child: Row(mainAxisAlignment : MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox()),
                    if(!isRightSide)
                      Text(PriceConverter.getCurrency(),
                        style: ubuntuBold.copyWith(
                          fontSize: 20,
                          color: isTextFieldEmpty
                              ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)
                              :Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: IntrinsicWidth(
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                          keyboardType: TextInputType.number,
                          controller: inputAmountController,
                          focusNode: focusNode,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          decoration: InputDecoration(
                              border : InputBorder.none,
                              isCollapsed: true,
                              hintText: "0.0",
                              hintStyle: ubuntuBold.copyWith(
                                  fontSize: 20,
                                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)
                              )
                          ),
                          style: ubuntuBold.copyWith(fontSize: 20,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)),
                          onChanged: (String value){
                            walletController.isTextFieldEmpty(value);
                            setState(() {
                              if(value.isNotEmpty){
                                isTextFieldEmpty = false;
                              }else{
                                isTextFieldEmpty = true;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    if(isRightSide)
                      Text(PriceConverter.getCurrency(),
                        style: ubuntuBold.copyWith(
                          fontSize: 20,
                          color: isTextFieldEmpty ?
                          Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5) :
                          Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                        ),
                      ),

                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),


            const SizedBox(height: Dimensions.paddingSizeLarge),

            walletController.amountEmpty ? Row(children: [
              Text('payment_method'.tr, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),

              Expanded(child: Text('faster_and_secure_way_to_pay_bill'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))),
            ]) : const SizedBox(),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            walletController.amountEmpty ? ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height  * 0.4, minHeight: 100),
              child: ListView.builder(
                  itemCount: Get.find<SplashController>().configModel.content?.paymentMethodList?.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  itemBuilder: (context, index){
                    bool isSelected = Get.find<SplashController>().configModel.content?.paymentMethodList?[index].gateway == walletController.digitalPaymentName;
                    return InkWell(
                      onTap: (){
                        walletController.changeDigitalPaymentName(Get.find<SplashController>().configModel.content?.paymentMethodList?[index].gateway ?? "");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.transparent,
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeLarge),
                        child: Row(children: [
                          Container(
                            height: 20, width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,
                                border: Border.all(color: Theme.of(context).disabledColor)
                            ),
                            child: Icon(Icons.check, color: isSelected ? Colors.white70 : Colors.transparent, size: 16),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeDefault),

                          CustomImage(
                            height: Dimensions.paddingSizeLarge, fit: BoxFit.contain,
                            image: '${Get.find<SplashController>().configModel.content?.imageBaseUrl}/payment_modules/gateway_image/${Get.find<SplashController>().configModel.content?.paymentMethodList?[index].gatewayImage}',
                          ),

                          const SizedBox(width: Dimensions.paddingSizeSmall),

                          Text(
                            Get.find<SplashController>().configModel.content?.paymentMethodList?[index].label ?? "",
                            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                          ),
                        ]),
                      ),
                    );
                  }),
            ) : const SizedBox(),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            !walletController.isLoading ? CustomButton(
              buttonText: 'add_fund'.tr,
              onPressed: (){
                if(inputAmountController.text.isEmpty){
                  customSnackBar('please_provide_transfer_amount'.tr);
                }else if(walletController.digitalPaymentName == ''){
                  customSnackBar('please_select_payment_method'.tr);
                }else{
                  double? amount = double.tryParse(inputAmountController.text.replaceAll(PriceConverter.getCurrency(), ''));

                  if(amount != null && amount > 0){
                    Get.back();
                    _addFundToWallet(walletController.digitalPaymentName ?? "", amount );
                  }else if( amount != null && amount <= 0 ){
                    customSnackBar('amount_must_be_greater_than_zero'.tr);
                  }
                  else{
                    customSnackBar('please_enter_valid_amount'.tr);
                  }

                }
              },
            ) : const Center(child: CircularProgressIndicator()),

          ]),
        ),
      );
    });
  }

  _addFundToWallet(String paymentGateway , double amount){


    String url = '';
    String hostname = html.window.location.hostname!;
    String protocol = html.window.location.protocol;
    String port = html.window.location.port;
    String? path = html.window.location.pathname;

    String userId = Get.find<UserController>().userInfoModel.id!;


    String callbackUrl = GetPlatform.isWeb ? "$protocol//$hostname:$port$path" : AppConstants.baseUrl;

    String platform = GetPlatform.isWeb ? "web" : "app" ;


    url = '${AppConstants.baseUrl}/payment?payment_method=$paymentGateway&access_token=${base64Url.encode(utf8.encode(userId))}'
        '&callback=$callbackUrl&amount=$amount&payment_platform=$platform&is_add_fund=1';

    if (GetPlatform.isWeb) {
      printLog("url_with_digital_payment:$url");
      html.window.open(url, "_self");
    } else {
      printLog("url_with_digital_payment_mobile:$url");
      Get.to(()=> PaymentScreen(url:url, fromPage: "add-fund",));
    }
  }
}
