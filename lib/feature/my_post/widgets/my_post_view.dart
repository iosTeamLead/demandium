import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/create_post/model/my_post_model.dart';
import 'package:get/get.dart';

class MyPostView extends StatelessWidget {
  final MyPostData? postData;
  const MyPostView({Key? key, this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String status = "null";
    String bookingStatus = "null";

    if(postData!.booking!=null && postData!.booking!.bookingStatus != null){
      bookingStatus = postData!.booking!.bookingStatus!;
    }

    if( postData!.isBooked==0 && postData!.bidsCount! >0 ){
      status = "bid_available";
    } else if(postData!.isBooked==0 && postData!.bidsCount == 0){
      status = "no_bid";
    } else if(postData!.isBooked==1){
      status = "bid_accepted";
    }

    return Padding(padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,),
      child: GestureDetector(
        onTap: (){
          if(status == "bid_available"){
            Get.toNamed(RouteHelper.getProviderOfferListScreen(postData?.id??"",status,postData!));
          }else if(status == "bid_accepted" && postData!.booking!=null){
            Get.toNamed(RouteHelper.getBookingDetailsScreen(postData!.booking!.id??"","","others"));
          }else if( status == "no_bid"){
            Get.toNamed(RouteHelper.getProviderOfferListScreen(postData?.id??"",status,postData!));
          }
        },
        child: Container(decoration: BoxDecoration(
          border: Border.all(
            color: status =="bid_available"? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                 : status == "no_bid"?Theme.of(context).colorScheme.error.withOpacity(0.2)
                 : Colors.green.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),

          child: Stack( alignment: Get.find<LocalizationController>().isLtr?Alignment.bottomRight :Alignment.bottomLeft ,children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center, children: [
              if(postData!.booking!=null)
              Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                child: Text('${'booking'.tr}# ${postData?.booking?.readableId??""}', style: ubuntuMedium.copyWith(
                  fontSize:  Dimensions.fontSizeLarge
                )),
              ),

              Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    child: CustomImage(height: 65, width: 65, fit: BoxFit.cover,
                        image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/service/${postData?.service?.thumbnail}")),

                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text(postData?.service?.name??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                      maxLines: 1, overflow: TextOverflow.ellipsis),


                  Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeEight),
                    child: Text(postData?.subCategory?.name??"",style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5)),),
                  ),

                  Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeEight),
                    child: Text(status=="no_bid"? "no_provider_bid_for_post".tr
                          : status == "bid_available"? "${postData?.bidsCount??""} ${'provider_are_interested'.tr}"
                          : postData?.booking?.bookingStatus.toString().tr??"",
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                        color:
                        bookingStatus=="ongoing" ? Theme.of(context).colorScheme.primary:
                        bookingStatus=="pending" ? Theme.of(context).colorScheme.primary.withOpacity(.2):
                        bookingStatus=="accepted" ? Theme.of(context).colorScheme.primary:
                        bookingStatus=="completed" ? Colors.green :
                        Theme.of(context).colorScheme.error),
                    ),
                  ),
                ],)
              ],),
            ]),
            if(status == "bid_available")
            Stack(clipBehavior: Clip.none,children: [
              Image.asset(Images.personIcon,height: 30,width: 30,),
              Positioned(
                top: -9,
                right: -9,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 3),
                  height: 17, width: 17,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.error
                  ),
                  child: FittedBox(
                      child: Text(
                        postData!.bidsCount.toString(),
                        style: ubuntuRegular.copyWith(color: light.cardColor
                        ),
                      )
                  ),
                ),
              )

            ]),
          ]),
        ),
      )
    );
  }
}
