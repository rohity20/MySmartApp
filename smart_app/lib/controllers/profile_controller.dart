import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;

  // changeImage() async {
  //   try {
  //     final img = await ImagePicker()
  //         .pickImage(source: ImageSource.gallery, imageQuality: 70);
  //     if (img == null) return;
  //     profileImgPath.value = img.path;
  //   } on PlatformException catch (e) {
  //     VxToast.show(Context, msg: e.toString());
  //   }
  // }
}
