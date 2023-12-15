
class CreatePostBody {
  String? serviceId;
  String? categoryId;
  String? subCategoryId;
  String? addressId;
  String? serviceDescription;
  String? serviceSchedule;
  String? serviceAddress;
  List<String>? additionDescriptions;

  CreatePostBody({this.serviceId, this.categoryId,this.subCategoryId, this.addressId, this.serviceDescription, this.serviceSchedule,this.additionDescriptions, this.serviceAddress});

  CreatePostBody.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    addressId = json['service_address_id'];
    serviceAddress = json['service_address'];
    serviceDescription = json['service_description'];
    serviceDescription = json['booking_schedule'];
    additionDescriptions = json['additional_instructions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['service_address_id'] = addressId;
    data['service_address'] = serviceAddress;
    data['service_description'] = serviceDescription;
    data['booking_schedule'] = serviceSchedule;
    data['additional_instructions'] = additionDescriptions;

    return data;
  }
}
