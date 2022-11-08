import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

final CustomConfigController configController =
    Get.put(CustomConfigController());

TextStyle headline1() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 48.sp, fontWeight: FontWeight.w700);
// TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w700);
TextStyle headline2() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 28.sp, fontWeight: FontWeight.w700);
// TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700);
TextStyle headline3() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 22.sp, fontWeight: FontWeight.w700);
// TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700);
TextStyle headline4() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600);
// TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600);
TextStyle headline5() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 17.sp, fontWeight: FontWeight.w700);
// TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700);
TextStyle headline6() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 17.sp, fontWeight: FontWeight.w300);
// TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w300);
TextStyle headline7() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700);
// TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700);
TextStyle subtitle1() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600);
// TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
TextStyle subtitle2() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w300);
// TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300);
TextStyle subtitle3() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700);
// TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700);
TextStyle subtitle4() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w400);
// TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400);
TextStyle subtitle5() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700);
// TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700);
TextStyle subtitle6() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600);
// TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);
TextStyle subtitle7() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500);
// TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
TextStyle body1() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400);
//TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400);
TextStyle body2() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400);
//TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400);
TextStyle body3() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 12.sp);
//TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);
TextStyle body4() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500);
//TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500);
TextStyle body5() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 7.sp, fontWeight: FontWeight.w500);
//TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w500);
TextStyle body6() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 11.sp, fontWeight: FontWeight.w500);
//TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500);
TextStyle body7() =>
    GoogleFonts.getFont(configController.responseFontType.value)
        .copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400);
            //TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400);
