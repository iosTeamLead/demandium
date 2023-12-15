import 'package:demandium/components/core_export.dart';

class DigitalPayment extends StatelessWidget {
  final String paymentGateway;
  final bool redirectDirectlyPaymentScreen;

  const DigitalPayment({Key? key, required this.paymentGateway,
    this.redirectDirectlyPaymentScreen = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeSmall),
          child: Image.asset( Images.address, fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
