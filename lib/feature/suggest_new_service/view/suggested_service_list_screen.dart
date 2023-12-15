import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/suggest_new_service/controller/suggest_service_controller.dart';
import 'package:demandium/feature/suggest_new_service/widgets/suggest_service_item_view.dart';
import 'package:get/get.dart';

class SuggestedServiceListScreen extends StatelessWidget {
  const SuggestedServiceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: 'service_request_list'.tr),
      body: GetBuilder<SuggestServiceController>(
        initState: (_)=>Get.find<SuggestServiceController>().getSuggestedServiceList(1,reload: true),
        builder: (suggestServiceController){
          return FooterBaseView(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child:suggestServiceController.suggestedServiceModel!=null?
              Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
                  if(suggestServiceController.suggestedServiceList.isNotEmpty)
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                    child: Row(
                      children: [
                        Text('${'request'.tr} ',style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

                        Directionality(textDirection: TextDirection.ltr,
                          child: Text('(${suggestServiceController.suggestedServiceList.length})',style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                      ],
                    ),
                  ),
                  suggestServiceController.suggestedServiceList.isNotEmpty?
                  ListView.builder(
                    itemCount: suggestServiceController.suggestedServiceList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return SuggestServiceItemView(suggestedService:suggestServiceController.suggestedServiceList[index]);
                    },):SizedBox(height: Get.height*0.8, child: Center(child: Text(
                      'no_service_request_yet'.tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                    ),),
                  ),
                ]),
              ):Center(
                child: SizedBox(
                    height: ResponsiveHelper.isDesktop(context)?100: Get.height*0.85,
                    child: const Center(child: CircularProgressIndicator())),
              ),
            ),
          );
      }),
    );
  }
}
