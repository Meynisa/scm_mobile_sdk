import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class AppbarViewModel {
  appbarViewModel(
      BuildContext context, GlobalKey<ScaffoldState> contextScaffold) {
    return AppBar(
        backgroundColor: ColorsCollection.cDefault,
        brightness: Brightness.light,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(''),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 8),
              onPressed: () => contextScaffold.currentState!.openDrawer(),
              icon: Icon(Icons.menu, size: 24, color: Colors.white))
        ]);
  }

  appbarDemoViewModel(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.red.withOpacity(0.3),
        brightness: Brightness.light,
        leading: Container(),
        elevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  onPressed: () {
                    PreferenceUtils().clearAllData();
                    Get.back();
                  },
                  child: Text(DictionaryUtil.exit_trial.tr,
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red))
        ]);
  }

  appbarDefaultViewModel(BuildContext context,
      {controller,
      String titleAppBar = '',
      Widget? titleWidget,
      bool showLeading = false,
      bool centerTitle = false,
      String? clickActionName,
      List<Widget>? actions,
      Function? onBackPressedLeading,
      PreferredSizeWidget? tabBar,
      Brightness brightness = Brightness.light,
      Color? componentColor = Colors.white,
      GlobalKey<ScaffoldState>? contextScaffold}) {
    return AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        leading: showLeading
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: componentColor ?? Colors.white,
                ),
                onPressed: onBackPressedLeading != null
                    ? () => onBackPressedLeading()
                    : () => Navigator.maybePop(context, clickActionName))
            : null,
        automaticallyImplyLeading: false,
        centerTitle: centerTitle,
        title: titleWidget != null
            ? titleWidget
            : controller == null
                ? Text(titleAppBar,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white))
                : Row(children: [
                    Image.asset(controller.titleAppbar()!.iconAssets,
                        height: 24, fit: BoxFit.contain, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                        controller == null
                            ? titleAppBar
                            : controller.titleAppbar()!.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white))
                  ]),
        actions: actions == null
            ? controller != null
                ? [
                    IconButton(
                        padding: EdgeInsets.only(right: 8),
                        onPressed: () =>
                            contextScaffold!.currentState!.openDrawer(),
                        icon: Icon(Icons.menu, size: 24, color: Colors.white))
                  ]
                : actions
            : actions,
        bottom: tabBar,
        iconTheme: IconThemeData(color: Colors.black54),
        titleSpacing: !showLeading ? 16.0 : 0.0);
  }
}
