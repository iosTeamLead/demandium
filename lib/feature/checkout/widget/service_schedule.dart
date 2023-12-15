import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class ServiceSchedule extends GetView<ScheduleController> {
  const ServiceSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(
      init: controller,
      builder: (scheduleController){
        return  Column(
          children: [

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: Text("service_schedule".tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
            ),

            Container(
              height: 70, width: Get.width,
              padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSeven),
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3), width: 0.5),
                color: Theme.of(context).hoverColor,
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(" ${DateConverter.stringToLocalDateOnly(scheduleController.selectedData.toString()).substring(0,2)}",
                                style: ubuntuMedium.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: Dimensions.fontSizeOverLarge),),
                              Text(DateConverter.stringToLocalDateOnly(scheduleController.selectedData.toString()).substring(2),style: ubuntuRegular.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),),
                            ],
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeDefault,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeDefault,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateConverter.dateToWeek(scheduleController.selectedData),
                                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeMini,),
                              Text(
                                DateConverter.dateToTimeOnly(scheduleController.selectedData),
                                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: (){
                          scheduleController.selectDate();
                        },
                        child: Image.asset(Images.editButton,width: 20.0,height: 20.0,)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
          ],
        );
      },
    );
  }
}
