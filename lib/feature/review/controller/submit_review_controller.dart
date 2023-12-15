import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/review/repo/submit_review_repo.dart';

class SubmitReviewController extends GetxController {
  final SubmitReviewRepo submitReviewRepo ;
  SubmitReviewController({required this.submitReviewRepo});


  bool _isLoading = false;
  get isLoading => _isLoading;

  bool _loading = false;
  get loading => _loading;

  Map<String,Map<String, dynamic>> listOfReview = {};


  List<BookingContentDetailsItem> uniqueServiceList =[];
  List<String> serviceIdList =[];

  TextEditingController reviewController = TextEditingController();
  Map<String, TextEditingController> textControllers =  {};
  Map<String, int> selectedRating =  {};
  Map<String, bool> isEditable =  {};
  Map<String, String> reviewComments =  {};

  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

   selectReview(int rating,serviceId){
     selectedRating[serviceId] = rating;
    update();
  }

  void setIndex(int index){
    _selectedIndex= index;
    update();
  }

  Future<void> submitReview(ReviewBody reviewBody,String serviceId,String review, int rating)async{
    _isLoading = true;
    update();
    Response response =await submitReviewRepo.submitReview(reviewBody: reviewBody);
    if(response.statusCode == 200){

      isEditable[serviceId] = false;
      reviewComments[serviceId]=review;
      customSnackBar('review_submitted_successfully'.tr,isError: false);
    }
    _isLoading = false;
    update();
  }


  Future<void> getReviewList(String bookingId)async{
    _loading = true;
    update();
    Response response =await submitReviewRepo.getReviewList(bookingId: bookingId);
    if(response.statusCode == 200){

      if(response.body['content'].isNotEmpty){
        for (var id in serviceIdList) {
         if( response.body['content'][id]!=null){
           listOfReview[id]= response.body['content'][id][0];
           selectedRating[id] = response.body['content'][id][0]['review_rating'];
           textControllers[id]!.text = response.body['content'][id][0]['review_comment'];
           reviewComments[id] = response.body['content'][id][0]['review_comment'];

           if(response.body['content'][id][0]['review_comment']!=null || response.body['content'][id][0]['review_comment']!=""){
             isEditable[id] = false;
           }
           }
        }
      }
    }
    _loading = false;
    update();
  }

  void  uniqueService(BookingDetailsContent bookingDetailsContent){
     serviceIdList =[];
     uniqueServiceList =[];
    for (var element in bookingDetailsContent.detail!) {
      if(!serviceIdList.contains(element.serviceId)){
        serviceIdList.add(element.serviceId!);
        uniqueServiceList.add(element);
      }
    }
    for (var method in uniqueServiceList) {
      textControllers[method.serviceId!] = TextEditingController();
    }
    for (var method in uniqueServiceList) {
      selectedRating[method.serviceId!] = 5;
    }
    for (var method in uniqueServiceList) {
      isEditable[method.serviceId!] = true;
    }
  }

  void updateEditableValue(String serviceId,bool value,{bool isUpdate= false}){
    isEditable[serviceId] = value;
    if(isUpdate){
      update();
    }
  }
}