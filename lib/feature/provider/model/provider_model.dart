class ProviderModel {
  Content? content;
  ProviderModel({this.content});

  ProviderModel.fromJson(Map<String, dynamic> json) {

    content =
    json['content'] != null ? Content.fromJson(json['content']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class Content {
  int? currentPage;
  List<ProviderData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  String? perPage;
  int? to;
  int? total;

  Content(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Content.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ProviderData>[];
      json['data'].forEach((v) {
        data!.add(ProviderData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class ProviderData {
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
  int? commissionPercentage;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? isApproved;
  String? zoneId;
  Owner? owner;
  List<SubscribedServices>? subscribedServices;

  ProviderData(
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
        this.subscribedServices});

  ProviderData.fromJson(Map<String, dynamic> json) {
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
    commissionPercentage = json['commission_percentage'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isApproved = json['is_approved'];
    zoneId = json['zone_id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    if (json['subscribed_services'] != null) {
      subscribedServices = <SubscribedServices>[];
      json['subscribed_services'].forEach((v) {
        subscribedServices!.add(SubscribedServices.fromJson(v));
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
    if (subscribedServices != null) {
      data['subscribed_services'] =
          subscribedServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationNumber;
  String? identificationType;
  List<String>? identificationImage;
  String? gender;
  String? profileImage;
  String? fcmToken;
  int? isPhoneVerified;
  int? isEmailVerified;
  int? isActive;
  String? userType;
  String? createdAt;
  String? updatedAt;
  int? walletBalance;
  int? loyaltyPoint;

  Owner(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.identificationNumber,
        this.identificationType,
        this.identificationImage,
        this.gender,
        this.profileImage,
        this.fcmToken,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.isActive,
        this.userType,
        this.createdAt,
        this.updatedAt,
        this.walletBalance,
        this.loyaltyPoint,
     });

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];
    identificationImage = json['identification_image'].cast<String>();
    gender = json['gender'];
    profileImage = json['profile_image'];
    fcmToken = json['fcm_token'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    isActive = json['is_active'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    walletBalance = json['wallet_balance'];
    loyaltyPoint = json['loyalty_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['identification_number'] = identificationNumber;
    data['identification_type'] = identificationType;
    data['identification_image'] = identificationImage;
    data['gender'] = gender;
    data['profile_image'] = profileImage;
    data['fcm_token'] = fcmToken;
    data['is_phone_verified'] = isPhoneVerified;
    data['is_email_verified'] = isEmailVerified;
    data['is_active'] = isActive;
    data['user_type'] = userType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['wallet_balance'] = walletBalance;
    data['loyalty_point'] = loyaltyPoint;
    return data;
  }
}

class SubscribedServices {
  String? id;
  String? providerId;
  String? categoryId;
  String? subCategoryId;
  int? isSubscribed;
  String? createdAt;
  String? updatedAt;
  SubCategory? subCategory;

  SubscribedServices(
      {this.id,
        this.providerId,
        this.categoryId,
        this.subCategoryId,
        this.isSubscribed,
        this.createdAt,
        this.updatedAt,
        this.subCategory});

  SubscribedServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    isSubscribed = json['is_subscribed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subCategory = json['sub_category'] != null
        ? SubCategory.fromJson(json['sub_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_id'] = providerId;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['is_subscribed'] = isSubscribed;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subCategory != null) {
      data['sub_category'] = subCategory!.toJson();
    }
    return data;
  }
}

class SubCategory {
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

  SubCategory(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.position,
        this.description,
        this.isActive,
        this.isFeatured,
        this.createdAt,
        this.updatedAt});

  SubCategory.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
