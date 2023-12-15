import 'package:demandium/feature/service/model/service_model.dart';


class FeatheredCategoryModel {
  String? responseCode;
  String? message;
  FeatheredCategoryContent? content;

  FeatheredCategoryModel({this.responseCode, this.message, this.content});

  FeatheredCategoryModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? FeatheredCategoryContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class FeatheredCategoryContent {
  int? currentPage;
  List<CategoryData>? categoryList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? path;
  String? perPage;
  int? to;
  int? total;

  FeatheredCategoryContent(
      {this.currentPage,
        this.categoryList,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  FeatheredCategoryContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      categoryList = <CategoryData>[];
      json['data'].forEach((v) {
        categoryList!.add(CategoryData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (categoryList != null) {
      data['data'] = categoryList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class CategoryData {
  String? id;
  String? parentId;
  String? name;
  String? image;
  int? position;
  String? description;
  int? isActive;
  int? isFeatured;
  String? createdAt;
  String? updatedAt;
  List<Service>? servicesByCategory;
  List<ServiceDiscount>? categoryDiscount;
  List<ServiceDiscount>? campaignDiscount;

  CategoryData(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.position,
        this.description,
        this.isActive,
        this.isFeatured,
        this.createdAt,
        this.updatedAt,
        this.servicesByCategory,
        this.categoryDiscount,
        this.campaignDiscount});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    description = json['description'];
    isActive = json['is_active'];
    isFeatured = int.tryParse(json['is_featured'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['services_by_category'] != null) {
      servicesByCategory = <Service>[];
      json['services_by_category'].forEach((v) {
        servicesByCategory!.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['name'] = name;
    data['image'] = image;
    data['position'] = position;
    data['description'] = description;
    data['is_active'] = isActive;
    data['is_featured'] = isFeatured;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (servicesByCategory != null) {
      data['services_by_category'] =
          servicesByCategory!.map((v) => v.toJson()).toList();
    }

    if (categoryDiscount != null) {
      data['category_discount'] =
          categoryDiscount!.map((v) => v.toJson()).toList();
    }
    if (campaignDiscount != null) {
      data['campaign_discount'] =
          campaignDiscount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
