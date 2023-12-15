import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingID;
  final String phone;
  final String fromPage;

  const BookingDetailsScreen({Key? key, required this.bookingID, required this.fromPage, required this.phone})
      : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if(widget.fromPage == "track-booking"){
      Get.find<BookingDetailsController>().trackBookingDetails(widget.bookingID, "+${widget.phone.trim()}", reload: false);
    }else{
      Get.find<BookingDetailsController>().getBookingDetails(bookingId: widget.bookingID);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.fromPage == 'fromNotification') {
          Get.offAllNamed(RouteHelper.getInitialRoute());
          return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
          key: scaffoldState,
          endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
          appBar: CustomAppBar(
            title: "booking_details".tr,
            centerTitle: true,
            isBackButtonExist: true,
            onBackPressed: (){
              if(widget.fromPage == 'fromNotification'){
                Get.offAllNamed(RouteHelper.getInitialRoute());
              }else{
                Get.back();
              }
            },
          ),
          body: FooterBaseView(
            isCenter: false,
            isScrollView: ResponsiveHelper.isMobile(context) ? false : true,

            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: RefreshIndicator(
                onRefresh: () async {
                  Get.find<BookingDetailsController>().getBookingDetails(bookingId: widget.bookingID);
                },
                child: WebShadowWrap(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const BookingTabBar(),
                        if(!ResponsiveHelper.isMobile(context))
                          SizedBox(
                            height: 600,
                            child: TabBarView(
                                controller: Get.find<BookingDetailsController>().detailsTabController,
                                children: [
                                  BookingDetailsSection(bookingID: widget.bookingID),
                                  const BookingHistory(),
                                ]),
                          ),
                        if (ResponsiveHelper.isMobile(context))
                          GetBuilder<BookingDetailsController>(
                            builder: (bookingDetailsTabController){
                              return Expanded(
                                child: TabBarView(
                                    controller: Get.find<BookingDetailsController>().detailsTabController,
                                    children: [
                                      BookingDetailsSection(bookingID: widget.bookingID),
                                      const BookingHistory(),
                                    ]),
                              );
                            }
                          ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}

class BookingTabBar extends StatelessWidget {
  const BookingTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
      builder: (bookingDetailsTabsController) {
        return Container(
          height: 45,
          width: Dimensions.webMaxWidth,
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
              border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).primaryColor, width: 0.5),
              ),
            ),
            child: Center(
              child: TabBar(
                unselectedLabelColor: Colors.grey,
                indicatorColor: Theme.of(context).colorScheme.primary,
                labelColor: Get.isDarkMode
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                controller: bookingDetailsTabsController.detailsTabController,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(child: Text('booking_details'.tr),),
                  Tab(child: Text('status'.tr),),
                ],
                onTap: (int? index) {
                  switch (index) {
                    case 0:
                      bookingDetailsTabsController.updateBookingStatusTabs(
                          BookingDetailsTabs.bookingDetails);
                      break;
                    case 1:
                      bookingDetailsTabsController
                          .updateBookingStatusTabs(BookingDetailsTabs.status);
                      break;
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
