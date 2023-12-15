import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class PaymentMethodButton extends StatelessWidget {
  final String title;
  final String assetName;
  final PaymentMethodName paymentMethodName;
  const PaymentMethodButton({Key? key, required this.title, required this.paymentMethodName, required this.assetName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<CheckOutController>(builder: (controller){
        return GestureDetector(
          onTap:(){
            if(paymentMethodName == PaymentMethodName.cos){
              controller.changePaymentMethod(cashAfterService: true);
            }else if(paymentMethodName == PaymentMethodName.walletMoney){
              controller.changePaymentMethod(walletPayment: true);
            }else{
              controller.changePaymentMethod();
            }
          },
          child: Stack(alignment: Alignment.topRight, clipBehavior: Clip.none ,children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).hoverColor,
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(controller.selectedPaymentMethod == paymentMethodName? 1.0: 0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(assetName,height: 25,width: 25,),
                  const SizedBox(width: Dimensions.paddingSizeSmall-3,),
                  Flexible(
                    child: Text(title, style: ubuntuRegular.copyWith(
                        color: controller.selectedPaymentMethod == paymentMethodName ? Theme.of(context).colorScheme.primary : null,
                        overflow: TextOverflow.ellipsis, fontSize: Dimensions.fontSizeDefault-1
                    )),
                  ),
                ],
              ),
            ),
            if(controller.selectedPaymentMethod == paymentMethodName )
              Positioned(top: -10, right:  -10 ,child: Container(
                decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor
                ),
                child: Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary,)
                ,),
              ),
          ],),
        );
      }),
    );
  }
}
