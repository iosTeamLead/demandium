import 'package:demandium/data/provider/client_api.dart';
import 'package:demandium/feature/create_post/model/create_post_body.dart';
import 'package:demandium/utils/app_constants.dart';
import 'package:get/get.dart';

class CreatePostRepo{
  final ApiClient apiClient;
  CreatePostRepo({required this.apiClient});

  Future<Response> getCategoryList() async {
    return await apiClient.getData('${AppConstants.categoryUrl}&limit=100&offset=1');
  }
  
  Future<Response> createCustomPost(CreatePostBody body)  async {
    return await apiClient.postData(AppConstants.createCustomizedPost, body.toJson());
  }

  Future<Response> getMyPostList(int offset)  async {
    return await apiClient.getData("${AppConstants.getMyPostList}?limit=10&offset=$offset");
  }

  Future<Response> getProvidersOfferList(int offset, String postId) async {
    return await apiClient.getData("${AppConstants.getInterestedProviderList}?post_id=$postId&limit=10&offset=$offset");
  }

  Future<Response> getProviderBidDetails(String postId, String providerId) async {
    return await apiClient.getData("${AppConstants.getProviderBidDetails}?post_id=$postId&provider_id=$providerId");
  }

  Future<Response> updatePostStatus(String postId, String providerId, String status,{int? isPartial, String? serviceAddressId, String? serviceAddress}) async {

    return await apiClient.postData(
      AppConstants.updatePostStatus,
      {
        "_method":"put",
        "post_id":postId,
        "provider_id":providerId,
        "status": status,
        "service_address": serviceAddress,
        "service_address_id": serviceAddressId,
        "is_partial": isPartial,

      }
    );
  }

  Future<Response>  makePayment({String? paymentMethod,String? postId, String? providerId, String? address,
    String? serviceAddressID,String? schedule,String? zoneId, int? isPartial, String? offlinePaymentId, String? customerInformation
  }) async {
    return await apiClient.postData(AppConstants.placeRequest, {
      "payment_method": paymentMethod,
      "zone_id": zoneId,
      "service_schedule": schedule,
      "service_address_id": serviceAddressID,
      "service_address" : address,
      "post_id" : postId,
      "provider_id":providerId,
      "is_partial" : isPartial,
      "offline_payment_id" : offlinePaymentId,
      "customer_information" : customerInformation
    });
  }
}