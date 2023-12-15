import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/provider/model/category_model_item.dart';
import 'package:demandium/feature/provider/view/category_item_view.dart';
import 'package:demandium/feature/provider/widgets/provider_details_top_card.dart';
import 'package:demandium/feature/provider/widgets/vertical_scrollable_tabview.dart';
import 'package:get/get.dart';


class ProviderDetailsScreen extends StatefulWidget {
  final String providerId;
  final String subCategories;
  const ProviderDetailsScreen({Key? key,required this.providerId, required this.subCategories}) : super(key: key);


  @override
  ProviderDetailsScreenState createState() => ProviderDetailsScreenState();
}

class ProviderDetailsScreenState extends State<ProviderDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    Get.find<ProviderBookingController>().getProviderDetailsData(widget.providerId, true).then((value){
      tabController = TabController(length: Get.find<ProviderBookingController>().categoryItemList.length, vsync: this);
      Get.find<CartController>().updatePreselectedProvider(
          Get.find<ProviderBookingController>().providerDetailsContent?.provider?.avgRating.toString()??"0",
          Get.find<ProviderBookingController>().providerDetailsContent?.provider?.id.toString()??"0",
          Get.find<ProviderBookingController>().providerDetailsContent?.provider?.logo.toString()??"0",
          Get.find<ProviderBookingController>().providerDetailsContent?.provider?.companyName.toString()??"0"
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: "provider_details".tr,showCart: true,),
      body: Center(
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: GetBuilder<ProviderBookingController>(
              builder: (providerBookingController){
            if(providerBookingController.providerDetailsContent!=null){

              if(providerBookingController.categoryItemList.isEmpty){
                return Column(
                  children: [
                    ProviderDetailsTopCard(isAppbar: false,subcategories: widget.subCategories,providerId: widget.providerId,),
                    SizedBox(
                      height: Get.height*0.6,
                      child: Center(child: Text('no_subscribed_subcategories_available'.tr),),
                    ),
                  ],
                );
              }else{
                return Column(
                  children: [
                    Expanded(
                      child: VerticalScrollableTabView(
                        tabController: tabController,
                        listItemData: providerBookingController.categoryItemList,
                        verticalScrollPosition: VerticalScrollPosition.begin,
                        eachItemChild: (object, index) => CategorySection(category: object as CategoryModelItem),
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Get.isDarkMode? null:Theme.of(context).cardColor,
                            pinned: true,
                            leading: const SizedBox(),
                            actions: const [ SizedBox()],
                            flexibleSpace: ProviderDetailsTopCard(subcategories: widget.subCategories,providerId: widget.providerId,),
                            toolbarHeight: 140,
                            elevation: 0,
                            bottom: TabBar(
                              isScrollable: true,
                              controller: tabController,
                              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                              indicatorColor: Get.isDarkMode?Colors.white70:Theme.of(context).primaryColor,
                              labelColor: Get.isDarkMode?Colors.white:Theme.of(context).primaryColor,
                              unselectedLabelColor: Colors.grey,
                              padding: const EdgeInsets.only(bottom: 10),
                              indicatorWeight: 3.0,
                              tabs: providerBookingController.categoryItemList.map((e) {
                                return Tab(text: e.title);
                              }).toList(),
                              onTap: (index) {
                                VerticalScrollableTabBarStatus.setIndex(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

            }else{
             return const Center(child: CircularProgressIndicator(),);
            }
          }),
        ),
      ),
    );
  }
}









