import '../../../components/core_export.dart';
import '../../notification/repository/notification_repo.dart';

class BookingDetailsRepo{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  BookingDetailsRepo({required this.sharedPreferences,required this.apiClient});


  Future<Response> getBookingDetails({required String bookingID})async{
    return await apiClient.getData("${AppConstants.bookingDetails}/$bookingID");
  }

  Future<Response> trackBookingDetails({required String bookingID, required String phoneNUmber})async{
    return await apiClient.postData("${AppConstants.trackBooking}/$bookingID",{
      "phone": phoneNUmber
    });
  }


  Future<Response> bookingCancel({required String bookingID}) async {
    return await apiClient.postData('${AppConstants.bookingCancel}/$bookingID', {
      "booking_status" :"canceled",
      "_method" : "put"});
  }

}