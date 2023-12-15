import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class ServiceBookingRepo{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  ServiceBookingRepo({required this.sharedPreferences,required this.apiClient});


  Future<Response> getBookingList({required int offset, required String bookingStatus})async{
    return await apiClient.getData("${AppConstants.bookingList}?limit=10&offset=$offset&booking_status=$bookingStatus");
  }

  Future<Response> getBookingDetails({required String bookingID})async{
    return await apiClient.getData("${AppConstants.bookingDetails}/$bookingID");
  }
}