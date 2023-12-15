import 'package:demandium/core/common_model/provider_model.dart';

///conversation user for channel model and for conversation model
class ConversationUserModel {
  String? id;
  String? channelId;
  String? userId;
  String?  deletedAt;
  String?  createdAt;
  String?  updatedAt;
  int? isRead;
  ConversationUser? user;

  ConversationUserModel(
      {this.id,
        this.channelId,
        this.userId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.isRead
      });

  ConversationUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelId = json['channel_id'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? ConversationUser.fromJson(json['user']) : null;
    isRead= json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['channel_id'] = channelId;
    data['user_id'] = userId;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ConversationUser {
  String? id;
  String?  roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String?  identificationNumber;
  String? identificationType;
  String?  dateOfBirth;
  String? gender;
  String? profileImage;
  String? fcmToken;
  int? isPhoneVerified;
  int? isEmailVerified;
  String?  phoneVerifiedAt;
  String?  emailVerifiedAt;
  int? isActive;
  String? userType;
  String?  rememberToken;
  String?  deletedAt;
  String? createdAt;
  String? updatedAt;
  ProviderModel? provider;


  ConversationUser(
      {this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.identificationNumber,
        this.identificationType,
        this.dateOfBirth,
        this.gender,
        this.profileImage,
        this.fcmToken,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.phoneVerifiedAt,
        this.emailVerifiedAt,
        this.isActive,
        this.userType,
        this.rememberToken,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.provider,
      });

  ConversationUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];

    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    fcmToken = json['fcm_token'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    phoneVerifiedAt = json['phone_verified_at'];
    emailVerifiedAt = json['email_verified_at'];
    isActive = json['is_active'];
    userType = json['user_type'];
    rememberToken = json['remember_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    provider = json['provider'] != null ? ProviderModel.fromJson(json['provider']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_id'] = roleId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['identification_number'] = identificationNumber;
    data['identification_type'] = identificationType;

    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['profile_image'] = profileImage;
    data['fcm_token'] = fcmToken;
    data['is_phone_verified'] = isPhoneVerified;
    data['is_email_verified'] = isEmailVerified;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_active'] = isActive;
    data['user_type'] = userType;
    data['remember_token'] = rememberToken;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}