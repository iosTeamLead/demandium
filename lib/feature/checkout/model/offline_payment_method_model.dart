class OfflinePaymentModel {
  String? id;
  String? methodName;
  List<PaymentInformation>? paymentInformation;
  List<CustomerInformation>? customerInformation;

  OfflinePaymentModel(
      {this.id,
        this.methodName,
        this.paymentInformation,
        this.customerInformation});

  OfflinePaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodName = json['method_name'];
    if (json['payment_information'] != null) {
      paymentInformation = <PaymentInformation>[];
      json['payment_information'].forEach((v) {
        paymentInformation!.add(PaymentInformation.fromJson(v));
      });
    }
    if (json['customer_information'] != null) {
      customerInformation = <CustomerInformation>[];
      json['customer_information'].forEach((v) {
        customerInformation!.add(CustomerInformation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['method_name'] = methodName;
    if (paymentInformation != null) {
      data['payment_information'] =
          paymentInformation!.map((v) => v.toJson()).toList();
    }
    if (customerInformation != null) {
      data['customer_information'] =
          customerInformation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentInformation {
  String? title;
  String? data;

  PaymentInformation({this.title, this.data});

  PaymentInformation.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['data'] = this.data;
    return data;
  }
}

class CustomerInformation {
  String? paymentNote;
  String? fieldName;
  String? placeholder;
  int? isRequired;

  CustomerInformation(
      {this.paymentNote, this.fieldName, this.placeholder, this.isRequired});

  CustomerInformation.fromJson(Map<String, dynamic> json) {
    paymentNote = json['payment_note'];
    fieldName = json['field_name'];
    placeholder = json['placeholder'];
    isRequired = int.tryParse(json['is_required'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_note'] = paymentNote;
    data['field_name'] = fieldName;
    data['placeholder'] = placeholder;
    data['is_required'] = isRequired;
    return data;
  }
}
