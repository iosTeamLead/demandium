import 'package:flutter/material.dart';

class CategoryModel {
  String? id;
  String? parentId;
  String? name;
  String? image;
  int? position;
  String? description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? serviceCount;
  GlobalKey? globalKey;

  CategoryModel(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.position,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.serviceCount,
        this.globalKey,
      });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    description = json['description'];
    isActive = int.tryParse(json['is_active'].toString()) == 1 ? true : false;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceCount = int.tryParse(json['services_count'].toString());
    globalKey = GlobalKey(debugLabel: json['id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['name'] = name;
    data['image'] = image;
    data['position'] = position;
    data['description'] = description;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['services_count'] = serviceCount;
    return data;
  }
}
