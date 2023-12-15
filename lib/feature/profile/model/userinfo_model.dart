class UserInfoModel {
  String? id;
  String? fName;
  String? lName;
  String? email;
  String? image;
  String? phone;
  String? password;
  String? confirmPassword;
  String? createdAt;
  num? bookingsCount;
  String? referCode;
  String? referredBy;

  UserInfoModel(
      {this.id,
        this.fName,
        this.lName,
        this.email,
        this.image,
        this.phone,
        this.password,
        this.confirmPassword,
        this.createdAt,
        this.bookingsCount,
        this.referCode,
        this.referredBy
      });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['first_name'];
    lName = json['last_name'];
    email = json['email'];
    image = json['profile_image'];
    phone = json['phone'];
    createdAt = json['created_at'];
    referCode = json['ref_code'];
    referredBy = json['referred_by'];
    bookingsCount = json['bookings_count'] != null ? int.parse(json['bookings_count'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = fName;
    data['last_name'] = lName;
    data['email'] = email;
    data['profile_image'] = image;
    data['phone'] = phone;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    data['ref_code'] = referCode;
    data['referred_by'] = referredBy;
    return data;
  }
}
