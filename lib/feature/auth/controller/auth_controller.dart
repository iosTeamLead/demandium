import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:demandium/core/common_model/errrors_model.dart';
import 'package:demandium/components/core_export.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;


  bool? _isLoading = false;
  bool _acceptTerms = false;

  bool savedCookiesData = false;

  AuthController({required this.authRepo});
  bool? get isLoading => _isLoading;
  bool get acceptTerms => _acceptTerms;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var referCodeController = TextEditingController();
  var countryDialCodeForSignup= "+880";

  var signInPhoneController = TextEditingController();
  var signInPasswordController = TextEditingController();
  var countryDialCodeForSignIn= "+880";

  var contactNumberController = TextEditingController();
  var countryDialCode= "+880";
  final String _mobileNumber = '';
  String get mobileNumber => _mobileNumber;

  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    phoneController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    contactNumberController.text = '';
    newPasswordController.text = '';
    confirmNewPasswordController.text = '';
    contactNumberController.text = '';
    signInPhoneController.text =  getUserNumber();
    signInPasswordController.text = getUserPassword();
    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode!;
    countryDialCodeForSignup = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode!;
    countryDialCodeForSignIn = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode!;
  }


  fetchUserNamePassword(){
    signInPhoneController.text =  getUserNumber();
    signInPasswordController.text = getUserPassword();
  }


  Future<void> registration() async {
    SignUpBody signUpBody;
    String numberWithCountryCode = countryDialCodeForSignup + phoneController.value.text;

      _isLoading = true;
      update();

      if(referCodeController.text!=""){
        signUpBody = SignUpBody(
            fName: firstNameController.value.text.trim(),
            lName: lastNameController.value.text.trim(),
            email: emailController.value.text.trim(),
            phone: numberWithCountryCode.trim(),
            password: passwordController.value.text.trim(),
            confirmPassword: confirmPasswordController.value.text.trim(),
            referCode: referCodeController.text.trim()
        );
      }else{
        signUpBody = SignUpBody(
            fName: firstNameController.value.text.trim(),
            lName: lastNameController.value.text.trim(),
            email: emailController.value.text.trim(),
            phone: numberWithCountryCode.trim(),
            password: passwordController.value.text.trim(),
            confirmPassword: confirmPasswordController.value.text.trim(),
        );
      }
      Response? response = await authRepo.registration(signUpBody);
      if (response!.statusCode == 200 && response.body['response_code'] == 'registration_200') {
        resetControllerValue();
        if(Get.find<SplashController>().configModel.content?.phoneVerification==1 || Get.find<SplashController>().configModel.content?.emailVerification==1){
          Get.offAllNamed(RouteHelper.getSendOtpScreen("verification"));
        }else{
          Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
        }

        customSnackBar('registration_200'.tr,isError:false);
      }
      else if(response.statusCode == 404 && response.body['response_code']=="referral_code_400"){
        customSnackBar("invalid_refer_code".tr);
      }
      else {
        ErrorsModel errorResponse = ErrorsModel.fromJson(response.body);
        customSnackBar(errorResponse.errors![0].message);
      }

    _isLoading = false;
    update();
  }

  Future<void> login(String fromPage) async {
    String numberWithCountryCode = signInPhoneController.value.text;
      _isLoading = true;
      update();
      Response? response = await authRepo.login(phone: numberWithCountryCode, password: signInPasswordController.value.text);
      if (response!.statusCode == 200 && response.body['response_code']=="auth_login_200") {
        authRepo.saveUserToken(response.body['content']['token']);
        await authRepo.updateToken();
        //await _addLocalCartToApi();
        Get.find<LocationController>().getAddressList();
        _navigateLogin(fromPage);

      }else if(response.statusCode == 401 && (response.body["response_code"]=="unverified_phone_401") || response.body["response_code"]=="unverified_email_401"){
        customSnackBar(response.body['message']);
        Get.toNamed(RouteHelper.getSendOtpScreen("verification"));
      }
      else{
        customSnackBar(response.body["message"].toString().capitalizeFirst??response.statusText);
      }
      _isLoading = false;
      update();

  }

  Future<void> logOut() async {
    Response? response = await authRepo.logOut();
    if(response?.statusCode == 200){
      if (kDebugMode) {
        print("Logout successfully");
      }
    }else{
      if (kDebugMode) {
        print("Logout Failed");
      }
    }
  }

  _addLocalCartToApi() async {

    await Get.find<CartController>().getCartData();
    if(Get.find<CartController>().cartList.isNotEmpty){
      await Get.find<CartController>().addMultipleCartToServer(fromServiceCenterDialog: false);
      await Get.find<CartController>().getCartListFromServer(shouldUpdate: true);
    }
  }

  _navigateLogin(String fromPage){

    if( fromPage.contains(RouteHelper.main) || fromPage.contains(RouteHelper.splash) || fromPage.contains("booking")){
      if (Get.find<LocationController>().getUserAddress() != null) {
        if(fromPage=="booking"){
          Get.offAllNamed(RouteHelper.getMainRoute('booking'));
        }else{
          Get.offAllNamed(RouteHelper.getMainRoute('home'));
        }
      } else {
        Get.offAllNamed(RouteHelper.getAccessLocationRoute('home'));
      }
    }else{
      Get.offAllNamed(fromPage);
    }
    if (_isActiveRememberMe) {
      saveUserNumberAndPassword(signInPhoneController.value.text, signInPasswordController.value.text);
    } else {
      clearUserNumberAndPassword();
    }
    signInPhoneController.clear();
    signInPasswordController.clear();
  }



  Future<void> loginWithSocialMedia(SocialLogInBody socialLogInBody,{String? fromPage}) async {
    Get.dialog(const CustomLoader(),barrierDismissible: false);
    Response? response = await authRepo.loginWithSocialMedia(socialLogInBody);
    if (response?.statusCode == 200) {
      String token = response?.body['content']['token'];
      if(token.isNotEmpty) {
        if(response?.body['content']['is_active'] == 1) {
          authRepo.saveUserToken(response?.body['content']['token']);
          await authRepo.updateToken();
          await _addLocalCartToApi();
          Get.find<LocationController>().getAddressList();
          Get.back();
          _navigateLogin(fromPage??RouteHelper.getMainRoute("home"));
        }else{
          Get.back();
        }
      }else{
        Get.back();
      }
    } else {
      Get.back();
      customSnackBar(response?.statusText!);
    }
  }

  Future<ResponseModel> sendOtpForVerificationScreen(String identity, String identityType) async {
    _isLoading = true;
    update();
    Response  response = await authRepo.sendOtpForVerificationScreen(identity,identityType);

    if (response.statusCode == 200 && response.body["response_code"]=="default_200") {
      _isLoading = false;
      update();
      return ResponseModel(true, "");
    } else {
      _isLoading = false;
      update();
      return ResponseModel(false, response.body["message"] ?? response.statusText);
    }
  }


  Future<ResponseModel> sendOtpForForgetPassword(String identity, String identityType) async {
    _isLoading = true;
    update();
    Response response = await authRepo.sendOtpForForgetPassword(identity,identityType);

    if (response.statusCode == 200 && response.body["response_code"]=="default_200") {
      _isLoading = false;
      update();
      return ResponseModel(true, "");
    } else {
      _isLoading = false;
      update();
      return ResponseModel(false, response.body["message"] ?? response.statusText);
    }
  }


  Future<ResponseModel>  verifyOtpForVerificationScreen(String identity,  String identityType, String otp,) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.verifyOtpForVerificationScreen(identity,identityType,otp);
    ResponseModel responseModel;
    if (response!.statusCode == 200 && response.body['response_code']=="default_200") {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.body["message"] ?? response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }


  Future<ResponseModel> verifyOtpForForgetPasswordScreen(String identity, String identityType, String otp) async {
    _isLoading = true;
    update();
    Response response = await authRepo.verifyOtpForForgetPassword(identity, identityType, otp);

    if (response.statusCode==200 &&  response.body['response_code'] == 'default_200') {
      _isLoading = false;
      update();
      return ResponseModel(true, "successfully_verified");
    }else{
      _isLoading = false;
      update();
      return ResponseModel(false, response.body["message"] ?? response.statusText);
    }

  }


  Future<void> resetPassword(String identity,String identityType, String otp, String password, String confirmPassword) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.resetPassword(identity,identityType, otp, password, confirmPassword);

    if (response!.statusCode == 200 && response.body['response_code']=="default_password_reset_200") {
      Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.main));
      customSnackBar('password_changed_successfully'.tr,isError: false);
    } else {
      customSnackBar(response.statusText);
    }
    _isLoading = false;
    update();
  }



  void resetControllerValue(){
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    referCodeController.clear();
  }

  Future<void> updateZone() async {
    Response? response = await authRepo.updateZone();
    if (response!.statusCode == 200) {
      // Nothing to do
    } else {
      ApiChecker.checkApi(response);
    }
  }

  String _verificationCode = '';
  String _otp = '';
  String get otp => _otp;
  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    if(_verificationCode.isNotEmpty){
    _otp = _verificationCode;
    }
    update();
  }


  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void cancelTermsAndCondition(){
    _acceptTerms = false;
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }
  bool isNotificationActive() {
    return authRepo.isNotificationActive();

  }
  toggleNotificationSound(){
    authRepo.toggleNotificationSound(!isNotificationActive());
    update();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }


  final GoogleSignIn _googleSignIn = GoogleSignIn();


  // GoogleSignIn? _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;
  GoogleSignInAuthentication? auth;

  Future<void> socialLogin() async {
    googleAccount = (await _googleSignIn.signIn())!;
    auth = await googleAccount!.authentication;
    update();
  }



  Future<void> googleLogout() async {
    try{
      googleAccount = (await _googleSignIn.disconnect())!;
      auth = await googleAccount!.authentication;
    }catch(e){
      if (kDebugMode) {
        print("");
      }
    }
  }


  Future<void> signOutWithFacebook() async {
    await FacebookAuth.instance.logOut();
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  void initCountryCode(){
    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode!;
    countryDialCodeForSignup = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content?.countryCode??"BD").dialCode!;
    countryDialCodeForSignIn = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode!;
  }
}
