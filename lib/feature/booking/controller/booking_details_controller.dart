import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';
import 'package:demandium/feature/booking/model/invoice.dart';


enum BookingDetailsTabs {bookingDetails, status}
class BookingDetailsController extends GetxController with GetSingleTickerProviderStateMixin {
  BookingDetailsRepo bookingDetailsRepo;
  BookingDetailsController({required this.bookingDetailsRepo});

  BookingDetailsTabs _selectedDetailsTabs = BookingDetailsTabs.bookingDetails;
  BookingDetailsTabs get selectedBookingStatus =>_selectedDetailsTabs;
  TabController? detailsTabController;

  final bookingIdController = TextEditingController();
  final phoneController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isCancelling = false;
  bool get isCancelling => _isCancelling;
  BookingDetailsContent? _bookingDetailsContent;
  BookingDetailsContent? get bookingDetailsContent => _bookingDetailsContent;
  List<InvoiceItem> _invoiceItems =[];
  List<InvoiceItem> get invoiceItems => _invoiceItems;

  List<double> _unitTotalCost =[];
  double _allTotalCost = 0;

  List<double> get unitTotalCost => _unitTotalCost;
  double get allTotalCost => _allTotalCost;

  void updateBookingStatusTabs(BookingDetailsTabs bookingDetailsTabs){
    _selectedDetailsTabs = bookingDetailsTabs;
    update();
  }

  @override
   void onInit(){
    super.onInit();
    detailsTabController = TabController(length: BookingDetailsTabs.values.length, vsync: this);
  }

  Future<void> bookingCancel({required String bookingId})async{
    _isCancelling = true;
    update();
    Response? response = await bookingDetailsRepo.bookingCancel(bookingID: bookingId);
    if(response.statusCode == 200){
      _isCancelling = false;
      customSnackBar('booking_cancelled_successfully'.tr, isError: false);
      await getBookingDetails(bookingId: bookingId);
    }else{
      _isCancelling = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getBookingDetails({required String bookingId})async{
    _bookingDetailsContent = null;
    Response response = await bookingDetailsRepo.getBookingDetails(bookingID: bookingId);
    if(response.statusCode == 200){
      _bookingDetailsContent = BookingDetailsContent.fromJson(response.body['content']);

      if(_bookingDetailsContent!.detail != null ){
        setBookingDetailsData(_bookingDetailsContent!);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }


  Future<void> trackBookingDetails(String bookingReadableId, String phone, {bool reload = false}) async {
    if(reload){
      _isLoading = true;
      update();
    }
    if( reload || _bookingDetailsContent == null){

      Response response = await bookingDetailsRepo.trackBookingDetails(bookingID: bookingReadableId, phoneNUmber: phone);
      if(response.statusCode == 200){
        _bookingDetailsContent = BookingDetailsContent.fromJson(response.body['content']);
        if(_bookingDetailsContent != null){
          setBookingDetailsData(_bookingDetailsContent!);
        }
      }else{
        _bookingDetailsContent = null;
      }
    }else{

    }
    _isLoading = false;
    update();
  }

  void setBookingDetailsData (BookingDetailsContent bookingDetailsContent){
    _invoiceItems = [];
    _allTotalCost = 0.0;
    _unitTotalCost = [];

    for (var element in bookingDetailsContent.detail!) {
      _unitTotalCost.add(element.serviceCost!.toDouble() * element.quantity!);
      _invoiceItems.add(
        InvoiceItem(
          discountAmount:(element.discountAmount! + element.campaignDiscountAmount!.toDouble() + element.overallCouponDiscountAmount!.toDouble()).toStringAsFixed(2),
          tax: element.taxAmount?.toStringAsFixed(2),
          unitAllTotal: element.totalCost?.toStringAsFixed(2),
          quantity: element.quantity ?? 0,
          serviceName: "${element.serviceName ?? 'service_deleted'.tr } \n${element.variantKey?.replaceAll('-', ' ').capitalizeFirst ??  'variantKey_not_available'.tr}" ,
          unitPrice: element.serviceCost?.toStringAsFixed(2),
        )
      );
    }
    for (var element in _unitTotalCost) {
      _allTotalCost = _allTotalCost + element;
    }
  }

  void resetTrackingData(){
    bookingIdController.clear();
    phoneController.clear();
    _bookingDetailsContent = null;
    update();
  }

  @override
  void onClose(){
    detailsTabController!.dispose();
    super.onClose();
  }
}