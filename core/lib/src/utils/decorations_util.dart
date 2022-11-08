import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class DecorationUtil {
  BoxDecoration defaultBoxDecoration = BoxDecoration(
      color: Get.isDarkMode ? ColorsCollection.cDarkCard : Colors.white,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0.0, 2.0),
            blurRadius: 5.0)
      ]);
}
