import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';
import 'search_initial_screen.dart';

class ItemView extends GetView<AllSearchController> {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSearchController>(
        builder: (searchController) {
          if(searchController.isSearchComplete){
            return SizedBox(
                width: Dimensions.webMaxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    if(searchController.searchServiceList != null && searchController.searchServiceList!.isNotEmpty)
                      Container(
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical:  Dimensions.paddingSizeDefault),
                            child: Text(
                              "${searchController.searchServiceList!.length} ${'results_found'.tr}",
                              style: ubuntuRegular.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: Dimensions.fontSizeLarge,),),),),),
                    if(searchController.searchServiceList != null && searchController.searchServiceList!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: Text('services'.tr, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,),),),
                    ServiceViewVertical(
                      service: searchController.searchServiceList!,
                      noDataText: 'no_service_found'.tr,
                      noDataType: NoDataType.search,
                      fromPage:"search_page"
                    ),
                  ],
                ));
          }else{
            return const SearchSuggestion();
          }

    });
  }
}
