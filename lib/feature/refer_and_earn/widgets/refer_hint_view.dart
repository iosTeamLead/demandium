import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class ReferHintView extends StatelessWidget {
  final List<String> hintList;
  const ReferHintView({Key? key, required this.hintList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Dimensions.webMaxWidth,
        child: Container(

          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2), width: 2),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20),
              ),
            ),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: Dimensions.paddingSizeExtraSmall , width: 30,
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              Row(children: [
                Image.asset(Images.iMark, height: Dimensions.paddingSizeLarge,),
                const SizedBox(width: Dimensions.paddingSizeSmall,),

                Text('how_you_it_works'.tr,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyLarge!.color),
                ),

              ],),
              const SizedBox(height: Dimensions.paddingSizeSmall,),

              Column(children: hintList.map((hint) => Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.05),
                          blurRadius: 6, offset: const Offset(0, 3),
                        )]
                    ),
                    child: Text('${hintList.indexOf(hint) + 1}',style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge,)),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),

                  Flexible(
                    child: Text(hint, style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),
                    ),
                    ),
                  ),
                ],
              ),).toList(),)
            ],),
          ),
        ),
      ),
    );
  }
}
