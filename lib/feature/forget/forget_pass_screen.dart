import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class ForgetPassScreen extends StatefulWidget {
  final bool fromVerification;
  const ForgetPassScreen({super.key,this.fromVerification = false});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {

  final TextEditingController _identityController = TextEditingController();

  String identityType ="";
  final ConfigModel _configModel = Get.find<SplashController>().configModel;

  String countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content!.countryCode!).dialCode!;
  @override
  void initState() {
    super.initState();

    if(widget.fromVerification){
      if(_configModel.content?.emailVerification==1){
        identityType = "email";
      }else{
        identityType = "phone";
      }


    } else{
      identityType = _configModel.content?.forgetPasswordVerificationMethod??"";
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: widget.fromVerification && Get.find<SplashController>().configModel.content?.phoneVerification==1 ?
      'phone_verification'.tr : widget.fromVerification && Get.find<SplashController>().configModel.content?.emailVerification==1 ?
      "email_verification".tr : 'forgot_password'.tr.replaceAll("?", " "),
        onBackPressed: (){
        if(Navigator.canPop(context)){
          Get.back();
        }else{
          Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
        }
        },
      ),

      body: SafeArea(
        child: GetBuilder<AuthController>(
          builder: (authController){
            return FooterBaseView(
              isCenter: true,
              child: WebShadowWrap(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.isDesktop(context)?Dimensions.webMaxWidth/6:
                      ResponsiveHelper.isTab(context)? Dimensions.webMaxWidth/8:0
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Image.asset(Images.forgotPass, width: 100, height: 100,),

                      if(widget.fromVerification)
                      Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                        child: Center(child: Text('${"verify_your".tr} ${identityType=="email"?"email_address".tr.toLowerCase():"phone_number".tr.toLowerCase()}',
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.9)),textAlign: TextAlign.center,
                        )),
                      ),

                       Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge*1.5),
                         child: Center(child: Text('${"please_enter_your".tr} ${identityType=="email"?"email_address".tr.toLowerCase():"phone_number".tr.toLowerCase()} ${"to_receive_a_verification_code".tr}',
                           style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.7)),textAlign: TextAlign.center,
                         )),
                       ),

                      (identityType=="phone")?
                       Row(children: [
                          CountryCodePicker(
                            onChanged:  (CountryCode countryCode) => countryDialCode = countryCode.dialCode!,
                            showDropDownButton: true,
                            padding: EdgeInsets.zero,
                            showFlagMain: true,
                            initialSelection: countryDialCode,
                            dialogBackgroundColor: Theme.of(context).cardColor,
                            barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
                            textStyle: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              hintText: 'enter_phone_number'.tr,
                              controller: _identityController,
                              inputType: TextInputType.phone,
                              inputAction: TextInputAction.done,
                              isShowBorder: true,

                            ),
                          ),
                        ],
                      ): Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CustomTextField(
                            title: 'email_address'.tr,
                           hintText: 'enter_email_address'.tr,
                           controller: _identityController,
                           inputType: TextInputType.emailAddress,
                         ),
                      ),

                      const SizedBox(height: Dimensions.paddingSizeLarge*1.5),
                      GetBuilder<AuthController>(builder: (authController) {
                          return !authController.isLoading! ? CustomButton(
                            buttonText: 'send_otp'.tr,
                            fontSize: Dimensions.fontSizeDefault,
                            onPressed: ()=>_forgetPass(countryDialCode,authController),
                          ) : const Center(child: CircularProgressIndicator());
                        }),
                     const SizedBox(height: Dimensions.paddingSizeLarge*4),
                      ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _forgetPass(String countryDialCode,AuthController authController) async {

    String phone = countryDialCode + _identityController.text.trim();
    String email = _identityController.text.trim();
    String identity = identityType=="phone"?phone:email;

    if (_identityController.text.isEmpty) {
      if(identityType=="phone"){
        customSnackBar('enter_phone_number'.tr);
      }else{
        customSnackBar('enter_email_address'.tr);
      }
    }else {
      if(widget.fromVerification){
        authController.sendOtpForVerificationScreen(identity,identityType).then((status) {
          if(status.isSuccess!){
            Get.toNamed(RouteHelper.getVerificationRoute(identity,identityType,"verification"));
          }else{
            customSnackBar(status.message.toString().capitalizeFirst);
          }
        });
      }else{
        authController.sendOtpForForgetPassword(identity,identityType).then((status){
          if(status.isSuccess!){
            Get.toNamed(RouteHelper.getVerificationRoute(identity,identityType,"forget-password"));
          }else{
            customSnackBar(status.message.toString().capitalizeFirst);
          }
        });
      }}
  }
}

