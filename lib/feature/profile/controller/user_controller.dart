import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

   UserInfoModel _userInfoModel = UserInfoModel();

   String fName='';
   String lName='';
   String email='';
   String phone='';
   String referCode='';
   XFile? _pickedFile ;
   bool _isLoading = false;

  UserInfoModel get userInfoModel => _userInfoModel;
  XFile? get pickedFile => _pickedFile;
  bool get isLoading => _isLoading;
  final int _year = 0;
  int get year => _year;

  final int _month = 0;
  int get month => _month;

  final int _day = 0;
  int get day => _day;
  final now = DateTime.now();
  String _createdAccountAgo ='';
  String get createdAccountAgo => _createdAccountAgo;

  String _userProfileImage = '';
  String get userProfileImage => _userProfileImage;

  Future<void> getUserInfo() async {
    _isLoading = true;
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(response.body['content']);
      _userProfileImage = _userInfoModel.image!;
      fName = _userInfoModel.fName??'';
      lName = _userInfoModel.lName??'';
      email = _userInfoModel.email??'';
      phone = _userInfoModel.phone??'';
      referCode = _userInfoModel.referCode??'';
       final difference= now.difference(DateConverter.isoUtcStringToLocalDate(response.body['content']['created_at']));
      _createdAccountAgo =  timeago.format(now.subtract(difference));
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel> changePassword(UserInfoModel updatedUserModel) async {
    _isLoading = true;
    update();
    ResponseModel responseModel;
    Response response = await userRepo.changePassword(updatedUserModel);
    if (response.statusCode == 200) {
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(response.body['message']),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void pickImage() async {
    _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    update();
  }


  Future removeUser() async {
    _isLoading = true;
    update();
    Response response = await userRepo.deleteUser();
    _isLoading = false;
    if(response.statusCode == 200){
      customSnackBar('your_account_remove_successfully'.tr);
      Get.find<AuthController>().clearSharedData();
      Get.find<CartController>().clearCartList();
      Get.find<AuthController>().googleLogout();
      Get.find<AuthController>().signOutWithFacebook();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    }else{
      Get.back();
      ApiChecker.checkApi(response);
    }
  }
}