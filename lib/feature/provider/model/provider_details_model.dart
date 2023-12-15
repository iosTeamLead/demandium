import 'package:demandium/feature/provider/model/provider_model.dart';
import 'package:demandium/feature/service/model/service_model.dart';
import 'package:demandium/feature/service/model/service_review_model.dart';

class ProviderDetails {
  ProviderDetailsContent? content;

  ProviderDetails({this.content});

  ProviderDetails.fromJson(Map<String, dynamic> json) {
    content = json['content'] != null ? ProviderDetailsContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class ProviderDetailsContent {
  Provider? provider;
  List<SubCategories>? subCategories;

  ProviderDetailsContent({this.provider, this.subCategories});

  ProviderDetailsContent.fromJson(Map<String, dynamic> json) {
    provider = json['provider'] != null
        ? Provider.fromJson(json['provider'])
        : null;
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    if (subCategories != null) {
      data['sub_categories'] =
          subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provider {
  String? id;
  String? userId;
  String? companyName;
  String? companyPhone;
  String? companyAddress;
  String? companyEmail;
  String? logo;
  String? contactPersonName;
  String? contactPersonPhone;
  String? contactPersonEmail;
  int? orderCount;
  int? serviceManCount;
  int? serviceCapacityPerDay;
  int? ratingCount;
  double? avgRating;
  int? commissionStatus;
  double? commissionPercentage;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? isApproved;
  String? zoneId;
  Owner? owner;
  List<ReviewData>? reviews;

  Provider(
      {this.id,
        this.userId,
        this.companyName,
        this.companyPhone,
        this.companyAddress,
        this.companyEmail,
        this.logo,
        this.contactPersonName,
        this.contactPersonPhone,
        this.contactPersonEmail,
        this.orderCount,
        this.serviceManCount,
        this.serviceCapacityPerDay,
        this.ratingCount,
        this.avgRating,
        this.commissionStatus,
        this.commissionPercentage,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.isApproved,
        this.zoneId,
        this.owner,
        this.reviews});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyName = json['company_name'];
    companyPhone = json['company_phone'];
    companyAddress = json['company_address'];
    companyEmail = json['company_email'];
    logo = json['logo'];
    contactPersonName = json['contact_person_name'];
    contactPersonPhone = json['contact_person_phone'];
    contactPersonEmail = json['contact_person_email'];
    orderCount = json['order_count'];
    serviceManCount = json['service_man_count'];
    serviceCapacityPerDay = json['service_capacity_per_day'];
    ratingCount = json['rating_count'];
    avgRating = double.tryParse(json['avg_rating'].toString());
    commissionStatus = json['commission_status'];
    commissionPercentage = double.tryParse(json['commission_percentage'].toString());
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isApproved = json['is_approved'];
    zoneId = json['zone_id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    if (json['reviews'] != null) {
      reviews = <ReviewData>[];
      json['reviews'].forEach((v) {
        reviews!.add(ReviewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_name'] = companyName;
    data['company_phone'] = companyPhone;
    data['company_address'] = companyAddress;
    data['company_email'] = companyEmail;
    data['logo'] = logo;
    data['contact_person_name'] = contactPersonName;
    data['contact_person_phone'] = contactPersonPhone;
    data['contact_person_email'] = contactPersonEmail;
    data['order_count'] = orderCount;
    data['service_man_count'] = serviceManCount;
    data['service_capacity_per_day'] = serviceCapacityPerDay;
    data['rating_count'] = ratingCount;
    data['avg_rating'] = avgRating;
    data['commission_status'] = commissionStatus;
    data['commission_percentage'] = commissionPercentage;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_approved'] = isApproved;
    data['zone_id'] = zoneId;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class SubCategories {
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
  List<Service>? services;

  SubCategories(
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
        this.services});

  SubCategories.fromJson(Map<String, dynamic> json) {
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
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(Service.fromJson(v));
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
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}





