import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class SuggestedSearch extends StatelessWidget {
  const SuggestedSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('suggest_for_you'.tr,style: ubuntuMedium.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: Theme.of(context).colorScheme.primary),),

        const SizedBox(height: Dimensions.paddingSizeDefault,),

        const Wrap(
          children: [
            SuggestedSearchItem(title: 'all_service',),
            SuggestedSearchItem(title: 'popular_services',),
            SuggestedSearchItem(title: 'trending_services',),
          ],
        )
      ],
    );
  }
}

class SuggestedSearchItem extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const SuggestedSearchItem({Key? key, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color:Get.isDarkMode?Colors.grey.withOpacity(0.2): Theme.of(context).primaryColor.withOpacity(0.1)
          ),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall-3, horizontal: Dimensions.paddingSizeSmall,),
          margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, bottom:Dimensions.paddingSizeSmall),
          child: Text(title.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),),
        ),
        Positioned.fill(child: RippleButton(onTap: () {

          Get.toNamed(RouteHelper.allServiceScreenRoute(title));
          // Get.find<SearchController>().suggestedSearchData(title: title);
          // Get.find<SearchController>().populatedSearchController(title);
        }))
      ],
    );
  }
}

