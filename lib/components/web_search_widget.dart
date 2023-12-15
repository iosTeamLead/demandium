import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class SearchWidgetWeb extends GetView<AllSearchController> {
  const SearchWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSearchController>(
      builder: (searchController){
        return Center(child: Padding(
            padding: const EdgeInsets.only(top:Dimensions.paddingSizeExtraSmall,left: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
            child: SizedBox(
                height: Dimensions.searchbarSize,
                width: 350,
                child: TextField(
                  onTap: () => Get.offNamed(RouteHelper.getSearchResultRoute()),
                  controller: controller.searchController,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeSmall,
                  ),

                  cursorColor: Theme.of(context).hintColor,
                  autofocus: false,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.search,
                  onChanged: (text) => searchController.showSuffixIcon(context,text),
                  onSubmitted: (value){
                    if(value.isNotEmpty) {
                      controller.navigateToSearchResultScreen();
                    }
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(10,),left: Radius.circular(10)),
                      borderSide: BorderSide(style: BorderStyle.none, width: 0),
                    ),
                    fillColor: Get.isDarkMode
                        ? Theme.of(context).hintColor.withOpacity(0.2)
                        : Theme.of(context).primaryColorDark.withOpacity(0.06),
                    isDense: true,
                    hintText: 'search_services_near_you'.tr,
                    hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                    filled: true,
                    prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: Icon(Icons.search,color: Theme.of(context).hintColor,),
                    ),
                    suffixIcon: searchController.isActiveSuffixIcon ? IconButton(
                      color: Get.isDarkMode? light.cardColor.withOpacity(0.8) :Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        if(searchController.searchController.text.trim().isNotEmpty) {
                          searchController.clearSearchController();
                        }
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(
                          Icons.cancel_outlined,
                      ),
                    ) : const SizedBox(),
                  ),
                )
            )));
      },
    );
  }
}
