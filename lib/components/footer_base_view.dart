import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class FooterBaseView extends StatelessWidget {
  final Widget child;
  final bool isScrollView;
  final ScrollController? scrollController;
  final bool isCenter;
  final bool? bottomPadding;
  const FooterBaseView({
    Key? key,
    required this.child,
    this.isScrollView = true,
    this.isCenter = false,
    this.scrollController,
    this.bottomPadding = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isCenter){
      return isScrollView ? Center(
        child: SingleChildScrollView(
          controller: scrollController,
          child: _widget(context),
        ),
      ) : _widget(context);
    }

    return isScrollView ? SingleChildScrollView(
      controller: scrollController,
      child: _widget(context),
    ) : _widget(context);
  }

  Widget _widget(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height > 780 ?  Get.size.height - 200: 380,
          ),
          child: child,
        ),
        SizedBox(height: bottomPadding!? Dimensions.paddingSizeExtraLarge:0,),
        const FooterView(),
      ],
    ) : child;
  }
}