import 'package:demandium/feature/provider/model/provider_model.dart';
import 'package:demandium/feature/booking/model/service_booking_model.dart';
import 'package:demandium/feature/suggest_new_service/model/suggest_service_model.dart';
import '../../service/model/service_model.dart';

class PostModel {
  String? responseCode;
  String? message;
  Content? content;


  PostModel({this.responseCode, this.message, this.content});

  PostModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? Content.fromJson(json['content']) : null;
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

class Content {
  int? currentPage;
  List<MyPostData>? data;
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
      data = <MyPostData>[];
      json['data'].forEach((v) {
        data!.add(MyPostData.fromJson(v));
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

class MyPostData {
  String? id;
  String? serviceDescription;
  String? bookingSchedule;
  int? isBooked;
  String? customerUserId;
  String? serviceId;
  String? categoryId;
  String? subCategoryId;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  int? bidsCount;
  List<AdditionInstructions>? additionInstructions;
  Service? service;
  Category? category;
  SubCategory? subCategory;
  BookingModel? booking;

  MyPostData(
      {this.id,
        this.serviceDescription,
        this.bookingSchedule,
        this.isBooked,
        this.customerUserId,
        this.serviceId,
        this.categoryId,
        this.subCategoryId,
        this.serviceAddressId,
        this.createdAt,
        this.updatedAt,
        this.bidsCount,
        this.additionInstructions,
        this.service,
        this.category,
        this.subCategory,
        this.booking
      });

  MyPostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceDescription = json['service_description'];
    bookingSchedule = json['booking_schedule'];
    isBooked = int.tryParse(json['is_booked'].toString());
    customerUserId = json['customer_user_id'];
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bidsCount = int.tryParse(json['bids_count'].toString());
    if (json['addition_instructions'] != null) {
      additionInstructions = <AdditionInstructions>[];
      json['addition_instructions'].forEach((v) {
        additionInstructions!.add(AdditionInstructions.fromJson(v));
      });
    }
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    subCategory = json['sub_category'] != null
        ? SubCategory.fromJson(json['sub_category'])
        : null;

    booking= json['booking'] != null
        ? BookingModel.fromJson(json['booking'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_description'] = serviceDescription;
    data['booking_schedule'] = bookingSchedule;
    data['is_booked'] = isBooked;
    data['customer_user_id'] = customerUserId;
    data['service_id'] = serviceId;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['service_address_id'] = serviceAddressId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bids_count'] = bidsCount;
    if (additionInstructions != null) {
      data['addition_instructions'] =
          additionInstructions!.map((v) => v.toJson()).toList();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (subCategory != null) {
      data['sub_category'] = subCategory!.toJson();
    }
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    return data;
  }
}

class AdditionInstructions {
  String? id;
  String? details;
  String? postId;
  String? createdAt;
  String? updatedAt;

  AdditionInstructions(
      {this.id, this.details, this.postId, this.createdAt, this.updatedAt});

  AdditionInstructions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['details'] = details;
    data['post_id'] = postId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

