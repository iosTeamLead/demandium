import '../../../components/core_export.dart';

class ReviewModel {
  String? responseCode;
  String? message;
  ReviewContent? content;

  ReviewModel({this.responseCode, this.message, this.content});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? ReviewContent.fromJson(json['content']) : null;
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

class ReviewContent {
  Reviews? reviews;
  Rating? rating;

  ReviewContent({this.reviews, this.rating});

  ReviewContent.fromJson(Map<String, dynamic> json) {
    reviews =
    json['reviews'] != null ? Reviews.fromJson(json['reviews']) : null;
    rating =
    json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviews != null) {
      data['reviews'] = reviews!.toJson();
    }
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    return data;
  }
}

class Reviews {
  int? currentPage;
  List<ReviewData>? reviewList;
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

  Reviews(
      {this.currentPage,
        this.reviewList,
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

  Reviews.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      reviewList = <ReviewData>[];
      json['data'].forEach((v) {
        reviewList!.add(ReviewData.fromJson(v));
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
    if (reviewList != null) {
      data['data'] = reviewList!.map((v) => v.toJson()).toList();
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

class ReviewData {
  String? id;
  String? bookingId;
  String? serviceId;
  String? providerId;
  double? reviewRating;
  String? reviewComment;
  String? bookingDate;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  ReviewData(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.providerId,
        this.reviewRating,
        this.reviewComment,
        this.bookingDate,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.customer,
      });

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    providerId = json['provider_id'];
    reviewRating = json['review_rating'].toDouble();
    reviewComment = json['review_comment'];
    bookingDate = json['booking_date'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['service_id'] = serviceId;
    data['provider_id'] = providerId;
    data['review_rating'] = reviewRating;
    data['review_comment'] = reviewComment;
    data['booking_date'] = bookingDate;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}
class Rating {
  num? ratingCount;
  num? averageRating;
  List<RatingGroupCount>? ratingGroupCount;

  Rating({this.ratingCount, this.averageRating, this.ratingGroupCount});

  Rating.fromJson(Map<String, dynamic> json) {
    ratingCount = json['rating_count'];
    averageRating = json['average_rating'];
    if (json['rating_group_count'] != null) {
      ratingGroupCount = <RatingGroupCount>[];
      json['rating_group_count'].forEach((v) {
        ratingGroupCount!.add(RatingGroupCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating_count'] = ratingCount;
    data['average_rating'] = averageRating;
    if (ratingGroupCount != null) {
      data['rating_group_count'] =
          ratingGroupCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatingGroupCount {
  double? reviewRating;
  double? total;

  RatingGroupCount({this.reviewRating, this.total});

  RatingGroupCount.fromJson(Map<String, dynamic> json) {
    reviewRating = json['review_rating'] != null ? double.parse(json['review_rating'].toString()) : null;
    total = json['total'] != null ? double.parse(json['total'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_rating'] = reviewRating;
    data['total'] = total;
    return data;
  }
}