import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/my_post/widgets/my_post_view.dart';
import 'package:get/get.dart';

class AllPostScreen extends StatelessWidget {
  const AllPostScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(title: 'my_posts'.tr, onBackPressed: (){
          if(Navigator.canPop(context)){
            Get.back();
          }else{
            Get.offAllNamed(RouteHelper.getMainRoute("home"));
          }
        },
      ),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Get.find<CreatePostController>().getMyPostList(1,reload: true);
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

            child: CustomScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: Column(
                  children: [
                    Center(child: SizedBox(width: Dimensions.webMaxWidth,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: Get.height * 0.8
                        ),
                        child: GetBuilder<CreatePostController>(
                          initState: (_){
                            Get.find<CreatePostController>().getMyPostList(1,reload: true);
                          },
                          builder: (createPostController){

                            return (!createPostController.isLoading && createPostController.dateList.isNotEmpty) ?
                            PaginatedListView(
                              scrollController: scrollController,
                              totalSize: createPostController.postModel?.content?.total,
                              onPaginate: (int offset) async => await createPostController.getMyPostList(offset, reload: false),
                              offset: createPostController.postModel?.content?.currentPage,
                              itemView: ListView.builder(
                                padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                itemBuilder: (context, dateIndex) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeSmall),
                                        child: Text(
                                          Get.find<CreatePostController>().dateList[dateIndex].toString(),
                                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)),
                                          textDirection: TextDirection.ltr,

                                        ),
                                      ),

                                      GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: Dimensions.paddingSizeLarge,
                                          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeSmall,
                                          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1: ResponsiveHelper.isTab(context) ? 2 : 3,
                                          mainAxisExtent: ResponsiveHelper.isMobile(context) ? 140 : 150,
                                        ),
                                        itemBuilder: (context, index) {
                                          return MyPostView(postData: createPostController.listOfMyPost![dateIndex][index]);
                                        },
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: createPostController.listOfMyPost![dateIndex].length,
                                      )
                                    ],
                                  );
                                },
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: createPostController.dateList.length,
                              ),
                            ) : (createPostController.isLoading) ?
                            GridView.builder(
                              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: Dimensions.paddingSizeLarge,
                                mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeSmall,
                                crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : ResponsiveHelper.isTab(context) ? 2 : 3,
                                mainAxisExtent: ResponsiveHelper.isMobile(context) ? 140 : 150,
                              ),
                              itemCount: 9, shrinkWrap: true,
                              padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge,top: Dimensions.paddingSizeDefault*2),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder:(BuildContext context, index) {
                                return  Padding(padding: EdgeInsets.symmetric(
                                    horizontal: ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault,
                                    vertical: ResponsiveHelper.isDesktop(context)? 10 : 0
                                ),
                                  child: const SubCategoryShimmer(isEnabled: true, hasDivider: false),
                                );
                              },
                            ) :
                            Center(child: NoDataScreen(text: 'no_post_found'.tr.tr,type: NoDataType.bookings,));
                          }),
                      ),
                    )),

                    if(ResponsiveHelper.isDesktop(context))
                      const FooterView(),
                  ],
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
