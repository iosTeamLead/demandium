class CampaignContent {
  int? currentPage;
  List<CampaignData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  CampaignContent(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  CampaignContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CampaignData>[];
      json['data'].forEach((v) {
        data!.add(CampaignData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
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
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class CampaignData {
  String? id;
  String? campaignName;
  String? coverImage;
  String? thumbnail;
  String? discountId;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Discount? discount;

  CampaignData(
      {this.id,
        this.campaignName,
        this.coverImage,
        this.thumbnail,
        this.discountId,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.discount});

  CampaignData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignName = json['campaign_name'];
    coverImage = json['cover_image'];
    thumbnail = json['thumbnail'];
    discountId = json['discount_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discount = json['discount'] != null
        ? Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['campaign_name'] = campaignName;
    data['cover_image'] = coverImage;
    data['thumbnail'] = thumbnail;
    data['discount_id'] = discountId;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (discount != null) {
      data['discount'] = discount!.toJson();
    }
    return data;
  }
}

class Discount {
  String? id;
  String? discountTitle;
  String? discountType;
  int? discountAmount;
  String? discountAmountType;
  int? minPurchase;
  double? maxDiscountAmount;
  int? limitPerUser;
  String? promotionType;
  int? isActive;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  Discount(
      {this.id,
        this.discountTitle,
        this.discountType,
        this.discountAmount,
        this.discountAmountType,
        this.minPurchase,
        this.maxDiscountAmount,
        this.limitPerUser,
        this.promotionType,
        this.isActive,
        this.startDate,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  Discount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountTitle = json['discount_title'];
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
    discountAmountType = json['discount_amount_type'];
    minPurchase = json['min_purchase'];
    maxDiscountAmount = double.tryParse(json['max_discount_amount'].toString());
    limitPerUser = json['limit_per_user'];
    promotionType = json['promotion_type'];
    isActive = json['is_active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['discount_title'] = discountTitle;
    data['discount_type'] = discountType;
    data['discount_amount'] = discountAmount;
    data['discount_amount_type'] = discountAmountType;
    data['min_purchase'] = minPurchase;
    data['max_discount_amount'] = maxDiscountAmount;
    data['limit_per_user'] = limitPerUser;
    data['promotion_type'] = promotionType;
    data['is_active'] = isActive;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
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