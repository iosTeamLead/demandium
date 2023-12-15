class AddressModel {
  String? id;
  String? addressLabel;
  String? addressType;
  String? userId;
  String? address;
  String? latitude;
  String? longitude;
  String? city;
  String? zipCode;
  String? country;
  String? zoneId;
  String? method;
  String? contactPersonName;
  String? contactPersonNumber;
  String? contactPersonLabel;
  String? street;
  String? house;
  String? floor;

  AddressModel(
      {this.id,
        this.addressType,
        this.addressLabel,
        this.userId,
        this.address,
        this.latitude,
        this.longitude,
        this.city,
        this.zipCode,
        this.country,
        this.zoneId,
        this.method,
        this.contactPersonName,
        this.contactPersonNumber,
        this.contactPersonLabel,
        this.street,
        this.house,
        this.floor
      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'];
    contactPersonNumber = json['contact_person_number'];
    address = json['address'];
    addressType = json['address_type'];
    addressLabel = json['address_label'];
    latitude = json['lat'];
    longitude = json['lon'];
    city = json['city'];
    zipCode = json['zip_code'];
    country = json['country'];
    zoneId = json['zone_id'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    contactPersonLabel = json['address_label'];
    street = json['street'];
    house = json['house'];
    floor = json['floor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address_type'] = addressType;
    data['address_label'] = addressLabel;
    data['contact_person_name'] = contactPersonName;
    data['contact_person_number'] = contactPersonNumber;
    data['address'] = address;
    data['lat'] = latitude;
    data['lon'] = longitude;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['country'] = country;
    data['zone_id'] = zoneId;
    data['address_label'] = addressLabel;
    data['contact_person_name'] = contactPersonName;
    data['_method'] = method;
    data['street'] = street;
    data['house'] = house;
    data['floor'] = floor;
    return data;
  }
}
