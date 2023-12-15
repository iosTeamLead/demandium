import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class SelectAddressDialog extends StatefulWidget {
  final List<AddressModel> addressList;
  final String? selectedAddressId;
  const SelectAddressDialog({Key? key, required this.addressList, this.selectedAddressId}) : super(key: key);

  @override
  State<SelectAddressDialog> createState() => _SelectAddressDialogState();
}

class _SelectAddressDialogState extends State<SelectAddressDialog> {
  @override
  void initState() {
    super.initState();

    AddressModel? addressModel;
    int? index0;

    if(widget.addressList.isNotEmpty){
      for(int index = 0; index < widget.addressList.length ; index ++){
        if(widget.selectedAddressId == widget.addressList[index].id){
          index0 = index;
          addressModel = widget.addressList[index];
        }
      }
      if(index0 != null && addressModel != null){
        widget.addressList.removeAt(index0);
        widget.addressList.insert(0, addressModel);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){

      return SizedBox(width: Dimensions.webMaxWidth/2.3,
        child: Padding(padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge,horizontal: ResponsiveHelper.isMobile(context)? Dimensions.paddingSizeDefault : Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start, children: [

            const Row(),
            Text("please_select_an_address".tr, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge+2),),
            const SizedBox(height: Dimensions.paddingSizeSmall,),

            Text("where_you_want_to_take_the_service".tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),textAlign: TextAlign.center,),
            const SizedBox(height: Dimensions.paddingSizeLarge,),

            widget.addressList.isNotEmpty ?
            Column(children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                  Get.toNamed(RouteHelper.getEditAddressRoute(Get.find<LocationController>().getUserAddress()??Get.find<LocationController>().selectedAddress ?? AddressModel()));
                },
                child: Row(children: [
                  Icon(Icons.my_location, color: Theme.of(context).colorScheme.primary,),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  Text('use_my_current_location'.tr, style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.primary),)
                ],),
              ),

              ConstrainedBox(
                constraints: BoxConstraints( maxHeight: Get.height*0.4, minHeight: 100),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                  itemCount: widget.addressList.length,
                  itemBuilder: (context, index)  {

                    return GetBuilder<CheckOutController>(builder: (controller){
                      return AddressWidget(
                        address: widget.addressList[index],
                        fromCheckout: true, fromAddress: false,
                        onTap: (){
                          locationController.updateSelectedAddress(widget.addressList[index]);
                          Get.back();
                        },
                        selectedUserAddressId: widget.selectedAddressId,

                      );
                    });
                  },
                ),

              ),

              CustomButton(
                buttonText: "add_new_address".tr,
                icon: Icons.add_circle_outline_sharp,backgroundColor: Colors.transparent,transparent: true,
                onPressed: (){
                  Get.back();
                  Get.toNamed(RouteHelper.getAddAddressRoute(true));
                },
              ),
            ],) :
            Column(children: [
              Center(child: Image.asset(Images.emptyAddress, width: 160,)),

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge,vertical: Dimensions.paddingSizeDefault),
                child: Text("you_don't_have_any_address_yet_please_add_address".tr,
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall+1, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.4)),
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge * 1.5),
                child: CustomButton(
                  buttonText: "add_new_address".tr,
                  icon: Icons.add_circle_outline_sharp,
                  height: ResponsiveHelper.isDesktop(context) ? 45 :40,
                  radius: Dimensions.radiusDefault,
                  onPressed: (){
                    Get.back();
                    Get.toNamed(RouteHelper.getAddAddressRoute(true));
                  },
                ),
              ),

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge * 1.5),
                child: CustomButton(
                  buttonText: "use_my_current_location".tr,
                  icon: Icons.my_location,backgroundColor: Colors.transparent,transparent: true,
                  onPressed: (){
                    Get.back();
                    Get.toNamed(RouteHelper.getEditAddressRoute(Get.find<LocationController>().getUserAddress()??Get.find<LocationController>().selectedAddress??AddressModel()));
                  },
                ),
              ),

            ],),

          ]),
        ),
      );
    });
  }
}
