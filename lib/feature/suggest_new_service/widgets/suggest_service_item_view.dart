import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/suggest_new_service/model/suggest_service_model.dart';
import 'package:get/get.dart';

class SuggestServiceItemView extends StatelessWidget {
  final SuggestedService suggestedService;

  const SuggestServiceItemView({Key? key, required this.suggestedService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeEight),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).cardColor , borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          Row(children: [

            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: CustomImage(height: 40, width: 40, fit: BoxFit.cover, image:
                "${Get.find<SplashController>().configModel.content!.imageBaseUrl}/category/${suggestedService.category?.image??""}"
                ),
            ),

            Expanded(child: Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Text(suggestedService.category?.name??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
            )),
          ],),

          Padding(padding: const EdgeInsets.fromLTRB(0,Dimensions.paddingSizeDefault,0,Dimensions.paddingSizeTine),
            child: Text("suggested_service".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8))),
          ),
          Text(suggestedService.serviceName??"", style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),

          Padding(padding: const EdgeInsets.fromLTRB(0,Dimensions.paddingSizeDefault,0,Dimensions.paddingSizeTine),
            child: Text("description".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8))),
          ),

          Text(suggestedService.serviceDescription??"",
              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
            maxLines: 100,
            overflow: TextOverflow.ellipsis,
            textAlign: Get.find<LocalizationController>().isLtr? TextAlign.justify:TextAlign.right,
          ),
        ]),
      ),
    );
  }
}

