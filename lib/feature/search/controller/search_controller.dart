import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';


class AllSearchController extends GetxController implements GetxService {
  final SearchRepo searchRepo;
  AllSearchController({required this.searchRepo});

  List<Service>? _searchServiceList;
  String? _searchText = '';
  List<String>? _historyList = [];
  final List<String> _sortList = ['ascending'.tr, 'descending'.tr];
  bool? _isAvailableFoods = false;
  bool? _isDiscountedFoods = false;
  final bool _isLoading = false;
  bool _isSearchComplete = false;
  bool _isActiveSuffixIcon = false;

  List<Service>? get searchServiceList => _searchServiceList;
  String? get searchText => _searchText;
  List<String>? get historyList => _historyList;
  List<String>? get sortList => _sortList;
  bool? get isAvailableFoods => _isAvailableFoods;
  bool? get isDiscountedFoods => _isDiscountedFoods;
  bool? get isLoading => _isLoading;
  bool get isSearchComplete => _isSearchComplete;
  bool get isActiveSuffixIcon => _isActiveSuffixIcon;

  var searchController = TextEditingController();


  @override
  void onInit() {
    super.onInit();

    getHistoryList();
    searchController.text = '';
  }

  void toggleAvailableFoods() {
    _isAvailableFoods = !_isAvailableFoods!;
    update();
  }

  void toggleDiscountedFoods() {
    _isDiscountedFoods = !_isDiscountedFoods!;
    update();
  }

  void setSearchText(String text) {
    _searchText = text;
    update();
  }

  Future<void> navigateToSearchResultScreen()async{
    if(searchController.value.text.trim().isNotEmpty){
      if(Get.currentRoute.contains('/search?query=')){
        Get.offNamed(RouteHelper.getSearchResultRoute(queryText: searchController.value.text.trim()));
      }else{
        Get.toNamed(RouteHelper.getSearchResultRoute(queryText: searchController.value.text.trim()));
      }
    }
  }

  Future<void> clearSearchController()async{
    if(searchController.value.text.trim().isNotEmpty){
      searchController.clear();
      _isSearchComplete = false;
      _isActiveSuffixIcon = false;
      update();
    }
  }

  Future<void> populatedSearchController(String historyText)async{
    searchController.clear();
    searchController = TextEditingController(text: historyText);
    _isActiveSuffixIcon = true;
    update();

  }

  void suggestedSearchData({String title='all'}){
    //_searchServiceList = [];
    _searchServiceList = null;
    _isSearchComplete = true;
      if(title=='all'){
        _searchServiceList = Get.find<ServiceController>().allService;
      }else if(title=='popular'){
        _searchServiceList = Get.find<ServiceController>().popularServiceList;
      }
      else if(title=='trending'){
        _searchServiceList = Get.find<ServiceController>().allService;
      }

      update();
  }


  Future<void> searchData(String query, {bool shouldUpdate = true}) async {
    if(query.isNotEmpty ) {
      _searchText = query;
      _searchServiceList = null;
      if (!_historyList!.contains(query)) {
        _historyList!.insert(0, query);
      }
      searchRepo.saveSearchHistory(_historyList!);
      if(shouldUpdate) {
        update();
      }
      Response response = await searchRepo.getSearchData(query);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
          _searchServiceList = [];
        } else {
          _searchServiceList = [];
          _searchServiceList!.addAll(ServiceModel.fromJson(response.body).content!.serviceList!);
        }
      } else {
        ApiChecker.checkApi(response);
      }
      _isSearchComplete = true;
      update();
    }
  }


  void showSuffixIcon(context,String text){
    if(text.isNotEmpty){
      _isActiveSuffixIcon = true;
    }else if(text.isEmpty){
      _isActiveSuffixIcon = false;
    }
    update();
  }


  void getHistoryList() {
    _searchText = '';
    _historyList = [];
    if(searchRepo.getSearchAddress().isNotEmpty){
      _historyList!.addAll(searchRepo.getSearchAddress());
    }
  }

  void removeHistory({int? index}) {
    if(index!=null){
      _historyList!.removeAt(index);
    }else{
      _historyList!.clear();
    }
    searchRepo.saveSearchHistory(_historyList!);
    update();
  }

  List<String>? filterHistory(String pattern, List<String>? value){
    List<String>? list = [];

    value?.forEach((history) {
      if(history.contains(pattern.toLowerCase())) {
        list.add(history);
      }
    });

    return list;
  }


  void clearSearchAddress() async {
    searchRepo.clearSearchHistory();
    _historyList = [];
    update();
  }

  void removeService() async {
   _searchServiceList = [];
   _isSearchComplete = false;
  }


}
