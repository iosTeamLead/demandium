import 'package:demandium/feature/address/model/address_model.dart';
import 'package:demandium/feature/create_post/model/my_post_model.dart';
import 'package:demandium/feature/provider/model/provider_model.dart';
import '../../service/model/service_model.dart';
import '../../suggest_new_service/model/suggest_service_model.dart';

class PostDetailsModel {
  PostDetailsContent? content;


  PostDetailsModel({ this.content});

  PostDetailsModel.fromJson(Map<String, dynamic> json) {
    content = json['content'] != null ? PostDetailsContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class PostDetailsContent {
  String? id;
  String? serviceDescription;
  String? bookingSchedule;
  int? isBooked;
  String? customerUserId;
  String? serviceId;
  String? categoryId;
  String? subCategoryId;
  String? serviceAddressId;
  String? bookingId;
  String? createdAt;
  String? updatedAt;
  int? bidsCount;
  List<AdditionInstructions>? additionInstructions;
  Service? service;
  Category? category;
  SubCategory? subCategory;
  //Booking? booking;
  AddressModel? serviceAddress;
  //List<Null>? bids;

  PostDetailsContent(
      {this.id,
        this.serviceDescription,
        this.bookingSchedule,
        this.isBooked,
        this.customerUserId,
        this.serviceId,
        this.categoryId,
        this.subCategoryId,
        this.serviceAddressId,
        this.bookingId,
        this.createdAt,
        this.updatedAt,
        this.bidsCount,
        this.additionInstructions,
        this.service,
        this.category,
        this.subCategory,
        //this.booking,
        this.serviceAddress,
        //this.bids
      });

  PostDetailsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceDescription = json['service_description'];
    bookingSchedule = json['booking_schedule'];
    isBooked = json['is_booked'];
    customerUserId = json['customer_user_id'];
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    serviceAddressId = json['service_address_id'];
    bookingId = json['booking_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bidsCount = json['bids_count'];

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
    //booking = json['booking'];
    serviceAddress = json['service_address'] != null
        ? AddressModel.fromJson(json['service_address'])
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
    data['booking_id'] = bookingId;
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
   // data['booking'] = booking;
    if (serviceAddress != null) {
      data['service_address'] = serviceAddress!.toJson();
    }
    return data;
  }
}
