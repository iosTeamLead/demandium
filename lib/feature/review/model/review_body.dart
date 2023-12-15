class ReviewBody {
  String? _bookingID;
  String? _serviceID;
  String? _rating;
  String? _comment;

  ReviewBody(
      {
        required String bookingID,
        required String serviceID,
        required String rating,
        required String comment,
      }) {
    _bookingID = bookingID;
    _serviceID = serviceID;
    _rating = rating;
    _comment = comment;
  }

  ReviewBody.fromJson(Map<String, dynamic> json) {
    _bookingID = json['booking_id'];
    _serviceID = json['service_id'];
    _comment = json['review_comment'];
    _rating = json['review_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_id'] = _bookingID;
    data['service_id'] = _serviceID;
    data['review_comment'] = _comment;
    data['review_rating'] = _rating;
    return data;
  }
}
