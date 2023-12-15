import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/loyalty_point/model/loyalty_point_model.dart';
import 'package:demandium/feature/wallet/model/bonus_model.dart';
import 'package:demandium/feature/wallet/model/wallet_filter_body.dart';
import 'package:demandium/feature/wallet/model/wallet_transaction_model.dart';
import 'package:demandium/feature/wallet/repository/wallet_repo.dart';
import 'package:get/get.dart';

class WalletController extends GetxController{
  final WalletRepo walletRepo;
  WalletController({required this.walletRepo});

  final bool _isLoading= false;
  bool get isLoading => _isLoading;

  int? _currentIndex = 0;
  int? get currentIndex => _currentIndex;

  WalletTransactionModel? walletTransactionModel;
  List<LoyaltyPointTransactionData> listOfTransaction = [];



  int _selectedPaymentMethod = -1;
  int get  selectedPaymentMethod => _selectedPaymentMethod;

  bool _amountEmpty = true;
  bool get amountEmpty => _amountEmpty;

  String? _digitalPaymentName;
  String? get digitalPaymentName => _digitalPaymentName;

  List<BonusModel>? _bonusList;
  List<BonusModel>? get bonusList => _bonusList;

  List<WalletFilterBody> _walletFilterList = [];
  List<WalletFilterBody> get walletFilterList => _walletFilterList;

  WalletFilterBody? _selectedWalletFilter;
  WalletFilterBody? get  selectedWalletFilter => _selectedWalletFilter;


  Future<void> getWalletTransactionData(int offset,{bool reload = false, String type = ""}) async {

    if(reload){
      walletTransactionModel= null;
      listOfTransaction = [];
      update();
    }
    Response response = await walletRepo.getWalletTransactionData( offset, type);
    if(response.statusCode == 200){
      walletTransactionModel = WalletTransactionModel.fromJson(response.body);
      if(offset!=1){
        listOfTransaction.addAll(walletTransactionModel!.content!.transactions!.data!);
      }else{
        listOfTransaction = [];
        listOfTransaction.addAll(walletTransactionModel!.content!.transactions!.data!);
      }

    }
    else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getBonusList(bool reload) async {

    if( _bonusList == null || reload){
      Response response = await walletRepo.getBonusList();
      if (response.statusCode == 200) {
        _bonusList = [];
        response.body['content']['data'].forEach((banner){
          _bonusList!.add(BonusModel.fromJson(banner));
        });
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }


  Future<void> addFundToWallet(double amount, String paymentMethod) async {

    customSnackBar("message", customWidget: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.check_circle, color: Colors.white70,),
      const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
      Text("fund_added_successfully".tr, style: ubuntuRegular.copyWith(color: Colors.white70,),)
    ]),
      backgroundColor: Colors.black87,
      borderRadius: Dimensions.radiusExtraMoreLarge
    );
  }


  void updateSelectedPaymentMethod(int index){
    _selectedPaymentMethod = index;
    update();
  }


  void isTextFieldEmpty(String value, {bool isUpdate = true}){
    _amountEmpty = value.isNotEmpty;
    if(isUpdate) {
      update();
    }
  }

  void changeDigitalPaymentName(String name, {bool isUpdate = true}){
    _digitalPaymentName = name;
    if(isUpdate) {
      update();
    }
  }

  void insertFilterList(){
    _selectedWalletFilter= null;
    _walletFilterList = [];
    for(int i=0; i < AppConstants.walletTransactionSortingList.length; i++){
      _walletFilterList.add(WalletFilterBody.fromJson(AppConstants.walletTransactionSortingList[i]));
    }
  }

  updateWalletFilterValue( WalletFilterBody filterBody ){
    _selectedWalletFilter = filterBody;
    update();
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if(notify) {
      update();
    }
  }

  void setWalletAccessToken(String accessToken){
    walletRepo.setWalletAccessToken(accessToken);
  }

  String getWalletAccessToken (){
    return walletRepo.getWalletAccessToken();
  }
}