import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/create_post/model/my_post_model.dart';
import 'package:get/get.dart';

class DescriptionExpansionTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final List<AdditionInstructions>? additionalInstruction;

  const DescriptionExpansionTile({
    Key? key,
    required this.title,
    this.subTitle,
    this.additionalInstruction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).cardColor),
        color: Theme.of(context).cardColor,
        boxShadow: Get.isDarkMode? null: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5)
        ],
      ),
      child: ExpansionTile(
        backgroundColor: Theme.of(context).cardColor,
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        initiallyExpanded: false,
        title: Text(title.tr),

        children: <Widget>[
          if(additionalInstruction!=null)
          ListView.builder(itemBuilder: (context,index){

            return Padding(padding: const EdgeInsets.only(bottom: 10,right: 15,left: 15),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                const Padding(padding: EdgeInsets.only(top: 6),
                  child: Icon(Icons.circle,size: 7,),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Flexible(child: Text(additionalInstruction![index].details??"")),
              ],),
            );

          },
            padding: const EdgeInsets.only(bottom: 10),
            itemCount: additionalInstruction!.length,shrinkWrap: true,),
          if(subTitle!=null)
          ListTile(title: Text(subTitle!.tr),subtitle: const Text(""),)
        ],

      ),
    );
  }
}
