import 'package:demandium/feature/category/model/category_model.dart';

class CategoryTypesModel {
  int? id;
  String? discountId;
  String? discountType;
  String? typeWiseId;
  String? createdAt;
  String? updatedAt;
  CategoryModel? category;

  CategoryTypesModel(
      {this.id,
        this.discountId,
        this.discountType,
        this.typeWiseId,
        this.createdAt,
        this.updatedAt,
        this.category});

  CategoryTypesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountType = json['discount_type'];
    typeWiseId = json['type_wise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['discount_id'] = discountId;
    data['discount_type'] = discountType;
    data['type_wise_id'] = typeWiseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}