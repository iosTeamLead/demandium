import 'package:demandium/core/common_model/user_model.dart';

class Serviceman {
  String? id;
  String? providerId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  User? user;


  Serviceman(
      {this.id,
        this.providerId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user,
      });

  Serviceman.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_id'] = providerId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}