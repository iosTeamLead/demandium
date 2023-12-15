import 'package:demandium/feature/service/controller/service_controller.dart';
import 'package:get/get.dart';
import '../../service/model/service_model.dart';

class CategoryModelItem {
  String title;
  List<Service> serviceList;

  CategoryModelItem({
    required this.title,
    required this.serviceList,
  });
}


class ExampleData {
  ExampleData._internal();

  static List<CategoryModelItem> data =
  [
    category1,
    category2,
    category3,
    category4,
  ];

  static CategoryModelItem category1 = CategoryModelItem(
      title: "popular",
      serviceList: Get.find<ServiceController>().popularServiceList??[]
  );

  static CategoryModelItem category2 = CategoryModelItem(
      title: "Category 2",
      serviceList: Get.find<ServiceController>().recommendedServiceList??[]
  );

  static CategoryModelItem category3 = CategoryModelItem(
      title: "Category 3",
      serviceList: Get.find<ServiceController>().allService??[]
  );

  static CategoryModelItem category4 = CategoryModelItem(
      title: "Category 4",
      serviceList: Get.find<ServiceController>().trendingServiceList??[]
  );
}