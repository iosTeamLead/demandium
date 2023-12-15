import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class SearchWidget extends StatelessWidget {
   const SearchWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSearchController>(
      builder: (searchController){
        return Center(child: Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault,left: Dimensions.paddingSizeSmall),
            child: SizedBox(
                height: Dimensions.searchbarSize,
                child: TextField(
                  controller: searchController.searchController,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,
                  ),
                  cursorColor: Theme.of(context).hintColor,
                  autofocus: false,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 22),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(20,),left: Radius.circular(20)),
                      borderSide: BorderSide(style: BorderStyle.none, width: 0),
                    ),
                    fillColor: Get.isDarkMode? Theme.of(context).primaryColorDark:const Color(0xffFEFEFE),
                    isDense: true,
                    hintText: 'search_services'.tr,
                    hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).hintColor),
                    filled: true,
                    prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
                    suffixIcon: searchController.isActiveSuffixIcon ? IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        if(searchController.searchController.text.trim().isNotEmpty) {
                          searchController.clearSearchController();
                        }
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    ) : const SizedBox(),
                  ),
                  onChanged: (text) => searchController.showSuffixIcon(context,text),
                  onSubmitted: (text) {
                    if(text.isNotEmpty) {
                      searchController.searchData(text);
                    }
                  },
                )
            )));
      },
    );
  }
}
