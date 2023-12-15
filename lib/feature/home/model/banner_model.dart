class BannerContentModel {
  int? _currentPage;
  List<BannerModel>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  String? _path;
  String? _perPage;
  int? _to;
  int? _total;

  BannerContentModel(
      {int? currentPage,
        List<BannerModel>? data,
        String? firstPageUrl,
        int? from,
        int? lastPage,
        String? lastPageUrl,
        List<Links>? links,
        String? path,
        String? perPage,
        int? to,
        int? total}) {
    if (currentPage != null) {
      _currentPage = currentPage;
    }
    if (data != null) {
      _data = data;
    }
    if (firstPageUrl != null) {
      _firstPageUrl = firstPageUrl;
    }
    if (from != null) {
      _from = from;
    }
    if (lastPage != null) {
      _lastPage = lastPage;
    }
    if (lastPageUrl != null) {
      _lastPageUrl = lastPageUrl;
    }
    if (links != null) {
      _links = links;
    }

    if (path != null) {
      _path = path;
    }
    if (perPage != null) {
      _perPage = perPage;
    }

    if (to != null) {
      _to = to;
    }
    if (total != null) {
      _total = total;
    }
  }

  int? get currentPage => _currentPage;
  List<BannerModel>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  String? get path => _path;
  String? get perPage => _perPage;
  int? get to => _to;
  int? get total => _total;

  BannerContentModel.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = <BannerModel>[];
      json['data'].forEach((v) {
        _data!.add(BannerModel.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = <Links>[];
      json['links'].forEach((v) {
        _links!.add(Links.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = _currentPage;
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = _firstPageUrl;
    data['from'] = _from;
    data['last_page'] = _lastPage;
    data['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      data['links'] = _links!.map((v) => v.toJson()).toList();
    }
    data['path'] = _path;
    data['per_page'] = _perPage;
    data['to'] = _to;
    data['total'] = _total;
    return data;
  }
}

class BannerModel {
  String? _id;
  String? _bannerTitle;
  String? _resourceType;
  String? _resourceId;
  String? _redirectLink;
  String? _bannerImage;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;
  Service? _service;
  Category? _category;

  BannerModel(
      {String? id,
        String? bannerTitle,
        String? resourceType,
        String? resourceId,
        String? redirectLink,
        String? bannerImage,
        int? isActive,
        String? createdAt,
        String? updatedAt,
        Service? service,
        Category? category}) {
    if (id != null) {
      _id = id;
    }
    if (bannerTitle != null) {
      _bannerTitle = bannerTitle;
    }
    if (resourceType != null) {
      _resourceType = resourceType;
    }
    if (resourceId != null) {
      _resourceId = resourceId;
    }
    if (redirectLink != null) {
      _redirectLink = redirectLink;
    }
    if (bannerImage != null) {
      _bannerImage = bannerImage;
    }
    if (isActive != null) {
      _isActive = isActive;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (service != null) {
      _service = service;
    }
    if (category != null) {
      _category = category;
    }
  }

  String? get id => _id;
  String? get bannerTitle => _bannerTitle;
  String? get resourceType => _resourceType;
  String? get resourceId => _resourceId;
  String? get redirectLink => _redirectLink;
  String? get bannerImage => _bannerImage;
  int? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Service? get service => _service;
  Category? get category => _category;


  BannerModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _bannerTitle = json['banner_title'];
    _resourceType = json['resource_type'];
    _resourceId = json['resource_id'];
    _redirectLink = json['redirect_link'];
    _bannerImage = json['banner_image'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
    _category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['banner_title'] = _bannerTitle;
    data['resource_type'] = _resourceType;
    data['resource_id'] = _resourceId;
    data['redirect_link'] = _redirectLink;
    data['banner_image'] = _bannerImage;
    data['is_active'] = _isActive;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    if (_service != null) {
      data['service'] = _service!.toJson();
    }
    if (_category != null) {
      data['category'] = _category!.toJson();
    }
    return data;
  }
}

class Service {
  String? _id;
  String? _name;
  String? _shortDescription;
  String? _description;
  String? _coverImage;
  String? _thumbnail;
  String? _categoryId;
  String? _subCategoryId;
  int? _tax;
  int? _orderCount;
  int? _isActive;
  int? _ratingCount;
  double? _avgRating;


  Service(
      {String? id,
        String? name,
        String? shortDescription,
        String? description,
        String? coverImage,
        String? thumbnail,
        String? categoryId,
        String? subCategoryId,
        int? tax,
        int? orderCount,
        int? isActive,
        int? ratingCount,
        double? avgRating,
        String? createdAt,
        String? updatedAt,
        List<void>? serviceDiscount,
        List<void>? campaignDiscount}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (shortDescription != null) {
      _shortDescription = shortDescription;
    }
    if (description != null) {
      _description = description;
    }
    if (coverImage != null) {
      _coverImage = coverImage;
    }
    if (thumbnail != null) {
      _thumbnail = thumbnail;
    }
    if (categoryId != null) {
      _categoryId = categoryId;
    }
    if (subCategoryId != null) {
      _subCategoryId = subCategoryId;
    }
    if (tax != null) {
      _tax = tax;
    }
    if (orderCount != null) {
      _orderCount = orderCount;
    }
    if (isActive != null) {
      _isActive = isActive;
    }
    if (ratingCount != null) {
      _ratingCount = ratingCount;
    }
    if (avgRating != null) {
      _avgRating = avgRating;
    }
  }

  String? get id => _id;
  String? get name => _name;
  String? get shortDescription => _shortDescription;
  String? get description => _description;
  String? get coverImage => _coverImage;
  String? get thumbnail => _thumbnail;
  String? get categoryId => _categoryId;
  String? get subCategoryId => _subCategoryId;
  int? get tax => _tax;
  int? get orderCount => _orderCount;
  int? get isActive => _isActive;
  int? get ratingCount => _ratingCount;
  double? get avgRating => _avgRating;


  Service.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _shortDescription = json['short_description'];
    _description = json['description'];
    _coverImage = json['cover_image'];
    _thumbnail = json['thumbnail'];
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _tax = json['tax'];
    _orderCount = json['order_count'];
    _isActive = json['is_active'];
    _ratingCount = json['rating_count'];
    _avgRating = double.tryParse(json['avg_rating'].toString());

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['short_description'] = _shortDescription;
    data['description'] = _description;
    data['cover_image'] = _coverImage;
    data['thumbnail'] = _thumbnail;
    data['category_id'] = _categoryId;
    data['sub_category_id'] = _subCategoryId;
    data['tax'] = _tax;
    data['order_count'] = _orderCount;
    data['is_active'] = _isActive;
    data['rating_count'] = _ratingCount;
    data['avg_rating'] = _avgRating;
    return data;
  }
}

class Category {
  String? _id;
  String? _parentId;
  String? _name;
  String? _image;
  int? _position;
  int? _isActive;

  Category(
      {String? id,
        String? parentId,
        String? name,
        String? image,
        int? position,
        int? isActive,
       }) {
    if (id != null) {
      _id = id;
    }
    if (parentId != null) {
      _parentId = parentId;
    }
    if (name != null) {
      _name = name;
    }
    if (image != null) {
      _image = image;
    }
    if (position != null) {
      _position = position;
    }

    if (isActive != null) {
      _isActive = isActive;
    }

  }

  String? get id => _id;
  String? get parentId => _parentId;
  String? get name => _name;
  String? get image => _image;
  int? get position => _position;
  int? get isActive => _isActive;


  Category.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _image = json['image'];
    _position = json['position'];
    _isActive = json['is_active'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['parent_id'] = _parentId;
    data['name'] = _name;
    data['image'] = _image;
    data['position'] = _position;
    data['is_active'] = _isActive;
    return data;
  }
}


class Links {
  String? _url;
  String? _label;
  bool? _active;

  Links({String? url, String? label, bool? active}) {
    if (url != null) {
      _url = url;
    }
    if (label != null) {
      _label = label;
    }
    if (active != null) {
      _active = active;
    }
  }

  String? get url => _url;
  String? get label => _label;
  bool? get active => _active;


  Links.fromJson(Map<String, dynamic> json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = _url;
    data['label'] = _label;
    data['active'] = _active;
    return data;
  }
}
