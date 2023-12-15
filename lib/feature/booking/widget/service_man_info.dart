import 'package:get/get.dart';
import 'package:demandium/core/common_model/user_model.dart';
import 'package:demandium/components/core_export.dart';
class ServiceManInfo extends StatelessWidget {
  final User user;
  const ServiceManInfo({Key? key,required this.user, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Text("service_man_info".tr, style: ubuntuMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color:Get.isDarkMode ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6):Theme.of(context).primaryColor))),
        Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
        CustomerInfoCard(
          name: "${user.firstName!} ${user.lastName!}",
          phone: user.phone!,
          image: user.profileImage!,
        ),
        Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
      ],
    );
  }
}
