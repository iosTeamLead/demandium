import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

enum BookingStatusTabs {all, pending, accepted, ongoing,completed,canceled }

class ServiceBookingController extends GetxController implements GetxService {
  final ServiceBookingRepo serviceBookingRepo;
  ServiceBookingController({required this.serviceBookingRepo});

  List<BookingModel>? _bookingList;
  List<BookingModel>? get bookingList => _bookingList;
  int _offset = 1;
  int? get offset => _offset;
  BookingContent? _bookingContent;
  BookingContent? get bookingContent => _bookingContent;

  int _bookingListPageSize = 0;
  final int _bookingListCurrentPage = 0;
  int get bookingListPageSize=> _bookingListPageSize;
  int get bookingListCurrentPage=> _bookingListCurrentPage;
  BookingStatusTabs _selectedBookingStatus = BookingStatusTabs.all;
  BookingStatusTabs get selectedBookingStatus =>_selectedBookingStatus;






  void updateBookingStatusTabs(BookingStatusTabs bookingStatusTabs, {bool firstTimeCall = true, bool fromMenu= false}){
    _selectedBookingStatus = bookingStatusTabs;
    if(firstTimeCall){
      getAllBookingService(offset: 1, bookingStatus: _selectedBookingStatus.name.toLowerCase(),isFromPagination:false);
    }
  }



  Future<void> getAllBookingService({required int offset, required String bookingStatus, required bool isFromPagination, bool fromMenu= false})async{
    _offset = offset;
    if(!isFromPagination){
      _bookingList = null;
    }
    Response response = await serviceBookingRepo.getBookingList(offset: offset, bookingStatus: bookingStatus);
    if(response.statusCode == 200){
      ServiceBookingList serviceBookingModel = ServiceBookingList.fromJson(response.body);
      if(!isFromPagination){
        _bookingList = [];
      }
      for (var element in serviceBookingModel.content!.bookingModel!) {
        _bookingList!.add(element);
      }
      _bookingListPageSize = response.body['content']['last_page'];
      _bookingContent = serviceBookingModel.content!;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
