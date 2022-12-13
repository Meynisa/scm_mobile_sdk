import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

final ThemeData lightTheme = new ThemeData(
    fontFamily: AssetsCollection.fHelvetica,
    brightness: Brightness.light,
    bottomAppBarColor: Colors.white,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleTextStyle: headline3().copyWith(color: Colors.black)),
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: ColorsCollection.cDefault),
    backgroundColor: Color(0xFFF5F6FA), //Colors.white,
    canvasColor: Colors.white,
    hintColor: Color(0xFF777777),
    buttonColor: ColorsCollection.cDefault,
    disabledColor: ColorsCollection.cDarkGrey,
    radioTheme:
        RadioThemeData(fillColor: MaterialStateProperty.resolveWith(_getColor)),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith(_getColor)),
    scrollbarTheme: ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(ColorsCollection.cDarkBg)),
    buttonTheme: ButtonThemeData(
        height: 45.h,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        buttonColor: ColorsCollection.cLightPurple,
        disabledColor: ColorsCollection.cDisableColor),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
        headline1: headline2(),
        headline2: headline3(),
        headline3: headline4(),
        headline4: headline6(),
        headline5: headline5(),
        headline6: subtitle1(),
        subtitle1: subtitle2(),
        subtitle2: subtitle3(),
        bodyText1: body1()),
    primaryColor: ColorsCollection.cLightPurple,
    accentColor: ColorsCollection.cLightPurple,
    accentColorBrightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity);

Color _getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.selected,
    MaterialState.hovered,
    MaterialState.focused
  };
  if (states.any(interactiveStates.contains)) {
    return ColorsCollection.cPurple;
  } else {
    return ColorsCollection.cUnselectedLoad;
  }
}

final ThemeData darkTheme = new ThemeData(
    fontFamily: AssetsCollection.fHelvetica,
    brightness: Brightness.dark,
    bottomAppBarColor: ColorsCollection.cDarkBg,
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: ColorsCollection.cDefault),
    backgroundColor: ColorsCollection.cDarkBg,
    buttonColor: ColorsCollection.cDefault,
    disabledColor: ColorsCollection.cGreyCDColor,
    canvasColor: ColorsCollection.cDarkBg,
    scrollbarTheme: ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(ColorsCollection.cBgColor)),
    radioTheme:
        RadioThemeData(fillColor: MaterialStateProperty.resolveWith(_getColor)),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith(_getColor)),
    buttonTheme: ButtonThemeData(
        height: 45,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        buttonColor: ColorsCollection.cLightPurple,
        disabledColor: ColorsCollection.cDisableColor),
    scaffoldBackgroundColor: ColorsCollection.cDarkBg,
    textTheme: TextTheme(
        headline1: headline2(),
        headline2: headline3(),
        headline3: headline4(),
        headline4: headline6(),
        headline5: headline5(),
        headline6: subtitle1(),
        subtitle1: subtitle2(),
        subtitle2: subtitle3(),
        bodyText1: body1(),
        bodyText2: body3()),
    primaryColor: ColorsCollection.cLightPurple,
    accentColor: ColorsCollection.cLightPurple,
    accentColorBrightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity);
