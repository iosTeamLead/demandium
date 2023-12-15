import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/booking/widget/booking_item_card.dart';
import 'package:demandium/feature/booking/widget/booking_screen_shimmer.dart';
import 'package:demandium/feature/booking/widget/booking_status_tabs.dart';

class BookingListScreen extends StatefulWidget {
  final bool isFromMenu;
  const BookingListScreen({Key? key, this.isFromMenu = false}) : super(key: key);

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  @override
  void initState() {
    Get.find<ServiceBookingController>().getAllBookingService(offset: 1,bookingStatus: "all",isFromPagination:false);
    Get.find<ServiceBookingController>().updateBookingStatusTabs(BookingStatusTabs.all, firstTimeCall: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ScrollController bookingScreenScrollController = ScrollController();

    return Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
        appBar: CustomAppBar(
            isBackButtonExist: widget.isFromMenu? true : false,
            onBackPressed: () => Get.back(),
            title: "my_bookings".tr),
        body: GetBuilder<ServiceBookingController>(
          builder: (serviceBookingController){
            List<BookingModel>? bookingList = serviceBookingController.bookingList;
            return _buildBody(
              sliversItems:serviceBookingController.bookingList != null? [
                if(ResponsiveHelper.isDesktop(context))
                  const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeExtraLarge,),),
                SliverPersistentHeader(
                  delegate: ServiceRequestSectionMenu(),
                  pinned: true,
                  floating: false,
                ),
                if(ResponsiveHelper.isDesktop(context))
                  const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeExtraLarge,),),
                if(ResponsiveHelper.isMobile(context))
                  const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeSmall,),),
                if(bookingList!.isNotEmpty)
                  SliverToBoxAdapter(
                      child: PaginatedListView(
                        scrollController:  bookingScreenScrollController,
                        totalSize: serviceBookingController.bookingContent!.total!,
                        onPaginate: (int offset) async => await serviceBookingController.getAllBookingService(
                            offset: offset,
                            bookingStatus: serviceBookingController.selectedBookingStatus.name.toLowerCase(),
                            isFromPagination: true
                        ),

                        offset: serviceBookingController.bookingContent != null ?
                        serviceBookingController.bookingContent!.currentPage:null,
                        itemView: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bookingList.length,
                          itemBuilder: (context, index) {
                            return  BookingItemCard(bookingModel: bookingList.elementAt(index),);
                          },
                        ),
                      )),
                if(bookingList.isNotEmpty)
                  const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),),
                if(bookingList.isEmpty)
                  SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(height: Get.height * 0.7,
                          child: NoDataScreen(
                              text: 'no_booking_request_available'.tr,
                              type: NoDataType.bookings
                          ),
                        ),
                      )
                  )
              ] : [
                SliverPersistentHeader(
                  delegate: ServiceRequestSectionMenu(),
                  pinned: true,
                  floating: false,
                ),
                const SliverToBoxAdapter(child: BookingScreenShimmer())],
              controller: bookingScreenScrollController,
            );
          },
        ));
  }
  Widget _buildBody({required List<Widget> sliversItems, required ScrollController controller}){
    if(ResponsiveHelper.isWeb()){
      return FooterBaseView(
        // isCenter: true,
        scrollController: controller,
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            slivers: sliversItems,
          ),
        ),
      );
    }else{
      return CustomScrollView(
        controller: controller,
        slivers: sliversItems,
      );
    }
  }
}
