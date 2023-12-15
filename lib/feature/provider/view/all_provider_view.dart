import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/provider/widgets/provider_filter_view.dart';
import 'package:demandium/feature/provider/widgets/provider_item_view.dart';
import 'package:get/get.dart';

class AllProviderView extends StatefulWidget {
  const AllProviderView({Key? key}) : super(key: key);

  @override
  State<AllProviderView> createState() => _AllProviderViewState();
}


class _AllProviderViewState extends State<AllProviderView> {

  @override
  void initState() {
    super.initState();
    Get.find<ProviderBookingController>().resetProviderFilterData();
    Get.find<ProviderBookingController>().getProviderList(1, true);

  }
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: 'provider_list'.tr,
        actionWidget: InkWell(onTap: (){
          showModalBottomSheet(
            useRootNavigator: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context, builder: (context) => const ProviderFilterView());
          },

          child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Image.asset(Images.filter,width: 20,color: Colors.white,),
          ),
        ),
      ),

      body: GetBuilder<ProviderBookingController>(builder: (providerBookingController){
        return FooterBaseView(
          isScrollView:true,
          scrollController: scrollController,
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if(ResponsiveHelper.isDesktop(context))
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault,horizontal: Dimensions.paddingSizeDefault),
                  child: InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          useRootNavigator: true,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context, builder: (context) => const ProviderFilterView());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,vertical: Dimensions.paddingSizeSmall),
                      child: Row(mainAxisSize: MainAxisSize.min,children: [
                        Image.asset(Images.filter,width: 20,color: Colors.white,),
                        const SizedBox(width: Dimensions.paddingSizeSmall,),
                        Text('filter'.tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.white),)
                      ],),
                    ),
                  ),
                ),

                providerBookingController.providerModel!=null && providerBookingController.providerList!.isNotEmpty?
                PaginatedListView(
                  scrollController: scrollController,
                  totalSize: providerBookingController.providerModel!.content!.total!,
                  onPaginate: (int offset) async => await providerBookingController.getProviderList(
                    offset, false,
                  ),
                  offset: providerBookingController.providerModel?.content?.currentPage,
                  itemView: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveHelper.isDesktop(context)?3:ResponsiveHelper.isTab(context)?2:1,
                    mainAxisExtent: ResponsiveHelper.isDesktop(context)?180:ResponsiveHelper.isTab(context)?170:160
                  ),
                    itemCount: providerBookingController.providerList!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return ProviderItemView(fromHomePage: false,providerData: providerBookingController.providerList![index],);
                    },),
                ):providerBookingController.providerModel==null?
                SizedBox(height: ResponsiveHelper.isDesktop(context)? Get.height*0.5:Get.height*0.9,child: const Center(child: CircularProgressIndicator())):
                SizedBox(height: ResponsiveHelper.isDesktop(context)? Get.height*0.5:Get.height*0.9,
                    child: Center(
                        child: Text('no_provider_found'.tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).textTheme.titleSmall!.color!.withOpacity(0.7)),)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
