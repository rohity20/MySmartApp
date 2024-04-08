import 'package:smart_app/consts/colors.dart';

import '../consts/consts.dart';

Widget applogoWidget() {
  //using velocity X here
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}

Widget meeshologoWidget() {
  //using velocity X here
  return Image.asset(icMeeshoLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
