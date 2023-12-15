import 'dart:convert';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/location/model/place_details_model.dart';

enum Address {service, billing }
enum AddressLabel {home, office, others }
class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  Position _position = Position(longitude: 30.7046, latitude: 76.7179, timestamp: DateTime.now(), accuracy: 1, altitude: 1, altitudeAccuracy: 1,heading: 1, headingAccuracy: 1,speed: 1, speedAccuracy: 1);
  Position _pickPosition = Position(longitude: 28.7041, latitude: 77.1025, timestamp: DateTime.now(), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1,speed: 1, speedAccuracy: 1);
  bool _loading = false;
  String _address = '';
  String _pickAddress = '';
  final List<Marker> _markers = <Marker>[];
  List<AddressModel>? _addressList;
  final int _addressLabelIndex = 0;
  AddressModel? _selectedAddress;
  bool _isLoading = false;
  bool _inZone = false;
  String _zoneID = '';
  bool _buttonDisabled = true;
  bool _changeAddress = true;
  GoogleMapController? _mapController;
  List<PredictionModel> _predictionList = [];
  bool _updateAddAddressData = true;
  Address _selectedAddressType = Address.service;
  AddressLabel _selectedAddressLabel = AddressLabel.home;





  List<PredictionModel> get predictionList => _predictionList;
  bool get isLoading => _isLoading;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  String get address => _address;
  String get pickAddress => _pickAddress;
  List<Marker> get markers => _markers;
  List<AddressModel>? get addressList => _addressList;
  int get addressLabelIndex => _addressLabelIndex;
  bool get inZone => _inZone;
  String get zoneID => _zoneID;
  bool get buttonDisabled => _buttonDisabled;
  GoogleMapController get mapController => _mapController!;

  ///address type like home , office , others
  Address get selectedAddressType => _selectedAddressType;
  AddressLabel get selectedAddressLabel => _selectedAddressLabel;
  AddressModel? get selectedAddress => _selectedAddress;



  Future<AddressModel> getCurrentLocation(bool fromAddress, {GoogleMapController? mapController, LatLng? defaultLatLng, bool notify = true}) async {
    _loading = true;
    if(notify) {
      update();
    }
    AddressModel addressModel;
    Position myPosition;
    try {
      Geolocator.requestPermission();
      Position newLocalData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      myPosition = newLocalData;
    }catch(e) {
      if(defaultLatLng != null){
        myPosition = Position(
          latitude:defaultLatLng.latitude,
          longitude:defaultLatLng.longitude,
          timestamp: DateTime.now(), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1,headingAccuracy: 1, speed: 1, speedAccuracy: 1,
        );
      }else{
        myPosition = Position(
          latitude:  Get.find<SplashController>().configModel.content!.defaultLocation!.location!.lat ?? 0.0,
          longitude: Get.find<SplashController>().configModel.content!.defaultLocation!.location!.lon ?? 0.0,
          timestamp: DateTime.now(), accuracy: 1, altitude: 1,altitudeAccuracy: 1,  heading: 1, headingAccuracy: 1,speed: 1, speedAccuracy: 1,
        );
      }

    }
    if(fromAddress) {
      _position = myPosition;
    }else {
      _pickPosition = myPosition;
    }
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(myPosition.latitude, myPosition.longitude), zoom: 16),
      ));
    }
    String addressFromGeocode = await getAddressFromGeocode(LatLng(myPosition.latitude, myPosition.longitude));
    fromAddress ? _address = addressFromGeocode : _pickAddress = addressFromGeocode;
    ZoneResponseModel responseModel = await getZone(myPosition.latitude.toString(), myPosition.longitude.toString(), true);
    _buttonDisabled = !responseModel.isSuccess;
    addressModel = AddressModel(
      latitude: myPosition.latitude.toString(), longitude: myPosition.longitude.toString(), addressType: 'others',
      zoneId: responseModel.isSuccess ? responseModel.zoneIds : '',
      address: addressFromGeocode,
    );
    _loading = false;
    update();
    return addressModel;
  }

  Future<ZoneResponseModel> getZone(String lat, String long, bool markerLoad) async {
    _isLoading = true;
    update();
    ZoneResponseModel responseModel;
    Response response = await locationRepo.getZone(lat, long);
    if(response.statusCode == 200 && response.body['content'] != null) {
      _inZone = true;
      _zoneID = response.body['content']['id'];
      responseModel = ZoneResponseModel(true, '',_zoneID);
    }else {
      _inZone = false;
      responseModel = ZoneResponseModel(false, response.statusText.toString().tr, '');
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void updatePosition(CameraPosition position, bool fromAddress, {bool formCheckout = false}) async {
    if(_updateAddAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.latitude, longitude: position.target.longitude, timestamp: DateTime.now(),
            heading: 1, headingAccuracy: 1,accuracy: 1, altitude: 1, altitudeAccuracy: 1, speedAccuracy: 1, speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude, longitude: position.target.longitude, timestamp: DateTime.now(),
            heading: 1, headingAccuracy: 1,accuracy: 1, altitude: 1,altitudeAccuracy: 1,  speedAccuracy: 1, speed: 1,
          );
        }
        ZoneResponseModel responseModel = await getZone(position.target.latitude.toString(), position.target.longitude.toString(), true);
        if( formCheckout && !responseModel.zoneIds.contains(getUserAddress()?.zoneId??'')){
          Get.dialog(
            ConfirmationDialog(
                description: null, icon: null, onYesPressed: null,
                widget: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('this_service_not_available'.tr),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  CustomButton(buttonText: 'ok'.tr, onPressed: ()=> Get.back()),
                ],)),
          );

        }else{
          if(responseModel.isSuccess) {
            _buttonDisabled = false;
          }
        }
        if (_changeAddress) {
          String addressFromGeocode = await getAddressFromGeocode(LatLng(position.target.latitude, position.target.longitude));
          fromAddress ? _address = addressFromGeocode : _pickAddress = addressFromGeocode;
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        if (kDebugMode) {
          print('');
        }
      }
    }else {
      _updateAddAddressData = true;
    }
    _loading = false;
    update();
  }

  Future<ResponseModel> deleteUserAddressByID(AddressModel address) async {
    ResponseModel responseModel ;
    Response response = await locationRepo.removeAddressByID(address.id!);
    if (response.statusCode == 200 && response.body['response_code']=="default_delete_200") {
      //_addressList?.remove(address);
      await getAddressList();

      if(address.id == _selectedAddress?.id) {
        _selectedAddress = null;
      }
      responseModel = ResponseModel(true, response.body['message']);
    } else {
      responseModel = ResponseModel(false, response.body['message']??response.statusText);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList({bool fromCheckout = false}) async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = <AddressModel>[];
      response.body['content']['data'].forEach((address) {
        _addressList!.add(AddressModel.fromJson(address));
      });
    } else {
      ApiChecker.checkApi(response);
    }
    if(_addressList != null && _addressList!.isNotEmpty){
      for(var element in _addressList!){
        if(element.id == getUserAddress()?.id){
          _addressList?.remove(element);
          _addressList?.insert(0, element);
        }
      }
    }
   // _selectedAddress = _addressList != null && _addressList!.isEmpty ? getUserAddress() : null ;
    _isLoading = false;

    update();
  }

  // _addLocalAddress(bool saveAddress, bool fromCheckout) {
  //   final userModel = Get.find<UserController>().userInfoModel;
  //   AddressModel addressModel = AddressModel(
  //     id: getUserAddress()?.id,
  //     addressLabel: 'OTHERS',
  //     city: '',
  //     street: '',
  //     zipCode: '',
  //     addressType: 'service',
  //     country: Get.find<SplashController>().configModel.content?.country,
  //     contactPersonName: '${userModel.fName} ${userModel.lName}',
  //     contactPersonNumber: '${userModel.phone}',
  //     address: getUserAddress()?.address,
  //     latitude: getUserAddress()?.latitude,
  //     longitude: getUserAddress()?.longitude,
  //     zoneId: getUserAddress()?.zoneId,
  //     userId: getUserAddress()?.userId,
  //   );
  //
  //   if(!fromCheckout){
  //     _selectedAddress = null;
  //   }
  //   if(getUserAddress() != null){
  //     bool isAddressContain =_addressList != null ?  _addressList!.where((element) => element.address == getUserAddress()?.address).isNotEmpty:false;
  //     if(!isAddressContain){
  //       if(saveAddress){
  //        // addAddress(addressModel,false);
  //       }
  //     }
  //     //_selectedAddress = null;
  //     if(_addressList != null){
  //       for(int i = 0; i < _addressList!.length; i++){
  //         if(_addressList?[i].zoneId != '' && _addressList?[i].zoneId == getUserAddress()?.zoneId){
  //           _selectedAddress = _addressList![i];
  //           break;
  //         }
  //
  //       }
  //     }
  //
  //   }
  //   update();
  // }

  Future<void> addAddress(AddressModel addressModel, bool fromAddAddressScreen) async {
    _isLoading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    if (response.body["response_code"] == "default_store_200") {
      await getAddressList();
      if(fromAddAddressScreen){
        Get.back();
        if(addressModel.zoneId == getUserAddress()?.zoneId){
          _selectedAddress = addressModel;
          customSnackBar('new_address_added_successfully'.tr, isError: false);
        }else{
          customSnackBar('you_added_address_from_different_zone'.tr, isError: false);
        }
      }else{
        await saveUserAddress(AddressModel.fromJson(response.body["content"]));
      }
    } else {
      customSnackBar(response.statusText == 'out_of_coverage'.tr ? 'service_not_available_in_this_area'.tr : response.statusText.toString().tr, isError: false);
    }
    _isLoading = true;
    update();
  }

  Future<ResponseModel> updateAddress(AddressModel addressModel, String addressId) async {
    _isLoading = true;
    update();
    Response response = await locationRepo.updateAddress(addressModel, addressId);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      responseModel = ResponseModel(true, response.body["response_code"]);
    } else {
      responseModel = ResponseModel(false, response.statusText.toString().tr);

    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<bool> saveUserAddress(AddressModel address) async {
    String userAddress = jsonEncode(address.toJson());
    return await locationRepo.saveUserAddress(userAddress, address.zoneId);
  }
  AddressModel? getUserAddress() {
    AddressModel? addressModelUser;
    try {
      addressModelUser = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()!));
      //_selectedAddress = addressModelUser;
    }catch(e){
      return addressModelUser;
    }
    return addressModelUser;
  }


  Future<void> saveAddressAndNavigate(AddressModel address, bool fromSignUp, String? route, bool canRoute) async {
    ZoneResponseModel responseModel = await getZone("68.264543333074", "-178.18290256214", true);

    if((getUserAddress() != null && getUserAddress()!.zoneId != null)? !responseModel.zoneIds.contains(getUserAddress()!.zoneId.toString()) : true && Get.find<CartController>().cartList.isNotEmpty) {
      Get.dialog(ConfirmationDialog(
        icon: Images.warning, title: 'are_you_sure_to_reset'.tr, description: 'if_you_change_location'.tr,
        onYesPressed: () {
          Get.back();
          _setZoneData(address, fromSignUp, route, canRoute,true, responseModel.zoneIds);
        },
        onNoPressed: () {
          Get.back();
          Get.back();
        },
      ));
    }else {
      _setZoneData(address, fromSignUp, route, canRoute,false, responseModel.zoneIds);
    }
  }

  void _setZoneData(AddressModel address, bool fromSignUp, String? route, bool canRoute,bool shouldCartDelete, String? zoneIds) {
    if(zoneIds != null){
      Get.find<CartController>().clearCartList();
      address.zoneId = zoneIds;
      autoNavigate(address, fromSignUp, route, canRoute, shouldCartDelete: shouldCartDelete);
    }

  }

  void autoNavigate(AddressModel address, bool fromSignUp, String? route, bool canRoute, {bool shouldCartDelete = false}) async {
    if(!GetPlatform.isWeb){
      if(getUserAddress() != null){
        if (getUserAddress()!.zoneId != address.zoneId) {
          FirebaseMessaging.instance.unsubscribeFromTopic('zone_${getUserAddress()!.zoneId}_customer');
          FirebaseMessaging.instance.subscribeToTopic('zone_${address.zoneId}_customer');
        }
      }
      else {
        FirebaseMessaging.instance.subscribeToTopic('zone_${address.zoneId}_customer');
      }
    }
    await saveUserAddress(address);
    Get.offAllNamed(RouteHelper.getMainRoute('home'));
    if(shouldCartDelete){
      await Get.find<CartController>().removeAllCartItem();
    }
  }

  Future<AddressModel> setLocation(String placeID, String address, GoogleMapController? mapController) async {
    _loading = true;
    update();

    LatLng latLng = const LatLng(0, 0);
    Response response = await locationRepo.getPlaceDetails(placeID);
    if(response.statusCode == 200) {
      PlaceDetailsModel placeDetails = PlaceDetailsModel.fromJson(response.body);
      if(placeDetails.content!.status == 'OK') {
        latLng = LatLng(placeDetails.content!.result!.geometry!.location!.lat!, placeDetails.content!.result!.geometry!.location!.lng!);
      }
    }

    _pickPosition = Position(
      latitude: latLng.latitude, longitude: latLng.longitude,
      timestamp: DateTime.now(), accuracy: 1, altitude: 1, altitudeAccuracy: 1,heading: 1, headingAccuracy: 1,speed: 1, speedAccuracy: 1,
    );

    _pickAddress = address;
    _changeAddress = false;
    if(mapController != null){
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 17)));
    }
    _loading = false;
    update();
    AddressModel address0 = AddressModel(
      latitude: pickPosition.latitude.toString(),
      longitude: pickPosition.longitude.toString(),
      addressType: 'others', address: pickAddress,
    );
    return address0;
  }

  void disableButton() {
    _buttonDisabled = true;
    _inZone = true;
    update();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _address = _pickAddress;
    _updateAddAddressData = false;
    update();
  }

  void setUpdateAddress(AddressModel address){
    _position = Position(
      latitude: double.parse(address.latitude!), longitude: double.parse(address.longitude!), timestamp: DateTime.now(),
      altitude: 1, altitudeAccuracy: 1,heading: 1, headingAccuracy: 1,speed: 1, speedAccuracy: 1, floor: 1, accuracy: 1,
    );
    _address = address.address!;
  }

  void updateAddressType(Address address){
    _selectedAddressType = address;
    update();
  }

  void updateAddressLabel({AddressLabel? addressLabel,String addressLabelString = ''}){
    if(addressLabel == null) {
      _selectedAddressLabel = _getAddressLabel(addressLabelString);
    }else{
      _selectedAddressLabel = addressLabel;
      update();
    }
  }

  AddressLabel _getAddressLabel(String addressLabel) {
    late AddressLabel label;
    if(AddressLabel.home.name.contains(addressLabel)) {
      label = AddressLabel.home;
    }else if(AddressLabel.office.name.contains(addressLabel)){
      label = AddressLabel.office;
    }else{
      label = AddressLabel.others;
    }

    return label;
  }


  ///set address index to select address from address list
  Future<bool> setAddressIndex(AddressModel address,{bool fromAddressScreen = true}) async {
    bool isSuccess = false;
    if(fromAddressScreen){
      ZoneResponseModel selectedZone = await  getZone('${address.latitude}', '${address.longitude}', false);
      if(selectedZone.zoneIds.contains(getUserAddress()?.zoneId??"")) {
        _selectedAddress = address;

        update();
        isSuccess = true;
      }else{
        isSuccess = false;
      }
    }else{
      _selectedAddress = address;
      update();
      isSuccess = true;
    }
    return isSuccess;
  }

  void resetAddress(){
    _address = '';
  }

  void setPickData() {
    _pickPosition = _position;
    _pickAddress = _address;
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    String address = 'Unknown Location Found';
    if(response.statusCode == 200 && response.body['content']['status'] == 'OK') {
      address = response.body['content']['results'][0]['formatted_address'].toString();
    }else {
      customSnackBar(response.body['errors'][0]['message'] ?? response.bodyString.toString().tr);
    }
    return address;
  }

  Future<List<PredictionModel>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty) {
      Response response = await locationRepo.searchLocation(text);
      if (response.body['response_code'] == "default_200" && response.body['content']['status'] == 'OK') {
        _predictionList = [];
        response.body['content']['predictions'].forEach((prediction) => _predictionList.add(PredictionModel.fromJson(prediction)));
      } else {
        // customSnackBar(response.body['message'] ?? response.bodyString.toString().tr,isError:false);
      }
    }
    return _predictionList;
  }

  void setPlaceMark(String address) {
    _address = address;
  }

  void updateSelectedAddress(AddressModel? addressModel, {bool shouldUpdate = true} ) {
    _selectedAddress =  addressModel;

    if(shouldUpdate){
      update();
    }
  }

  Future<void> updatePostInformation(String postId,String addressId) async {
    Response response = await locationRepo.changePostServiceAddress(postId,addressId);

    if(response.statusCode==200 && response.body['response_code']=="default_update_200"){
      customSnackBar("service_schedule_updated_successfully".tr,isError: false);
    }
  }

}
