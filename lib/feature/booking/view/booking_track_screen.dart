import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class BookingTrackScreen extends StatefulWidget {

  const BookingTrackScreen({Key? key,}) : super(key: key);
  @override
  State<BookingTrackScreen> createState() => _BookingTrackScreenState();
}

class _BookingTrackScreenState extends State<BookingTrackScreen> {

  String countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content?.countryCode ?? "BD").dialCode!;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
      return Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,

        appBar: CustomAppBar(
          title: "track_booking".tr, centerTitle: true, isBackButtonExist: true,
          actionWidget: InkWell(
            onTap: ()=> bookingDetailsController.resetTrackingData(),
            child: Row(children: [
              Icon(Icons.refresh, color: Theme.of(context).cardColor,),
              Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: Text("reset".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).cardColor),),
              ),
            ],),
          ),
        ),

        body: FooterBaseView(
          isCenter: false, isScrollView: true,

          child: SizedBox(width: Dimensions.webMaxWidth,child: WebShadowWrap(
            child: Column(children: [
              ResponsiveHelper.isDesktop(context) ?
              Column( children: [
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge+5),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const SizedBox(),
                    Text("track_booking".tr, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),

                    InkWell(
                      onTap: (){
                        bookingDetailsController.resetTrackingData();
                      },
                      child: Row(children: [
                        Icon(Icons.refresh, color: Theme.of(context).colorScheme.primary,),
                        Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: Text("reset".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.primary),),
                        ),
                      ],),
                    )
                  ],
                  ),
                ),
                Row(children: [
                  Expanded(
                    child:  CustomTextField(
                      hintText: "booking_id".tr,
                      controller: bookingDetailsController.bookingIdController,
                      isShowBorder: true,
                      inputType: TextInputType.number,
                      prefixIcon: Images.trackService,
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault,),

                  Expanded(
                    child: CustomTextField(
                      onCountryChanged: (CountryCode countryCode) => countryDialCode = countryCode.dialCode!,
                      countryDialCode: countryDialCode,
                      hintText: "phone_number".tr,
                      controller: bookingDetailsController.phoneController,
                      isShowBorder: true,
                      inputType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault,),

                  !bookingDetailsController.isLoading ? Expanded(
                    child: CustomButton(
                      buttonText: "track_booking".tr,
                      radius: Dimensions.radiusDefault,
                      onPressed: (){

                        String phoneWithCountryCode = countryDialCode + bookingDetailsController.phoneController.text;

                        if(bookingDetailsController.bookingIdController.text.isEmpty){
                          customSnackBar("please_enter_booking_id".tr);
                        }else if(bookingDetailsController.phoneController.text.isEmpty) {
                          customSnackBar("please_enter_phone_number".tr);
                        }else{
                          bookingDetailsController.trackBookingDetails(bookingDetailsController.bookingIdController.text, phoneWithCountryCode, reload: true).then((value){
                            if(bookingDetailsController.bookingDetailsContent != null){
                              Get.toNamed(RouteHelper.getBookingDetailsScreen(bookingDetailsController.bookingIdController.text,phoneWithCountryCode ,'track-booking'));
                            }
                          });
                        }
                      },
                    ),
                  ): const Expanded(child: Center(child: CircularProgressIndicator(),)),
                ],)
              ]) :
              Padding( padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column( children: [

                  CustomTextField(
                    hintText: "booking_id".tr,
                    controller: bookingDetailsController.bookingIdController,
                    isShowBorder: true,
                    inputType: TextInputType.number,
                    prefixIcon: Images.trackService,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),

                  CustomTextField(
                    onCountryChanged: (CountryCode countryCode) => countryDialCode = countryCode.dialCode!,
                    countryDialCode: countryDialCode,
                    hintText: "phone_number".tr,
                    controller: bookingDetailsController.phoneController,
                    isShowBorder: true,
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),

                  !bookingDetailsController.isLoading ? CustomButton(
                    buttonText: "track_booking".tr,
                    radius: Dimensions.radiusDefault,
                    onPressed: () async {
                      String phoneWithCountryCode = countryDialCode + bookingDetailsController.phoneController.text;
                      if(bookingDetailsController.bookingIdController.text.isEmpty){
                        customSnackBar("please_enter_booking_id".tr);
                      }else if(bookingDetailsController.phoneController.text.isEmpty) {
                        customSnackBar("please_enter_phone_number".tr);
                      }else{
                        bookingDetailsController.trackBookingDetails(bookingDetailsController.bookingIdController.text, phoneWithCountryCode, reload: true).then((value){
                          if(bookingDetailsController.bookingDetailsContent != null){
                            Get.toNamed(RouteHelper.getBookingDetailsScreen(bookingDetailsController.bookingIdController.text,phoneWithCountryCode ,'track-booking'));
                          }
                        });
                      }
                    },
                  ): const Center(child: CircularProgressIndicator(),),

                ]),
              ),

              SizedBox(height: Get.height * 0.05,),

              bookingDetailsController.bookingDetailsContent == null && (bookingDetailsController.bookingIdController.text.isEmpty || bookingDetailsController.phoneController.text.isEmpty)
                ? NoDataScreen(text: "enter_your_service_id_phone_number_to_get_service_updates".tr, type: NoDataType.service,)
                : !bookingDetailsController.isLoading &&  bookingDetailsController.bookingDetailsContent==null && (bookingDetailsController.bookingIdController.text.isNotEmpty && bookingDetailsController.phoneController.text.isNotEmpty)
                ? NoDataScreen(text: "no_booking_found".tr): const SizedBox(),
            ])
          )),
        ),
      );
    });
  }
}

