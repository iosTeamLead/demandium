import 'package:demandium/feature/service/model/feathered_service_model.dart';
import 'package:demandium/feature/service/model/recommendation_search_model.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/campaign/model/service_types.dart';

class ServiceController extends GetxController implements GetxService {
  final ServiceRepo serviceRepo;
  ServiceController({required this.serviceRepo});


  bool _isLoading = false;
  List<int>? _variationIndex;
  int? _quantity = 1;
  List<bool>? _addOnActiveList = [];
  List<int>? _addOnQtyList = [];
  final int _cartIndex = -1;


  ServiceContent? _serviceContent;
  ServiceContent? _offerBasedServiceContent;
  ServiceContent? _popularBasedServiceContent;
  ServiceContent? _recommendedServiceContent;
  ServiceContent? _trendingServiceContent;
  ServiceContent? _recentlyViewServiceContent;
  FeatheredCategoryContent? _featheredCategoryContent;

  ServiceContent? get serviceContent => _serviceContent;
  ServiceContent? get offerBasedServiceContent => _offerBasedServiceContent;
  ServiceContent? get popularBasedServiceContent => _popularBasedServiceContent;
  ServiceContent? get recommendedBasedServiceContent => _recommendedServiceContent;
  ServiceContent? get trendingServiceContent => _trendingServiceContent;
  ServiceContent? get recentlyViewServiceContent => _recentlyViewServiceContent;
  FeatheredCategoryContent? get featheredCategoryContent => _featheredCategoryContent;

  List<Service>? _popularServiceList;
  List<Service>? _trendingServiceList;
  List<Service>? _recentlyViewServiceList;
  List<Service>? _recommendedServiceList;
  List<RecommendedSearch>? _recommendedSearchList;
  List<Service>? _subCategoryBasedServiceList;
  List<Service>? _campaignBasedServiceList;
  List<Service>? _offerBasedServiceList;
  List<Service>? _allService;
  List<CategoryData> _categoryList =[];


  List<Service>? get allService => _allService ;
  List<Service>? get popularServiceList => _popularServiceList;
  List<Service>? get trendingServiceList => _trendingServiceList;
  List<Service>? get recentlyViewServiceList => _recentlyViewServiceList;
  List<Service>? get recommendedServiceList => _recommendedServiceList;
  List<Service>? get subCategoryBasedServiceList => _subCategoryBasedServiceList;
  List<Service>? get campaignBasedServiceList => _campaignBasedServiceList;
  List<Service>? get offerBasedServiceList => _offerBasedServiceList;
  List<RecommendedSearch>? get recommendedSearchList => _recommendedSearchList;
  List<CategoryData> get categoryList => _categoryList ;


  bool get isLoading => _isLoading;
  List<int>? get variationIndex => _variationIndex;
  int? get quantity => _quantity;
  List<bool>? get addOnActiveList => _addOnActiveList;
  List<int>? get addOnQtyList => _addOnQtyList;
  int get cartIndex => _cartIndex;

  double? _serviceDiscount = 0.0;
  double get serviceDiscount => _serviceDiscount!;

  String? _discountType;
  String get discountType => _discountType!;

  String? _fromPage;
  String? get fromPage => _fromPage!;

  final List<double> _lowestPriceList = [];
  List<double> get lowestPriceList => _lowestPriceList;

  bool _shuffleRecommendList = false;
  bool get shuffleRecommendList => _shuffleRecommendList;


  @override
  Future<void> onInit() async {
    super.onInit();
    if(Get.find<AuthController>().isLoggedIn()) {
     await Get.find<UserController>().getUserInfo();
     await Get.find<CartController>().getCartData();
     // await Get.find<CartController>().addMultipleCartToServer();
     await Get.find<CartController>().getCartListFromServer();
    }
  }



