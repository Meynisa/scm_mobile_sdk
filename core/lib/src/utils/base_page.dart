import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DefaultBasePage extends StatelessWidget {
  final Widget childWidget;
  final bool? leading;
  final String? titleAppBar;
  final Widget? titleWidget;
  final PreferredSizeWidget? tabBar;
  final List<Widget>? actions;
  final Function? onBackPressed;
  final Color? bgColor;

  const DefaultBasePage(
      {Key? key,
      required this.childWidget,
      this.leading = false,
      this.titleAppBar = '',
      this.titleWidget,
      this.actions,
      this.tabBar,
      this.onBackPressed,
      this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            bgColor == null ? context.theme.backgroundColor : bgColor,
        appBar: AppbarViewModel().appbarDefaultViewModel(context,
            titleAppBar: titleAppBar!,
            showLeading: leading!,
            titleWidget: titleWidget,
            tabBar: tabBar,
            actions: actions,
            onBackPressedLeading: onBackPressed) as PreferredSizeWidget?,
        body: SafeArea(child: childWidget));
  }
}
