import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class CartServiceWidget extends StatelessWidget {
  final CartModel cart;
  final int cartIndex;

  const CartServiceWidget({super.key, 
    required this.cart,
    required this.cartIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault,left: Dimensions.paddingSizeExtraSmall,right: Dimensions.paddingSizeExtraSmall),
      child: Container(
        height: 90.0,
        decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
        child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              Positioned(
                right: Get.find<LocalizationController>().isLtr ? 22: null,
                left: Get.find<LocalizationController>().isLtr ? null: 22,
                child: Image.asset(Images.cartDelete,width: 22.0,),),
              Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  Get.find<CartController>().removeCartFromServer(cart.id);
                  },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(color: Colors.white.withOpacity(.2)),
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow:Get.isDarkMode ? null:[
                      BoxShadow(
                        color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                        blurRadius: 5,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(RouteHelper.getServiceRoute(cart.serviceId));
                            },
                            child: SizedBox(
                              width:ResponsiveHelper.isMobile(context)? Get.width / 1.8 : Get.width / 4,
                              child: Row(
                                children: [
                                  const SizedBox(width: Dimensions.paddingSizeSmall),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                    child: CustomImage(
                                      image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/service/${cart.service!.thumbnail}',
                                      height: 65,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeSmall),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cart.service!.name!,
                                            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                                          SizedBox(
                                            width: Get.width * 0.4,
                                            child: Text(
                                              cart.variantKey,
                                              style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6), fontSize: Dimensions.fontSizeDefault),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              PriceConverter.convertPrice(cart.totalCost.toDouble()),
                                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(children: [
                            if (cart.quantity > 1)
                              QuantityButton(
                                onTap: () {
                                  Get.find<CartController>().updateCartQuantityToApi(cart.id,cart.quantity - 1);
                                  Get.find<CartController>().showMinimumAndMaximumOrderValueToaster();
                                  },
                                isIncrement: false,
                              ),
                            if (cart.quantity == 1)
                              InkWell(
                                onTap: () {
                                  Get.dialog(ConfirmationDialog(
                                      icon: Images.deleteProfile,
                                      description: 'are_you_sure_to_delete_this_service'.tr,
                                      isLogOut: true,
                                      onYesPressed: () {
                                        Get.find<CartController>().removeCartFromServer(cart.id);
                                        Get.back();
                                  }), useSafeArea: false);

                                },
                                child: Container(
                                    height: 22,
                                    width: 22,
                                    margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                    child: Image.asset(Images.cartDeleteVariation)),
                              ),
                            Text(cart.quantity.toString(), style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                            QuantityButton(
                              onTap: () {
                                Get.find<CartController>().updateCartQuantityToApi(cart.id,cart.quantity + 1);
                                Get.find<CartController>().showMinimumAndMaximumOrderValueToaster();
                              },
                              isIncrement: true,
                            ),
                          ]),
                        ),
                      ]),
                ),
              ),
        ]),
      ),
    );
  }
}
