import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class ServiceWidget extends StatelessWidget {
  final Service? service;
  const ServiceWidget({super.key, required this.service,});

  @override
  Widget build(BuildContext context) {
    bool desktop = ResponsiveHelper.isDesktop(context);
    bool? isAvailable;

    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getServiceRoute(service!.id!), arguments: ServiceDetailsScreen(serviceID : service!.id!));
      },
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          color: Theme.of(context).cardColor,
          boxShadow: shadow
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  child: CustomImage(
                    // image: '${Get.find<SplashController>().configModel.content!.baseUrl!.productImageUrl!}/${service!.image}',
                    image: '',
                    height: desktop ? 120 : 78, width: desktop ? 120 : 78, fit: BoxFit.cover,
                  ),
                ),
                // DiscountTag(discount: _discount, discountType: _discountType),
                NotAvailableWidget(
                  online: isAvailable,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(Dimensions.radiusSmall)),
                ),
              ]),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(children: [
                    Expanded(child: Text(
                      service!.name!,
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                      maxLines: desktop ? 2 : 1, overflow: TextOverflow.ellipsis,
                    )),
                  ]),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    service!.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: ubuntuRegular.copyWith( color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                  ),

                  const SizedBox(height: Dimensions.paddingSizeSmall,),
                  Text("12 Services",style: ubuntuRegular.copyWith(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).primaryColor),)
                ]),
              ),

            ]),
          ],
        ),
      ),
    );
  }
}
