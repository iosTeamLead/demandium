import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackButtonExist;
  final Function()? onBackPressed;
  final bool? showCart;
  final bool? centerTitle;
  final Color? bgColor;
  final Widget? actionWidget;
  const CustomAppBar({super.key, required this.title, this.isBackButtonExist = true, this.onBackPressed, this.showCart = false,this.centerTitle = true,this.bgColor, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : AppBar(
      title: Text(title!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color:  Theme.of(context).primaryColorLight),),
      centerTitle: centerTitle,
      leading: isBackButtonExist! ? IconButton(

        hoverColor:Colors.transparent,
        icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight),
        color: Theme.of(context).textTheme.bodyLarge!.color,
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
      ) : const SizedBox(),
      backgroundColor:Get.isDarkMode ? Theme.of(context).cardColor.withOpacity(.2):Theme.of(context).primaryColor,
      shape: Border(bottom: BorderSide(
          width: .4,
          color: Theme.of(context).primaryColorLight.withOpacity(.2))),
      elevation: 0,
      actions: showCart! ? [
        IconButton(onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
          icon:  CartWidget(
              color: Get.isDarkMode
                  ? Theme.of(context).primaryColorLight
                  : Colors.white,
              size: Dimensions.cartWidgetSize),
        )]:actionWidget!=null?[actionWidget!]: null,
    );
  }
  @override
  Size get preferredSize => Size(Dimensions.webMaxWidth, ResponsiveHelper.isDesktop(Get.context) ? Dimensions.preferredSizeWhenDesktop : Dimensions.preferredSize );
}