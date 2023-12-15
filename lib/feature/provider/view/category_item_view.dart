import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/provider/model/category_model_item.dart';
import 'package:get/get.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key, required this.category,}) : super(key: key);

  final CategoryModelItem category;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: category.title=="popular"?
        Theme.of(context).primaryColor.withOpacity(0.1): null,
        border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.5),width: 1),),
      ),
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,0,Dimensions.paddingSizeDefault,Dimensions.paddingSizeLarge),
      child: category.serviceList.isNotEmpty?
      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeDefault),
          child: Row(
            children: [
              if(category.title=="popular")
                Image.asset(Images.hot,width: 20,),
              if(category.title=="popular")
                const SizedBox(width: Dimensions.paddingSizeDefault,),

              Text(category.title,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
            ],
          ),
        ),
        category.title=="popular"?
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:  category.serviceList.length,
          itemBuilder: (context, index){
            Discount discount = PriceConverter.discountCalculation(category.serviceList[index]);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
              child: InkWell(
                onTap: () => Get.toNamed(RouteHelper.getServiceRoute(category.serviceList[index].id!)),
                child: ServiceModelView(
                  serviceList: category.serviceList,
                  discountAmountType: discount.discountAmountType,
                  discountAmount: discount.discountAmount,
                  index: index,
                ),
              ),
            );
          },
        ) :GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.paddingSizeDefault,
            mainAxisSpacing:  Dimensions.paddingSizeDefault,
            childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? .9 :  .70,
            mainAxisExtent:ResponsiveHelper.isMobile(context) ?  235 : 260 ,
            crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: category.serviceList.length,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          itemBuilder: (context, index) {
            bool isAvailable = true;
            return ServiceWidgetVertical(service:  category.serviceList[index],  isAvailable: isAvailable,fromType: 'provider_details',);
          },
        ),
      ]):const SizedBox(),
    );
  }
}