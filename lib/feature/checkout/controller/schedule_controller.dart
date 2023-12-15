import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class ScheduleController extends GetxController{

  final ScheduleRepo scheduleRepo;
  ScheduleController({required this.scheduleRepo});

  ///Selected date of day
  DateTime _selectedDate = DateTime.now().add(const Duration(hours: AppConstants.scheduleTime));
  DateTime get selectedData => _selectedDate;


  ///Selected time of day
  // TimeOfDay _selectedTimeOfDay = TimeOfDay(hour: DateTime.now().hour + AppConstants.SCHEDULE_TIME, minute: DateTime.now().minute);
  // TimeOfDay get selectedTimeOfDay => _selectedTimeOfDay;

  String _schedule = '';
  String get schedule => _schedule;

  String? _postId;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // initializeTime();
  //  // _buildSchedule();
  // }



  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(2101));
    if (picked != null) {
      _selectedDate = picked;
      update();
      selectTimeOfDay();
    }
  }

  Future<void> selectTimeOfDay() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay(hour: DateTime.now().hour + AppConstants.scheduleTime, minute: DateTime.now().minute));

    if (pickedTime != null) {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, pickedTime.hour, pickedTime.minute);
      update();

     _buildSchedule();
    }
  }


  Future<void> _buildSchedule() async {
    _schedule = DateConverter.dateToDateAndTime(_selectedDate);

    if(_postId!=null && _schedule.isNotEmpty){
      updatePostInformation(_postId!,_schedule);
    }
    //_schedule = "${DateConverter.dateTimeStringToDateOnly(_selectedDate.toString())} ${_selectedDate.hour.toString().padLeft(2,'0')}:${_selectedDate.minute.toString().padLeft(2,'0')}:00";
    update();
  }

  bool checkScheduleTime(){
    return  _selectedDate.difference(DateTime.now()) > const Duration(hours: AppConstants.scheduleTime, minutes: -15);
  }

  void updateSelectedDate(String? date){
    if(date!=null){
      _selectedDate = DateConverter.dateTimeStringToDate(date);
    }else{
      _selectedDate = DateTime.now().add(const Duration(hours: AppConstants.scheduleTime));
    }
  }
  Future<void> updatePostInformation(String postId,String scheduleTime) async {
    Response response = await scheduleRepo.changePostScheduleTime(postId,scheduleTime);

    if(response.statusCode==200 && response.body['response_code']=="default_update_200"){
      customSnackBar("service_schedule_updated_successfully".tr,isError: false);
    }
  }

  void setPostId(String postId){
    _postId = postId;
  }
}