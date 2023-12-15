import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class AddAddressScreen extends StatefulWidget {
  final bool fromCheckout;
  final AddressModel? address;
  const AddAddressScreen({super.key, required this.fromCheckout, this.address});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _contactPersonNumberController = TextEditingController();
  final TextEditingController _serviceAddressController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _numberNode = FocusNode();
  final FocusNode _serviceAddressNode = FocusNode();
  final FocusNode _houseNode = FocusNode();
  final FocusNode _floorNode = FocusNode();
  final FocusNode _countryNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _zipNode = FocusNode();
  final FocusNode _streetNode = FocusNode();

  LatLng? _initialPosition;
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  final Completer<GoogleMapController> _controller = Completer();
  String  countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content?.countryCode ?? "BD").dialCode!;
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    super.initState();
    Get.find<LocationController>().resetAddress();
    if(widget.address != null) {
      setControllerData();
    }else{
      Get.find<LocationController>().updateAddressLabel(addressLabelString: 'home'.tr);

      _countryController.text = Get.find<SplashController>().configModel.content?.userLocationInfo?.countryName ?? '';
      _initialPosition = LatLng(
        Get.find<SplashController>().configModel.content?.defaultLocation?.location?.lat ?? 0.0,
        Get.find<SplashController>().configModel.content?.defaultLocation?.location?.lon ?? 0.0,
      );
    }
  }

  setControllerData() async {
    bool isValid = false;
    String phone = widget.address?.contactPersonNumber ?? "";
    try{
      isValid = await PhoneNumberUtil().validate(phone);
    }catch (_){
      isValid = false;
    }
    if(isValid){
      PhoneNumber phoneNumber = await  PhoneNumberUtil().parse(phone);
      setState(() {
        countryDialCode = "+${phoneNumber.countryCode}" ;
      });
    }else{
      setState(() {
        countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content?.countryCode ?? "BD").dialCode! ;
      });
    }
    _serviceAddressController.text = widget.address?.address??"";
    _contactPersonNameController.text = widget.address?.contactPersonName?.replaceAll("null null", "")??"";
    _contactPersonNumberController.text = widget.address?.contactPersonNumber?.replaceAll("null", "").replaceAll(countryDialCode, "").replaceAll("+", "")??"";
    _cityController.text = widget.address?.city ?? '';
    _countryController.text = widget.address?.country ?? '';
    _streetController.text = widget.address?.street ?? "";
    _zipController.text = widget.address?.zipCode ?? '';
    _houseController.text = widget.address?.house ?? '';
    _floorController.text = widget.address?.floor ?? '';

    Get.find<LocationController>().updateAddressLabel(addressLabelString: widget.address?.addressLabel??"");

    Get.find<LocationController>().setUpdateAddress(widget.address!);
    _initialPosition = LatLng(
      double.parse(widget.address?.latitude ?? '0'),
      double.parse(widget.address?.longitude ?? '0'),
    );
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.address == null ? 'add_new_address'.tr : 'update_address'.tr),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: FooterBaseView( child: Center( child: WebShadowWrap(child: SizedBox(width: Dimensions.webMaxWidth,
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeSmall),
          child: GetBuilder<LocationController>(builder: (locationController) {
            return Form(key: addressFormKey, child: Column(children: [

              if(!ResponsiveHelper.isDesktop(context))
                Column(children: [
                  _firstList(locationController),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  _secondList(locationController),
                ],),

              if(ResponsiveHelper.isDesktop(context))
                Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Expanded(child: _firstList(locationController),),
                  const SizedBox(width: Dimensions.paddingSizeLarge * 2,),
                  Expanded(
                    child: _secondList(locationController),
                  ),
                ]),
              SizedBox(height: ResponsiveHelper.isDesktop(context) ? 50 : 100,),

              ResponsiveHelper.isDesktop(context) ?
              locationController.isLoading ? const Center(child: CircularProgressIndicator(),) : CustomButton(
                radius: Dimensions.radiusDefault, fontSize: Dimensions.fontSizeLarge,
                buttonText: widget.address == null ? 'save_location'.tr : 'update_address'.tr,
                onPressed : locationController.isLoading   ? null : () => _saveAddress(locationController),
              ) : const SizedBox(),

            ]));
          }),
        ),
      )))),

      bottomSheet: !ResponsiveHelper.isDesktop(context) ? GetBuilder<LocationController>(builder: (locationController){
        return SizedBox( height: 70,
          child: locationController.isLoading ? const Center(child: CircularProgressIndicator(),) : CustomButton(
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            radius: Dimensions.radiusDefault, fontSize: Dimensions.fontSizeLarge,
            buttonText: widget.address == null ? 'save_location'.tr : 'update_address'.tr,
            onPressed : locationController.isLoading   ? null : () => _saveAddress(locationController),
          ),
        );
      }): const SizedBox(),
    );
  }

  void _saveAddress (LocationController locationController ){
    final isValid = addressFormKey.currentState!.validate();

    if(isValid ){
      addressFormKey.currentState!.save();

      AddressModel addressModel = AddressModel(
        id: widget.address != null ? widget.address!.id : null,
        addressType: locationController.selectedAddressType.name,
        addressLabel:locationController.selectedAddressLabel.name.toLowerCase(),
        contactPersonName: _contactPersonNameController.text,
        contactPersonNumber: countryDialCode + _contactPersonNumberController.text,
        address: _serviceAddressController.text,
        city: _cityController.text,
        zipCode: _zipController.value.text,
        country: _countryController.text,
        house: _houseController.text,
        floor: _floorController.text,
        latitude: locationController.position.latitude.toString(),
        longitude: locationController.position.longitude.toString(),
        zoneId: locationController.zoneID,
        street: _streetController.text,
      );

      if(widget.address == null) {
        locationController.addAddress(addressModel, true);
      }else {
        if(widget.address!.id!=null && widget.address!.id!="null"){
          locationController.updateAddress(addressModel, widget.address!.id!).then((response) {
            if(response.isSuccess!) {
              Get.back();
              customSnackBar(response.message!.tr,isError: false);
            }else {
              customSnackBar(response.message!.tr);
            }
          });
        }else{
          locationController.updateSelectedAddress(addressModel);
          Get.back();
        }
      }
    }
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      customSnackBar('you_have_to_allow'.tr);
    }else if(permission == LocationPermission.deniedForever) {
      Get.dialog(const PermissionDialog());
    }else {
      onTap();
    }
  }

  Widget _firstList(LocationController locationController) {
    return Column(children: [
      CustomTextField(
        title: 'name'.tr,
        hintText: 'contact_person_name_hint'.tr,
        inputType: TextInputType.name,
        controller: _contactPersonNameController,
        focusNode: _nameNode,
        nextFocus: _numberNode,
        capitalization: TextCapitalization.words,
        onValidate: (String? value){
          return FormValidation().isValidLength(value!);
        },
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault),

      CustomTextField(
        onCountryChanged: (CountryCode countryCode) {
          countryDialCode = countryCode.dialCode!;
          },
        countryDialCode: countryDialCode,
        title: 'phone_number'.tr,
        hintText: 'contact_person_number_hint'.tr,
        inputType: TextInputType.phone,
        inputAction: TextInputAction.done,
        focusNode: _numberNode,
        nextFocus: _serviceAddressNode,
        controller: _contactPersonNumberController,
        onValidate: (String? value){
          return FormValidation().isValidLength(value!);
        },
      ),
      const SizedBox(height: Dimensions.paddingSizeLarge * 1.2),

      Container(
        height: ResponsiveHelper.isDesktop(context) ? 250 : 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          border: Border.all(width: 0.5, color: Theme.of(context).primaryColor.withOpacity(0.5)),
        ),
        padding: const EdgeInsets.all(1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          child: Stack(clipBehavior: Clip.none, children: [
            if(_initialPosition != null)
              GoogleMap(
                minMaxZoomPreference: const MinMaxZoomPreference(0, 16),

                initialCameraPosition: CameraPosition(
                  target: _initialPosition!,
                  zoom: 14.4746,
                ),
                zoomControlsEnabled: false,
                onCameraIdle: () {
                  try{
                    locationController.updatePosition(_cameraPosition!, true, formCheckout: widget.fromCheckout);
                  }catch(error){
                    if (kDebugMode) {
                      print('error : $error');
                    }
                  }
                },
                onCameraMove: ((position) => _cameraPosition = position),
                onMapCreated: (GoogleMapController controller) {
                  locationController.setMapController(controller);
                  controller.setMapStyle(
                    Get.isDarkMode ? Get.find<ThemeController>().darkMap : Get.find<ThemeController>().lightMap,
                  );
                  _controller.complete(controller);

                  if(widget.address == null) {
                    locationController.getCurrentLocation(true, mapController: controller);
                  }
                },
                myLocationButtonEnabled: false,

              ),
            locationController.loading ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
            Center(child: !locationController.loading ? Image.asset(Images.marker, height: 40, width: 40, color: Theme.of(context).colorScheme.primary,)
                : const CircularProgressIndicator()),
            Positioned(
              bottom: 10,
              left:Get.find<LocalizationController>().isLtr ? null: Dimensions.paddingSizeSmall,
              right:Get.find<LocalizationController>().isLtr ?  0:null,
              child: InkWell(
                onTap: () => _checkPermission(() {
                  locationController.getCurrentLocation(true, mapController: locationController.mapController);
                }),
                child: Container(
                  width: 30, height: 30,
                  margin: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color:Theme.of(context).primaryColorLight.withOpacity(.5)),
                  child: Icon(Icons.my_location, color: Theme.of(context).primaryColor, size: 20),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left:Get.find<LocalizationController>().isLtr ? null: Dimensions.paddingSizeSmall,
              right:Get.find<LocalizationController>().isLtr ?  0:null,
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    RouteHelper.getPickMapRoute('add-address', false, '${widget.fromCheckout}'),
                    arguments: PickMapScreen(
                      fromAddAddress: true, fromSignUp: false, googleMapController: locationController.mapController,
                      route: null, canRoute: false, formCheckout: widget.fromCheckout,
                    ),
                  );
                },
                child: Container(
                  width: 30, height: 30,
                  margin: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      color: Theme.of(context).primaryColorLight.withOpacity(.5)),
                  child: Icon(Icons.fullscreen, color: Theme.of(context).primaryColor, size: 20),
                ),
              ),
            ),
          ]),
        ),
      ),

    ],);
  }

  Widget _secondList(LocationController locationController) {
    return Column(children: [
      const AddressLabelWidget(),
      const SizedBox(height: Dimensions.paddingSizeLarge),
      CustomTextField(
          title: 'service_address'.tr,
          hintText: 'service_address_hint'.tr,
          inputType: TextInputType.streetAddress,
          focusNode: _serviceAddressNode,
          nextFocus: _houseNode,
          controller: _serviceAddressController..text = locationController.address,
          onChanged: (text) => locationController.setPlaceMark(text),
          onValidate: (String? value){
            return FormValidation().isValidLength(value!);
          }
      ),
      const SizedBox(height: Dimensions.paddingSizeLarge),

      Row(
        children: [
          Expanded(
            child: CustomTextField(
              title: 'house'.tr,
              hintText: 'enter_house_no'.tr,
              inputType: TextInputType.streetAddress,
              focusNode: _houseNode,
              nextFocus: _floorNode,
              controller: _houseController,
              isRequired: false,
            ),
          ),

          const SizedBox(width: Dimensions.paddingSizeDefault,),

          Expanded(
            child: CustomTextField(
              title: 'floor'.tr,
              hintText: 'enter_floor_no'.tr,
              inputType: TextInputType.streetAddress,
              focusNode: _floorNode,
              nextFocus: _cityNode,
              controller: _floorController,
              isRequired: false,
            ),
          ),
        ],
      ),

      const SizedBox(height: Dimensions.paddingSizeLarge),

      Row(
        children: [
          Expanded(
            child: CustomTextField(
              title: 'city'.tr,
              hintText: 'enter_city'.tr,
              inputType: TextInputType.streetAddress,
              focusNode: _cityNode,
              nextFocus: _countryNode,
              controller: _cityController,
              isRequired: false,
            ),
          ),

          const SizedBox(width: Dimensions.paddingSizeDefault),

          Expanded(
            child: CustomTextField(
              title: 'country'.tr,
              hintText: 'enter_country'.tr,
              inputType: TextInputType.text,
              focusNode: _countryNode,
              inputAction: TextInputAction.next,
              nextFocus: _zipNode,
              controller: _countryController,
              isRequired: false,
            ),
          ),
        ],
      ),
      const SizedBox(height: Dimensions.paddingSizeLarge),
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              title: 'zip_code'.tr,
              hintText: 'enter_zip_code'.tr,
              inputType: TextInputType.text,
              focusNode: _zipNode,
              nextFocus: _streetNode,
              controller: _zipController,
              isRequired: false,
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeDefault,),
          Expanded(
            child: CustomTextField(
              title: 'street'.tr,
              hintText: 'enter_street'.tr,
              inputType: TextInputType.streetAddress,
              focusNode: _streetNode,
              nextFocus: _cityNode,
              controller: _streetController,
              isRequired: false,
            ),
          ),
        ],
      ),
    ],);
  }
}




