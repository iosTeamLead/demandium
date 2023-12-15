import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageController extends GetxController {

  XFile? _pickedFile ;
  XFile? get pickedFile => _pickedFile;

  void pickImage() async {
    _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    update();
  }

  void removeImage() async {
    _pickedFile = null;
    update();
  }
}