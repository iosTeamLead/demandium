import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/campaign/model/category_types_model.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  List<CategoryModel>? _categoryList;
  List<CategoryModel>? _subCategoryList;
  List<Service>? _searchProductList = [];
  List<CategoryModel>? _campaignBasedCategoryList ;

  bool _isLoading = false;
  int? _pageSize;
  bool? _isSearching = false;
  final String _type = 'all';
  final String _searchText = '';
  int? _offset = 1;

  List<CategoryModel>? get categoryList => _categoryList;
  List<CategoryModel>? get campaignBasedCategoryList => _campaignBasedCategoryList;
  List<CategoryModel>? get subCategoryList => _subCategoryList;
  List<Service>? get searchServiceList => _searchProductList;
  bool get isLoading => _isLoading;
  int? get pageSize => _pageSize;
  bool? get isSearching => _isSearching;
  String? get type => _type;
  String? get searchText => _searchText;
  int? get offset => _offset;


  final ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<CategoryController>().pageSize!;
        if (Get.find<CategoryController>().offset! < pageSize) {
          Get.find<CategoryController>().showBottomLoader();
          getCategoryList(Get.find<CategoryController>().offset!+1, false);
        }
      }
    });
  }

  Future<void> getCategoryList(int offset, bool reload ) async {
    _offset = offset;
    if(_categoryList == null || reload){
      Response response = await categoryRepo.getCategoryList(offset);
      if (response.statusCode == 200) {
        _categoryList = [];
        response.body['content']['data'].forEach((category) {
          _categoryList!.add(CategoryModel.fromJson(category));
        });
        _pageSize = response.body['content']['last_page'];
      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
  }


  Future<void> getSubCategoryList(String categoryID, int? subCategoryIndex, {bool shouldUpdate = true}) async {
    _subCategoryList = null;
    if(shouldUpdate){
      update();
    }
    Response response = await categoryRepo.getSubCategoryList(categoryID);
    if (response.statusCode == 200 && response.body['response_code'] == 'default_200') {
      _subCategoryList= [];
      response.body['content']['data'].forEach((category) =>
          _subCategoryList!.addIf(CategoryModel.fromJson(category).isActive , CategoryModel.fromJson(category)));
    } else {
      _subCategoryList= [];
      //ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getCampaignBasedCategoryList(String campaignID, bool isWithPagination) async {
    printLog("inside_campaign_based_category !");
    Response response = await categoryRepo.getItemsBasedOnCampaignId(campaignID: campaignID);

    if (response.body['response_code'] == 'default_200') {
      if(!isWithPagination){
        _campaignBasedCategoryList = [];
      }
      response.body['content']['data'].forEach((categoryTypesModel) {
        if(CategoryTypesModel.fromJson(categoryTypesModel).category != null){
          _campaignBasedCategoryList!.add(CategoryTypesModel.fromJson(categoryTypesModel).category!);
        }
      });
      _isLoading = false;
      Get.toNamed(RouteHelper.getCategoryRoute('fromCampaign',campaignID));
    } else {
      if(response.statusCode != 200){
        ApiChecker.checkApi(response);
      }else{
        customSnackBar('campaign_is_not_available_for_this_service'.tr);
      }
    }
    update();
  }


  void toggleSearch() {
    _isSearching = !_isSearching!;
    _searchProductList = [];
    update();
  }
  void showBottomLoader() {
    _isLoading = true;
    update();
  }

}
