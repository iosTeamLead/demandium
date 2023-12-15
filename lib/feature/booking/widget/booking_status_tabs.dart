import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class ServiceRequestSectionMenu extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).cardColor,
      width: Dimensions.webMaxWidth,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: ListView.builder(
          itemCount: BookingStatusTabs.values.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return GetBuilder<ServiceBookingController>(builder: (controller){
              return InkWell(
                child: BookingStatusTabItem(
                    title: BookingStatusTabs.values.elementAt(index).name,
                ),
                onTap: (){
                  controller.updateBookingStatusTabs(BookingStatusTabs.values.elementAt(index));
                },
              );
            });
          }),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}