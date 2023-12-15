import 'package:demandium/components/core_export.dart';

class BookingServiceInfoItem extends StatelessWidget {
  final BookingContentDetailsItem bookingContentDetailsItem;
  const BookingServiceInfoItem({Key? key,required this.bookingContentDetailsItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeExtraSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(bookingContentDetailsItem.service != null)
              SizedBox(
                width: 215,
                child: Text(bookingContentDetailsItem.service!.name!,
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color),
                  overflow: TextOverflow.ellipsis,),),
              Text("\$${bookingContentDetailsItem.totalCost}",
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyLarge!.color),),
            ],
          ),
          Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
          Text("${bookingContentDetailsItem.variantKey}",
            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Theme.of(context).hintColor),),
          Text("Qty :${bookingContentDetailsItem.quantity}",
            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Theme.of(context).hintColor),),
          Gaps.horizontalGapOf(Dimensions.paddingSizeSmall),
        ],
      ),
    );
  }
}