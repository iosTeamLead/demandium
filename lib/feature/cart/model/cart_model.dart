import 'package:demandium/feature/provider/model/provider_model.dart';
import 'package:demandium/feature/service/model/service_model.dart';

class CartModel {
  String? _id;
  String? _serviceId;
  String? _categoryId;
  String? _subCategoryId;
  String? _variantKey;
  num? _serviceCost;
  int? _quantity;
  num? _discountAmount;
  num? _campaignDiscountAmount;
  num? _couponDiscountAmount;
  String? _couponCode;
  num? _taxAmount;
  num? _totalCost;
  Service? _service;
  ProviderData? _provider;

  CartModel(
      String id,
      String serviceId,
      String categoryId,
      String subCategoryId,
      String variantKey,
      num serviceCost,
      int quantity,
      num discountAmount,
      num campaignDiscountAmount,
      num couponDiscountAmount,
      String? couponCode,
      num taxAmount,
      num totalCost,
      Service service,
      {
        ProviderData? provider
      })
  {
  _id = id;
  _serviceId = serviceId;
  _categoryId = categoryId;
  _subCategoryId = subCategoryId;
  _variantKey = variantKey;
  _serviceCost = serviceCost;
  _quantity = quantity;
  _discountAmount = discountAmount;
  _campaignDiscountAmount = campaignDiscountAmount;
  _couponDiscountAmount = couponDiscountAmount;
  _couponCode = couponCode;
  _taxAmount = taxAmount;
  _totalCost = totalCost;
  _service = service;
  _provider = provider;
  }

  String get id => _id!;
  Service? get service => _service;
  ProviderData? get provider => _provider;

  String get serviceId => _serviceId!;
  String get categoryId => _categoryId!;
  String get variantKey => _variantKey!;
  String get subCategoryId => _subCategoryId!;

  num get price => _serviceCost!;
  num get discountedPrice => _discountAmount!;
  num get campaignDiscountPrice => _campaignDiscountAmount!;
  num get couponDiscountPrice => _couponDiscountAmount!;
  String? get couponCode => _couponCode;
  num get taxAmount => _taxAmount!;
  num get totalCost => _totalCost!;
  num get serviceCost => _serviceCost!;
  // ignore: unnecessary_getters_setters
  int get quantity => _quantity!;

  // ignore: unnecessary_getters_setters
  set quantity(int qty) => _quantity = qty;

  CartModel copyWith({String? id, int? quantity}) {
    if(id != null) {
      _id = id;
    }

    if(quantity != null) {
      _quantity = quantity;
    }
    return this;
}

  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _serviceId = json['service_id'];
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _variantKey = json['variant_key'];
    _serviceCost = json['service_cost'];
    _quantity = json['quantity'];
    _discountAmount = json['discount_amount'];
    _campaignDiscountAmount = json['campaign_discount'];
    _couponDiscountAmount = json['coupon_discount'];
    _couponCode = json['coupon_code'];
    _taxAmount = json['tax_amount'];
    _totalCost = json['total_cost'];
    _service = json['service'] != null ? Service.fromJson(json['service']) : null;
    _provider = (json['provider'] != null ? ProviderData.fromJson(json['provider']) : null);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['service_id'] = _serviceId;
    data['category_id'] = _categoryId;
    data['sub_category_id'] = _subCategoryId;
    data['variant_key'] = _variantKey;
    data['service_cost'] = _serviceCost;
    data['quantity'] = _quantity;
    data['discount_amount'] = _discountAmount;
    data['campaign_discount'] = _campaignDiscountAmount;
    data['coupon_discount'] = _couponDiscountAmount;
    data['coupon_code'] = _couponCode;
    data['tax_amount'] = _taxAmount;
    data['total_cost'] = _totalCost;
    data['service'] = _service;
    data['service'] = service?.toJson();
    data['provider'] = provider?.toJson();
    return data;
  }
}
