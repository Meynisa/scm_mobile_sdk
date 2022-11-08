import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class AlertDialogCustom {
  Future<void> alertDialog(BuildContext context, String text, String? desc,
      {IconData icon = Icons.warning,
      Color colorIcon = ColorsCollection.cPurple,
      bool isNavigate = false,
      navigate,
      isOneButton = false,
      String imgAsset = "",
      String? roomId,
      Function? onPressedOK,
      bool noButton = false,
      Widget? customWidget,
      bool isDismissable = true,
      String? leftBtnLabel,
      String? rightBtnLabel,
      String oneBtnLabel = 'OK',
      bool isImgEmpty = false}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: isDismissable, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              content: SingleChildScrollView(
                  child: ListBody(children: <Widget>[
                SizedBox(height: 30),
                Text(text, textAlign: TextAlign.center, style: subtitle1()),
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isImgEmpty
                        ? Container()
                        : imgAsset != ""
                            ? Image.asset(imgAsset, height: 70)
                            : Icon(icon, color: colorIcon, size: 70)),
                SizedBox(height: 20),
                customWidget == null
                    ? Text(desc!,
                        style: body1()
                            .copyWith(color: Color.fromRGBO(150, 150, 150, 1)),
                        textAlign: TextAlign.center)
                    : customWidget,
                SizedBox(height: 30),
                noButton == false
                    ? isOneButton
                        ? Center(
                            child: MaterialButton(
                                color: ColorsCollection.cPurple,
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorsCollection.cPurple),
                                    borderRadius: new BorderRadius.circular(8)),
                                child: Text(oneBtnLabel,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: Colors.white)),
                                onPressed: onPressedOK as void Function()?))
                        : Container(
                            height: 40,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: MaterialButton(
                                        color: ColorsCollection.cPurple,
                                        shape: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    ColorsCollection.cPurple),
                                            borderRadius:
                                                new BorderRadius.circular(8)),
                                        child: Text(
                                            leftBtnLabel ??
                                                DictionaryUtil.no.tr
                                                    .toUpperCase(),
                                            style: subtitle1()
                                                .copyWith(color: Colors.white)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                  SizedBox(width: (Get.size.width / 3) - 100),
                                  Expanded(
                                      child: MaterialButton(
                                          shape: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      ColorsCollection.cPurple),
                                              borderRadius:
                                                  new BorderRadius.circular(8)),
                                          onPressed:
                                              onPressedOK as void Function()?,
                                          child: Text(
                                              rightBtnLabel ??
                                                  DictionaryUtil.yes.tr
                                                      .toUpperCase(),
                                              style: subtitle1().copyWith(
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : ColorsCollection
                                                          .cPurple))))
                                ]))
                    : Container()
              ])));
        });
  }

  void loading() {
    boxDialog(
        Get.context!,
        true,
        Center(
            child: Container(
                height: 60.w,
                width: 60.w,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? ColorsCollection.cDarkCard
                        : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                padding: EdgeInsets.all(8.0),
                child: loadingProgressIndicator())));
  }

  Future<void> boxDialog(
      BuildContext context, bool isDismissable, Widget childWidget) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: isDismissable,
        builder: (BuildContext context) {
          return childWidget;
        });
  }

  Widget loadingProgressIndicator({double height = 60, double width = 60}) {
    return Center(
        child: Image.asset('assets/images/img_ripple.gif',
            height: height, width: width));
  }

  Widget onError({Function()? onPressed, String customText = ''}) {
    return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Column(children: [
          Text(
              customText != ''
                  ? customText
                  : DictionaryUtil.widget_data_error.tr,
              style: body1()),
          IconButton(
              onPressed: onPressed,
              icon:
                  Icon(Icons.replay_rounded, color: ColorsCollection.cPurple)),
          Text('Reload', style: body1())
        ])));
  }

  Widget emptyWidget(
      {bool? isReload = false, Function()? onPressed, String customText = ''}) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Image.asset(AssetsCollection.ic_logo,
              height: 50.w, fit: BoxFit.fitHeight),
          SizedBox(height: 16),
          Text(DictionaryUtil.widget_data_empty.tr, style: body1()),
          isReload == true
              ? IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.replay_rounded,
                      color: ColorsCollection.cPurple))
              : Container()
        ]));
  }

  Widget lazyLoadWidget({double height = 24, double width = 24}) {
    return Container(
        height: height,
        width: width,
        margin: EdgeInsets.all(5),
        child: CircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: ColorsCollection.cLightPurple,
            color: ColorsCollection.cPurple));
  }
}
