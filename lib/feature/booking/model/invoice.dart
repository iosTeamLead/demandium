
class Invoice {
  final InvoiceInfo info;
  final Provider provider;
  final Serviceman serviceman;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.provider,
    required this.serviceman,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final String paymentStatus;


  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.paymentStatus,
  });
}

class InvoiceItem {
  final String serviceName;
  final int quantity;
  final String ? discountAmount;
  final String ? tax;
  final String ? unitAllTotal;
  final String ? unitPrice;
  const InvoiceItem({
    required this.discountAmount,
    required this.tax,
    required this.serviceName,
    required this.quantity,
    required this.unitAllTotal,
    required this.unitPrice,
  });
}


class InvoiceTotal {
  double allTotalAmountWithVatDis =0.0;
  double allTotal=0.0;
  double totalTax=0.0;
  double totalDiscount=0.0;
  InvoiceTotal({
    required this.allTotalAmountWithVatDis,
    required this.allTotal,
    required this.totalTax,
    required this.totalDiscount,
  });
}

class Supplier {
  final String name;
  final String address;
  final String paymentInfo;

  const Supplier({
    required this.name,
    required this.address,
    required this.paymentInfo,
  });
}

class Provider{
  final String name;
  final String address;
  final String phone;

  Provider({
    required this.name,
    required this.address,
    required this.phone,
  });
}

class Serviceman{
  final String name;
  final String phone;

  Serviceman({
    required this.name,
    required this.phone,
  });
}