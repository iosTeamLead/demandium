class BookingReviewModel {
  String? id;
  String? bookingId;
  String? serviceId;
  int? reviewRating;
  String? reviewComment;
  int? isActive;
  Booking? booking;
  Service? service;

  BookingReviewModel(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.reviewRating,
        this.reviewComment,
        this.isActive,
        this.booking,
        this.service});

  BookingReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    reviewRating = json['review_rating'];
    reviewComment = json['review_comment'];
    isActive = json['is_active'];
    booking =
    json['booking'] != null ? Booking.fromJson(json['booking']) : null;
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['service_id'] = serviceId;
    data['review_rating'] = reviewRating;
    data['review_comment'] = reviewComment;
    data['is_active'] = isActive;
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}

class Booking {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  List<Detail>? detail;

  Booking(
      {this.id,
        this.readableId,
        this.customerId,
        this.providerId,
        this.zoneId,
        this.bookingStatus,
        this.detail});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable_id'] = readableId;
    data['customer_id'] = customerId;
    data['provider_id'] = providerId;
    data['zone_id'] = zoneId;
    data['booking_status'] = bookingStatus;
    if (detail != null) {
      data['detail'] = detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int? id;
  String? bookingId;
  String? serviceId;
  String? serviceName;
  String? variantKey;
  Variation? variation;

  Detail(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.serviceName,
        this.variantKey,
        this.variation});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    variantKey = json['variant_key'];
    variation = json['variation'] != null
        ? Variation.fromJson(json['variation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    data['variant_key'] = variantKey;
    if (variation != null) {
      data['variation'] = variation!.toJson();
    }
    return data;
  }
}

class Variation {
  int? id;
  String? variant;
  String? variantKey;
  String? serviceId;

  Variation(
      {this.id,
        this.variant,
        this.variantKey,
        this.serviceId,
      });

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variant = json['variant'];
    variantKey = json['variant_key'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['variant'] = variant;
    data['variant_key'] = variantKey;
    data['service_id'] = serviceId;
    return data;
  }
}

class Service {
  String? id;
  String? name;
  String? shortDescription;
  String? description;
  String? coverImage;
  String? thumbnail;
  Service(
      {this.id,
        this.name,
        this.shortDescription,
        this.description,
        this.coverImage,
        this.thumbnail,
       });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    coverImage = json['cover_image'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['cover_image'] = coverImage;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
