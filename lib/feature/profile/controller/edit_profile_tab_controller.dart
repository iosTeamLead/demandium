import 'package:country_code_picker/country_code_picker.dart';
import 'package:demandium/core/helper/image_size_checker.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

enum EditProfileTabControllerState {generalInfo,accountIno}

class EditProfileTabController extends GetxController with GetSingleTickerProviderStateMixin implements GetxService{

  final UserRepo userRepo;
  EditProfileTabController({required this.userRepo});

  bool _isLoading = false;
  get isLoading => _isLoading;

  XFile? _pickedProfileImageFile ;
  XFile? get pickedProfileImageFile => _pickedProfileImageFile;




  List<Widget> editProfileDetailsTabs =[
    Tab(text: 'general_info'.tr),
    Tab(text: 'account_information'.tr),
  ];

  TabController? controller;
  var editProfilePageCurrentState = EditProfileTabControllerState.generalInfo;

  void updateEditProfilePage(EditProfileTabControllerState editProfileTabControllerState,index){
    editProfilePageCurrentState = editProfileTabControllerState;
    controller!.animateTo(index);
    update();
  }

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var countryDialCode = "+880";
  UserInfoModel _userInfoModel=UserInfoModel();
  UserInfoModel get userInfoModel => _userInfoModel;


  @override
  void onInit() {
    super.onInit();

    controller = TabController(vsync: this, length: editProfileDetailsTabs.length);


    controller!.addListener(() {
     if( controller!.index==1){
       passwordController.text = '';
       confirmPasswordController.text = '';
       update();
     }
    });
  }

  void setValue(){
    _userInfoModel = Get.find<UserController>().userInfoModel;
    firstNameController.text = Get.find<UserController>().userInfoModel.fName??'';
    lastNameController.text = Get.find<UserController>().userInfoModel.lName??'';
    emailController.text = Get.find<UserController>().userInfoModel.email??'';
    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content != null ? Get.find<SplashController>().configModel.content!.countryCode!:"BD").dialCode!;
    phoneController.text = _userInfoModel.phone != null ? Get.find<UserController>().userInfoModel.phone!.replaceAll(countryDialCode, ''):'';
    passwordController.text = '';
    confirmPasswordController.text = '';

  }

  Future<void> updateUserProfile() async {
    if(_userInfoModel.fName!=firstNameController.text ||
        _userInfoModel.lName!=lastNameController.text ||
        _pickedProfileImageFile!=null ||
        _userInfoModel.phone!=phoneController.value.text
    ){
      UserInfoModel userInfoModel = UserInfoModel(
          fName: firstNameController.value.text,
          lName: lastNameController.value.text,
          email: emailController.value.text,
          phone: phoneController.value.text);

      _isLoading = true;
      update();
      Response response = await userRepo.updateProfile(userInfoModel, pickedProfileImageFile);

      if (response.body['response_code'] == 'default_update_200') {
        Get.back();
        customSnackBar('${response.body['response_code']}'.tr, isError: false);
        _isLoading = false;
      }else{
        customSnackBar('${response.body['errors'][0]['message']}'.tr, isError: true);
        _isLoading = false;
      }
      update();
      Get.find<UserController>().getUserInfo();
    }else{
      customSnackBar('change_something_to_update'.tr,isError: false);
    }
  }

  Future<void> updateAccountInfo() async {

    UserInfoModel userInfoModel = UserInfoModel(
        fName: firstNameController.value.text,
        lName: lastNameController.value.text,
        email: emailController.value.text,
        phone: phoneController.value.text,
        password: passwordController.value.text,
        confirmPassword: confirmPasswordController.value.text
    );

    _isLoading = true;
    update();
    Response response = await userRepo.updateAccountInfo(userInfoModel);
    if (response.body['response_code'] == 'default_update_200') {
      Get.back();
      customSnackBar('password_updated_successfully'.tr,isError: false);

    }else{
      customSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }


  void pickProfileImage() async {
    _pickedProfileImageFile = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 100);
    double imageSize = await ImageSize.getImageSize(_pickedProfileImageFile!);
    if(imageSize >AppConstants.limitOfPickedImageSizeInMB){
      customSnackBar("image_size_greater_than".tr);
      _pickedProfileImageFile =null;
    }
    update();
  }

  Future<void> removeProfileImage() async {
    _pickedProfileImageFile = null;
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }

  validatePassword(String value){
    if(value.length < 8){
      return 'password_should_be'.tr;
    }else if(passwordController.text != confirmPasswordController.text && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
      return 'confirm_password_does_not_matched'.tr;
    }
  }

  void resetPasswordText(){
    passwordController.text = '';
    confirmPasswordController.text = '';
    update();
  }
}