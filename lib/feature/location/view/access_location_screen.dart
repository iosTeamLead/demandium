import 'package:demandium/feature/web_landing/web_landing_screen.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class AccessLocationScreen extends StatefulWidget {
  final bool? fromSignUp;
  final bool? fromHome;
  final String? route;
  const AccessLocationScreen({super.key, @required this.fromSignUp, @required this.fromHome, @required this.route});

  @override
  State<AccessLocationScreen> createState() => _AccessLocationScreenState();
}

class _AccessLocationScreenState extends State<AccessLocationScreen> {
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();

    if(widget.fromHome! && Get.find<LocationController>().getUserAddress() != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.find<LocationController>().autoNavigate(
          Get.find<LocationController>().getUserAddress()!, widget.fromSignUp!, widget.route!, widget.route != null,
        );
      });
    }
    isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(isLoggedIn) {
      Get.find<LocationController>().getAddressList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: 'set_location'.tr, isBackButtonExist: false,),
      body: SafeArea(child: Center(
        child: GetBuilder<LocationController>(builder: (locationController) {
          return (ResponsiveHelper.isDesktop(context)) &&  !widget.fromHome! ? WebLandingPage(fromSignUp: widget.fromSignUp,  route: widget.route) :
          Column(
            children: [
              Expanded(
                child: FooterBaseView(
                  isCenter: (! isLoggedIn || locationController.addressList == null || locationController.addressList!.isEmpty),
                  child: SizedBox(
                    width:Dimensions.webMaxWidth,
                    child: WebShadowWrap(
                      child: isLoggedIn ? Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            locationController.addressList != null ? locationController.addressList!.isNotEmpty ?
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,

                              itemCount: locationController.addressList!.length,
                              itemBuilder: (context, index) {
                                return Center(child: SizedBox(width: 700, child: AddressWidget(
                                  address: locationController.addressList![index],
                                  fromAddress: false,
                                  onTap: () async {
                                    Get.dialog(const CustomLoader(), barrierDismissible: false);
                                    AddressModel address = locationController.addressList![index];
                                    await locationController.setAddressIndex(address,fromAddressScreen: false);
                                    locationController.saveAddressAndNavigate(address, widget.fromSignUp!, widget.route, widget.route != null);
                                  },
                                  selectedUserAddressId: locationController.getUserAddress()?.id,
                                )));
                              },
                            ):
                            NoDataScreen(text: 'no_saved_address_found'.tr,type: NoDataType.address,) :
                            const Center(child: CircularProgressIndicator()),
                            const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                            if(ResponsiveHelper.isDesktop(context))
                              BottomButton(locationController: locationController, fromSignUp: widget.fromSignUp!, route: widget.route),
                          ],
                        ),
                      ):

                      Center(child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Center(child: SizedBox(
                            width: 700,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Images.mapLocation, height: 240),
                                  const SizedBox(height: Dimensions.paddingSizeSmall),
                                  Text(
                                    'find_services_near_you'.tr,
                                    textAlign: TextAlign.center,
                                    style: ubuntuMedium.copyWith(
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                        color:Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).colorScheme.primary),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                                    child: Text(
                                      'please_select_you_location_to_start_exploring_available_services_near_you'.tr,
                                      textAlign: TextAlign.center,
                                      style: ubuntuRegular.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color:Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).colorScheme.primary
                                      ),),),
                                  const SizedBox(height: Dimensions.paddingSizeLarge),
                                  if(ResponsiveHelper.isDesktop(context))
                                    BottomButton(locationController: locationController, fromSignUp: widget.fromSignUp!, route: widget.route??''),
                                ]))),
                      )),
                    ),
                  ),
                ),
              ),
              if(!ResponsiveHelper.isDesktop(context))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: BottomButton(locationController: Get.find<LocationController>(), fromSignUp: widget.fromSignUp!, route: widget.route),
                ),
            ],
          );
        }
        ),
      ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final LocationController locationController;
  final bool fromSignUp;
  final String? route;
  const BottomButton({super.key, required this.locationController, required this.fromSignUp, required this.route});

  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(width: GetPlatform.isMobile && ResponsiveHelper.isTab(context) ? MediaQuery.of(context).size.width-40 : 700, child: Column(children: [

      CustomButton(
        buttonText: 'use_current_location'.tr,
        fontSize: Dimensions.fontSizeSmall,
        onPressed: () async {
          if(isRedundentClick(DateTime.now())){
            return;
          }
          _checkPermission(() async {
            Get.dialog(const CustomLoader(), barrierDismissible: false);
            AddressModel address = await Get.find<LocationController>().getCurrentLocation(true);
            ZoneResponseModel response = await locationController.getZone("-46.131699089448", "169.40656057595", false);

           // print("kjkjkjlk"+response.isSuccess);
            if(response.isSuccess) {

              locationController.saveAddressAndNavigate(address, fromSignUp, route != null ? route! : '', route != null);
            }else {
              Get.back();
              Get.toNamed(RouteHelper.getPickMapRoute(route == null ? RouteHelper.accessLocation : route!, route != null, 'false'), );
              customSnackBar('service_not_available_in_current_location'.tr);
            }
          });
        },
        icon: Icons.my_location,
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),

      TextButton(
        style: TextButton.styleFrom(
            minimumSize: Size(Dimensions.webMaxWidth,ResponsiveHelper.isDesktop(context)?50 :40),
            padding: EdgeInsets.zero,
            backgroundColor: Get.isDarkMode? Colors.grey.withOpacity(0.2):Theme.of(context).primaryColorLight
        ),

        onPressed: () {
          if(isRedundentClick(DateTime.now())){
            return;
          }
          Get.toNamed(RouteHelper.getPickMapRoute(
              route == null ? fromSignUp ? RouteHelper.signUp : RouteHelper.accessLocation : route!, route != null, 'false'
          ));
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeExtraSmall,left: Dimensions.paddingSizeExtraSmall),
            child: Icon(Icons.location_pin, color: Get.isDarkMode? Colors.white: Theme.of(context).primaryColor),
          ),
          Text('set_from_map'.tr, textAlign: TextAlign.center, style: ubuntuMedium.copyWith(
            color:Get.isDarkMode? Colors.white: Theme.of(context).primaryColor,
            fontSize: Dimensions.fontSizeSmall,
          )),
        ]),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),
    ])));
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied ) {
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

