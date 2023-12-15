import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class PickMapScreen extends StatefulWidget {
  final bool? fromSignUp;
  final bool? fromAddAddress;
  final bool? canRoute;
  final String? route;
  final bool formCheckout;
  final GoogleMapController? googleMapController;
  const PickMapScreen({super.key, 
    required this.fromSignUp, @required this.fromAddAddress, @required this.canRoute,
    required this.route, this.googleMapController,
    required this.formCheckout,
  });

  @override
  State<PickMapScreen> createState() => _PickMapScreenState();
}

class _PickMapScreenState extends State<PickMapScreen> {
  GoogleMapController? _mapController;
  CameraPosition? _cameraPosition;
  LatLng? _initialPosition;

  @override
  void initState() {
    super.initState();
    if(widget.fromAddAddress!) {
      Get.find<LocationController>().setPickData();
    }
    _initialPosition = LatLng(
        Get.find<SplashController>().configModel.content?.defaultLocation?.location?.lat ?? 23.777176,
        Get.find<SplashController>().configModel.content?.defaultLocation?.location?.lat ?? 90.399452,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
      body: SafeArea(child: Center(
        child: WebShadowWrap(
          child: GetBuilder<LocationController>(builder: (locationController) {
            return Stack(children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: widget.fromAddAddress! ?   LatLng(locationController.position.latitude, locationController.position.longitude) : _initialPosition!,
                  zoom: 16
                ),
                minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                onMapCreated: (GoogleMapController mapController) {
                  _mapController = mapController;
                  _mapController!.setMapStyle(
                    Get.isDarkMode ? Get.find<ThemeController>().darkMap : Get.find<ThemeController>().lightMap,
                  );
                  if(!widget.fromAddAddress!) {
                    Get.find<LocationController>().getCurrentLocation(false, mapController: mapController);
                  }
                },
                zoomControlsEnabled: false,
                onCameraMove: (CameraPosition cameraPosition) {
                  _cameraPosition = cameraPosition;
                },
                onCameraMoveStarted: () {
                  locationController.disableButton();
                },
                onCameraIdle: () {
                  try{
                    Get.find<LocationController>().updatePosition(_cameraPosition!, false, formCheckout: widget.formCheckout);
                  }catch(e){
                      if (kDebugMode) {
                        print('');
                      }
                  }
                },
              ),

              Center(child: !locationController.loading ? Image.asset(Images.marker, height: 50, width: 50)
                  : const CircularProgressIndicator()),

              Positioned(
                top: Dimensions.paddingSizeLarge, left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall,
                child: InkWell(
                  onTap: () => Get.dialog(LocationSearchDialog(mapController: _mapController!)),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                    child: Row(children: [
                      Icon(Icons.location_on, size: 25, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Expanded(
                        child: Text(
                          locationController.pickAddress,
                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge), maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Icon(Icons.search, size: 25, color: Theme.of(context).textTheme.bodyLarge!.color),
                    ]),
                  ),
                ),
              ),

              Positioned(
                bottom: 80, right: Dimensions.paddingSizeSmall,
                child: FloatingActionButton(
                  hoverColor: Colors.transparent,
                  mini: true, backgroundColor:Theme.of(context).colorScheme.primary,
                  onPressed: () => _checkPermission(() {
                    Get.find<LocationController>().getCurrentLocation(false, mapController: _mapController);
                  }),
                  child: Icon(Icons.my_location,
                      color: Colors.white.withOpacity(0.9)
                  ),
                ),
              ),

              Positioned(
                bottom: 30.0, left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall,
                child: CustomButton(
                  fontSize: Dimensions.fontSizeDefault,
                  buttonText: locationController.inZone ? widget.fromAddAddress! ? 'pick_address'.tr : 'pick_location'.tr
                      : 'service_not_available_in_this_area'.tr,
                  onPressed: (locationController.buttonDisabled || locationController.loading) ? null : () {
                    if(locationController.pickPosition.latitude != 0 && locationController.pickAddress.isNotEmpty) {
                      if(widget.fromAddAddress!) {
                        if(widget.googleMapController != null) {
                          widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                            locationController.pickPosition.latitude, locationController.pickPosition.longitude,
                          ), zoom: 16)));
                          locationController.setAddAddressData();
                        }
                        Get.back();
                      }else {
                        AddressModel address = AddressModel(
                          latitude: locationController.pickPosition.latitude.toString(),
                          longitude: locationController.pickPosition.longitude.toString(),
                          addressType: 'others', address: locationController.pickAddress,
                        );
                        locationController.saveAddressAndNavigate(address, widget.fromSignUp!, widget.route!, widget.canRoute!);
                      }
                    }else {
                      customSnackBar('pick_an_address'.tr);
                    }
                  },
                ),
              ),
            ]);
          }),
        ),
      )),
    );
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
}
