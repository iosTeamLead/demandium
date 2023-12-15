import 'package:demandium/components/core_export.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatefulWidget {
  final String categoryTitle;
  final String categoryID;
  final int subCategoryIndex;
  const SubCategoryScreen({
    Key? key,
    required this.categoryTitle,
    required this.categoryID,
    required this.subCategoryIndex,
  }) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
        appBar: CustomAppBar(title: widget.categoryTitle,),
      body: GetBuilder<CategoryController>(
        initState: (state){
          Get.find<CategoryController>().getSubCategoryList(widget.categoryID, widget.subCategoryIndex,shouldUpdate: false); //banner id is category here

        },
        builder: (categoryController){

          return FooterBaseView(
            isCenter: (categoryController.subCategoryList != null &&  categoryController.subCategoryList!.isEmpty),
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: CustomScrollView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height:
                    ResponsiveHelper.isDesktop(context)?Dimensions.paddingSizeExtraLarge:0,
                    ),
                  ),
                  const SubCategoryView(isScrollable: true,),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}