  Future<void> getAllServiceList(int offset, bool reload) async {
    if(offset != 1 || _allService == null || reload){
      if(reload){
        _allService = null;
      }
      Response response = await serviceRepo.getAllServiceList(offset);
      if (response.statusCode == 200) {
        if(reload){
          _allService = [];
        }
        _serviceContent = ServiceModel.fromJson(response.body).content;
        if(_allService != null && offset != 1){
          _allService!.addAll(ServiceModel.fromJson(response.body).content!.serviceList!);
        }else{
          _allService = [];
          _allService!.addAll(ServiceModel.fromJson(response.body).content!.serviceList!);
        }
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }


  Future<void> getPopularServiceList(int offset, bool reload) async {
    if(offset != 1 || _popularServiceList == null || reload ){
      Response response = await serviceRepo.getPopularServiceList(offset);
      if (response.statusCode == 200) {
        if(reload){
          _popularServiceList = [];
        }
        _popularBasedServiceContent = ServiceModel.fromJson(response.body).content;

        if(_popularServiceList != null && offset != 1){
          _popularServiceList!.addAll(_popularBasedServiceContent!.serviceList!);
        }else{
          _popularServiceList = [];
          _popularServiceList!.addAll(_popularBasedServiceContent!.serviceList!);
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }


  Future<void> getTrendingServiceList(int offset, bool reload) async {
    if(offset != 1 || _trendingServiceList == null || reload ){
      Response response = await serviceRepo.getTrendingServiceList(offset);
      if (response.statusCode == 200) {
        if(reload){
          _trendingServiceList = [];
        }
        _trendingServiceContent = ServiceModel.fromJson(response.body).content;

        if(_trendingServiceList != null && offset != 1){
          _trendingServiceList!.addAll(_trendingServiceContent!.serviceList!);
        }else{
          _trendingServiceList = [];
          _trendingServiceList!.addAll(_trendingServiceContent!.serviceList!);
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }


  Future<void> getRecentlyViewedServiceList(int offset, bool reload) async {
    if(offset != 1 || _recentlyViewServiceList == null || reload ){
      Response response = await serviceRepo.getRecentlyViewedServiceList(offset);
      if (response.statusCode == 200) {
        if(reload){
          _recentlyViewServiceList = [];
        }
        _recentlyViewServiceContent = ServiceModel.fromJson(response.body).content;

        if(_recentlyViewServiceList != null && offset != 1){
          _recentlyViewServiceList!.addAll(_recentlyViewServiceContent!.serviceList!);
        }else{
          _recentlyViewServiceList = [];
          _recentlyViewServiceList!.addAll(_recentlyViewServiceContent!.serviceList!);
        }
      } else {
        //ApiChecker.checkApi(response);
      }
      update();
    }
  }



  Future<void> getFeatherCategoryList( bool reload) async {

    if(_featheredCategoryContent == null || reload){
      if(reload){
        _categoryList =[];
        _featheredCategoryContent = null;
      }
      Response response = await serviceRepo.getFeatheredCategoryServiceList();
      if (response.statusCode == 200) {
        _featheredCategoryContent = FeatheredCategoryModel.fromJson(response.body).content;

        if(_featheredCategoryContent!.categoryList!=null || _featheredCategoryContent!.categoryList!.isNotEmpty){
          _categoryList =[];
          _featheredCategoryContent?.categoryList?.forEach((element) {
            if(element.servicesByCategory!=null && element.servicesByCategory!.isNotEmpty){
              _categoryList.add(element);
            }
          });
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> getRecommendedServiceList(int offset, bool reload ) async {
   if(offset != 1 || _recommendedServiceList == null || reload){
     Response response = await serviceRepo.getRecommendedServiceList(offset);
     if (response.statusCode == 200) {
       if(reload){
         _recommendedServiceList = [];
       }
       _recommendedServiceContent = ServiceModel.fromJson(response.body).content;
       if(_recommendedServiceList != null && offset != 1){
         _recommendedServiceList!.addAll(ServiceModel.fromJson(response.body).content!.serviceList!);
       }else{
         _recommendedServiceList = [];
         _recommendedServiceList!.addAll(_recommendedServiceContent!.serviceList!);
       }
     } else {
       ApiChecker.checkApi(response);
     }
     update();
   }
  }

  Future<void> getRecommendedSearchList({bool reload = false}) async {
    if(reload){
      _recommendedSearchList = null;
      update();
    }
    Response response = await serviceRepo.getRecommendedSearchList();
    if (response.statusCode == 200) {
      if(response.body['content']!=null){
        List<dynamic> list = response.body['content'];
        _recommendedSearchList = [];
        for (var element in list) {
          _recommendedSearchList?.add(RecommendedSearch.fromJson(element));
        }
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


   cleanSubCategory(){
    _subCategoryBasedServiceList = null;
    update();
  }

  Future<void> getSubCategoryBasedServiceList(String subCategoryID, bool isWithPagination, {bool isShouldUpdate = true, bool showShimmerAlways = false}) async {
    if(showShimmerAlways){
      _subCategoryBasedServiceList = null;
      update();
    }
    Response response = await serviceRepo.getServiceListBasedOnSubCategory(subCategoryID: subCategoryID,offset: 1);
    if (response.statusCode == 200) {
      if(!isWithPagination){
        _subCategoryBasedServiceList = [];
      }
      _subCategoryBasedServiceList!.addAll(ServiceModel.fromJson(response.body).content?.serviceList??[]);
    } else {
      ApiChecker.checkApi(response);
    }
    if(isShouldUpdate){
      update();
    }
  }

  Future<void> getCampaignBasedServiceList(String campaignID, bool reload) async {
    Response response = await serviceRepo.getItemsBasedOnCampaignId(campaignID: campaignID);
    if (response.body['response_code'] == 'default_200') {
      if(reload){
        _campaignBasedServiceList = [];
      }
      response.body['content']['data'].forEach((serviceTypesModel) {
        if(ServiceTypesModel.fromJson(serviceTypesModel).service != null){
          _campaignBasedServiceList!.add(ServiceTypesModel.fromJson(serviceTypesModel).service!);
        }
      });
      Get.toNamed(RouteHelper.allServiceScreenRoute("fromCampaign",campaignID: campaignID));
    } else {
      customSnackBar('campaign_is_not_available_for_this_service'.tr);
      if(response.statusCode != 200){
        ApiChecker.checkApi(response);
      }
    }
    update();
  }

  Future<void> getEmptyCampaignService()async {
    _campaignBasedServiceList = null;
  }

  Future<void> getMixedCampaignList(String campaignID, bool isWithPagination) async {
    if(!isWithPagination){
      _campaignBasedServiceList = [];
    }
    Response response = await serviceRepo.getItemsBasedOnCampaignId(campaignID: campaignID);
    if (response.body['response_code'] == 'default_200') {
      response.body['content']['data'].forEach((serviceTypesModel) {
        if(ServiceTypesModel.fromJson(serviceTypesModel).service != null){
          _campaignBasedServiceList!.add(ServiceTypesModel.fromJson(serviceTypesModel).service!);
        }
      });
      _isLoading = false;
      if(_campaignBasedServiceList!.isEmpty){
        Get.find<CategoryController>().getCampaignBasedCategoryList(campaignID,false);
      }else{
        Get.toNamed(RouteHelper.allServiceScreenRoute("fromCampaign",campaignID: campaignID));
      }
    } else {
      if(response.statusCode != 200){
        ApiChecker.checkApi(response);
      }else{
        customSnackBar('campaign_is_not_available_for_this_service'.tr);
      }
    }
    update();
  }

  Future<void> getOffersList(int offset, bool reload) async {
    Response response = await serviceRepo.getOffersList(offset);
    if (response.statusCode == 200) {
      if( reload){
        _offerBasedServiceList = [];
      }
      _offerBasedServiceContent = ServiceModel.fromJson(response.body).content;
      if(_offerBasedServiceList != null && offset != 1){
        _offerBasedServiceList!.addAll(_offerBasedServiceContent!.serviceList!);
      }else{
        _offerBasedServiceList = [];
        _offerBasedServiceList!.addAll(_offerBasedServiceContent!.serviceList!);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  int setExistInCart(Service service, {bool notify = true}) {
    List<String> variationList = [];
    for (int index = 0; index < service.variationsAppFormat!.zoneWiseVariations!.length; index++) {
      variationList.add(service.variationsAppFormat!.zoneWiseVariations![index].variantName!);
    }
    String variationType = '';
    bool isFirst = true;
    for (var variation in variationList) {
      if (isFirst) {
        variationType = '$variationType$variation';
        isFirst = false;
      } else {
        variationType = '$variationType-$variation';
      }
    }
    if(_cartIndex != -1) {
      _quantity = Get.find<CartController>().cartList[_cartIndex].quantity;
      _addOnActiveList = [];
      _addOnQtyList = [];

    }
    return _cartIndex;
  }

  void setAddOnQuantity(bool isIncrement, int index) {
    if (isIncrement) {
      _addOnQtyList![index] = _addOnQtyList![index] + 1;
    } else {
      _addOnQtyList![index] = _addOnQtyList![index] - 1;
    }
    update();
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity! + 1;
    } else {
      _quantity = _quantity! - 1;
    }
    update();
  }

  void setCartVariationIndex(int index, int i,Service product) {
    _variationIndex![index] = i;
    _quantity = 1;
    setExistInCart(product);
    update();
  }

  void addAddOn(bool isAdd, int index) {
    _addOnActiveList![index] = isAdd;
    update();
  }


  Future<void> getServiceDiscount(Service service) async {
    if(service.campaignDiscount != null){
      _serviceDiscount = service.campaignDiscount!.isNotEmpty ?  service.campaignDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
      _discountType = service.campaignDiscount!.isNotEmpty ?  service.campaignDiscount!.elementAt(0).discount!.discountType!:'amount';
    }else if(service.category!.campaignDiscount != null){
      _serviceDiscount = service.category!.campaignDiscount!.isNotEmpty ?  service.category!.campaignDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
      _discountType = service.category!.campaignDiscount!.isNotEmpty ?  service.category!.campaignDiscount!.elementAt(0).discount!.discountAmountType! :'amount';
    }else if(service.serviceDiscount != null){
      _serviceDiscount = service.serviceDiscount!.isNotEmpty ?  service.serviceDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
      _discountType = service.serviceDiscount!.isNotEmpty ?  service.serviceDiscount!.elementAt(0).discount!.discountType!:'amount';
    } else{
      _serviceDiscount = service.category!.categoryDiscount!.isNotEmpty ?  service.category!.categoryDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
      _discountType = service.category!.categoryDiscount!.isNotEmpty ?  service.category!.categoryDiscount!.elementAt(0).discount!.discountAmountType! :'amount';
    }
  }

  void shuffleRecommendSuggestList(){
    _shuffleRecommendList = !_shuffleRecommendList;
    update();
  }
}
