import 'package:get/get.dart';

class OnBoardController extends GetxController{
  int pageIndex = 0;

  void onPageChanged(int index){
    pageIndex = index;
    update();
  }

}