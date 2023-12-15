import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class CategorySubCategoryScreen extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  final String subCategoryIndex;
   const CategorySubCategoryScreen({Key? key, required this.categoryID, required this.categoryName, required this.subCategoryIndex}) : super(key: key);

  @override
  State<CategorySubCategoryScreen> createState() => _CategorySubCategoryScreenState();
}

class _CategorySubCategoryScreenState extends State<CategorySubCategoryScreen> {
  ScrollController scrollController = ScrollController();
  String? subCategoryIndex;

  @override
  void initState() {
    Get.find<CategoryController>().getCategoryList(1,false);
    subCategoryIndex = widget.subCategoryIndex;
    Get.find<CategoryController>().getSubCategoryList(
      widget.categoryID,
      int.parse(widget.subCategoryIndex),
      shouldUpdate: false
    );
    if(!ResponsiveHelper.isWeb()) {
      moved();
    }
    super.initState();
  }

  moved()async{
    Future.delayed(const Duration(seconds: 1), () {
      try{
        Scrollable.ensureVisible(
          Get.find<CategoryController>().categoryList!.elementAt(int.parse(subCategoryIndex!)).globalKey!.currentContext!,
          duration: const Duration(seconds: 1),
        );
      }catch(e){
        if (kDebugMode) {
          print('');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        builder: (categoryController) {
          return Scaffold(
            endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
            appBar: CustomAppBar(title: 'available_service'.tr,),
            body: FooterBaseView(
              child: SizedBox(
                width: Dimensions.webMaxWidth,
                child: CustomScrollView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeExtraLarge,),),
                    SliverToBoxAdapter(
                      child: (categoryController.categoryList != null && !categoryController.isSearching!) ?
                      Center(
                        child: Container(
                          height:ResponsiveHelper.isDesktop(context) ? 150 : ResponsiveHelper.isTab(context)? 140 : 130,
                          margin: EdgeInsets.only(
                              left: ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault,
                          ),
                          width: Dimensions.webMaxWidth,
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeExtraSmall,
                              top: Dimensions.paddingSizeDefault
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryController.categoryList!.length,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                              left: ResponsiveHelper.isDesktop(context)?0: Dimensions.paddingSizeSmall,
                              right: ResponsiveHelper.isDesktop(context)?0: Dimensions.paddingSizeSmall,
                            ),
                            itemBuilder: (context, index) {
                              CategoryModel categoryModel = categoryController.categoryList!.elementAt(index);
                              return InkWell(
                                key:!ResponsiveHelper.isWeb() ?  categoryModel.globalKey: null,
                                onTap: () {
                                  subCategoryIndex = index.toString();
                                  Get.find<CategoryController>().getSubCategoryList(categoryModel.id!, index);
                                },
                                hoverColor: Colors.transparent,
                                child: Container(
                                  width: ResponsiveHelper.isDesktop(context) ? 150 : ResponsiveHelper.isTab(context)?140 :100,

                                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                  decoration: BoxDecoration(
                                    color: index != int.parse(subCategoryIndex!) ? Theme.of(context).primaryColorLight : Theme.of(context).colorScheme.primary,
                                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault), ),
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                          child: CustomImage(
                                            fit: BoxFit.cover,
                                            height: ResponsiveHelper.isDesktop(context) ? 50 : ResponsiveHelper.isTab(context)?40 :30,
                                            width: ResponsiveHelper.isDesktop(context) ? 50 : ResponsiveHelper.isTab(context)?40 :30,
                                            image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                                '/category/${categoryController.categoryList![index].image}',
                                          ),
                                        ),
                                        const SizedBox(height: Dimensions.paddingSizeSmall,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                          child: Text(categoryController.categoryList![index].name!,
                                            style: ubuntuRegular.copyWith(
                                              fontSize: Dimensions.fontSizeSmall,
                                              color:index==int.parse(subCategoryIndex!)? Colors.white:Colors.black
                                            ),
                                            maxLines: 2,textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                        ),
                      ) : ResponsiveHelper.isDesktop(context)?
                      WebCategoryShimmer(
                        categoryController: categoryController,
                        fromHomeScreen: false,
                      ):const SizedBox(),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(width: Dimensions.webMaxWidth,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                                child: Center(
                                  child: Text(
                                    'sub_categories'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                      color:Get.isDarkMode ? Colors.white:Theme.of(context).colorScheme.primary),
                                  ),
                                ),
                            ),
                        ),
                    ),
                    SubCategoryView(
                      noDataText: "no_subcategory_found".tr,
                      isScrollable: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
