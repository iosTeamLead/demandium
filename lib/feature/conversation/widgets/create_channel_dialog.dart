import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class CreateChannelDialog extends StatefulWidget {
  final String? referenceId;
  final String? customerID;
  final String? serviceManId;
  final String? providerId;

  const CreateChannelDialog(
      {super.key, 
        this.referenceId,
        this.customerID,
        this.serviceManId,
        this.providerId,
      });

  @override
  State<CreateChannelDialog> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<CreateChannelDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(ResponsiveHelper.isDesktop(context)) {
      return  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: pointerInterceptor(),
        elevation: 0,
        backgroundColor: Colors.transparent,
      );
    }
    return pointerInterceptor();
  }

  pointerInterceptor(){
    BookingDetailsContent bookingDetailsContent = Get.find<BookingDetailsController>().bookingDetailsContent!;
    String imageBaseUrl = Get.find<SplashController>().configModel.content!.imageBaseUrl!;
    return PointerInterceptor(
      child: Container(
        width: Dimensions.webMaxWidth,
        margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context)
            ? (Dimensions.webMaxWidth)/3:0),
        padding: const EdgeInsets.only(
            left: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(20),
            topLeft: const Radius.circular(20),
            bottomLeft: ResponsiveHelper.isDesktop(context)?const Radius.circular(20):const Radius.circular(0),
            bottomRight: ResponsiveHelper.isDesktop(context)?const Radius.circular(20):const Radius.circular(0),
          ),
        ),
        child: GetBuilder<ConversationController>(
            initState: (state){
              Get.find<ConversationController>().getChannelListBasedOnReferenceId(1,widget.referenceId!);
            },
            builder: (conversationController) {
              return SingleChildScrollView(
                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Container(
                          height: 35, width: 35, alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70.withOpacity(0.6),
                              boxShadow:Get.isDarkMode?null:[BoxShadow(
                                color: Colors.grey[300]!, blurRadius: 2, spreadRadius: 1,
                              )]
                          ),
                          child: InkWell(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.close,
                                color: Colors.black54,

                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: Dimensions.paddingSizeDefault,
                          top: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.paddingSizeDefault,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('create_channel_with_provider'.tr,style: ubuntuMedium,),
                              const SizedBox(height: Dimensions.paddingSizeLarge,),

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if(widget.providerId != null)
                                      TextButton(
                                        onPressed:(){
                                          String name = bookingDetailsContent.provider!.companyName!;
                                          String image = "$imageBaseUrl/provider/logo/${bookingDetailsContent.provider!.logo!}";
                                          String phone =bookingDetailsContent.provider?.companyPhone??"";
                                          Get.find<ConversationController>().createChannel(widget.providerId!, widget.referenceId!,name: name,image: image,fromBookingDetailsPage: true,phone: phone,userType: "provider");
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize:  const Size(Dimensions.paddingSizeLarge, 40),
                                          padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeLarge ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
                                        ),
                                        child: Text('provider'.tr, textAlign: TextAlign.center, style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),),
                                      ),
                                    const SizedBox(width: Dimensions.paddingSizeLarge),
                                    if(widget.serviceManId != null)
                                      TextButton(
                                        onPressed:(){
                                          String name = "${bookingDetailsContent.serviceman!.user!.firstName!}"
                                              " ${bookingDetailsContent.serviceman!.user!.lastName!}";
                                          String phone =bookingDetailsContent.serviceman?.user?.phone??"";
                                          String image = "$imageBaseUrl/serviceman/profile/${bookingDetailsContent.serviceman!.user!.profileImage!}";
                                          Get.find<ConversationController>().createChannel(widget.serviceManId!, widget.referenceId!,name: name,image: image,fromBookingDetailsPage: true,phone: phone);
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize:  const Size(Dimensions.paddingSizeLarge, 40),
                                          padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeLarge ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
                                        ),
                                        child: Text(
                                          'service_man'.tr, textAlign: TextAlign.center,
                                          style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                                        ),
                                      ),
                                  ]),
                              const SizedBox(height: Dimensions.paddingSizeLarge),
                            ]),
                      ),
                    ]),
              );
            }),
      ),
    );
  }
}
