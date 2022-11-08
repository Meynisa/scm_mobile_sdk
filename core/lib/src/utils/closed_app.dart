import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClosedApp {
  DateTime? backbuttonpressedTime;
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  _pop({bool? animated}) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', animated);
  }

  Future<bool> onBackPressed(BuildContext context) {
    DateTime currentTime = DateTime.now();
    //Statement 1 Or statement2
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime!) > Duration(seconds: 1);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      return _scaffoldKey.currentState
              ?.showSnackBar(
                SnackBar(
                  content: Text(DictionaryUtil.double_click.tr),
                  duration: const Duration(seconds: 3),
                ),
              )
              .closed as Future<bool>? ??
          false as Future<bool>;
    } else {
      return AlertDialogCustom().alertDialog(
              context, DictionaryUtil.attention.tr, DictionaryUtil.exit_desc.tr,
              onPressedOK: () => _pop()) as Future<bool>? ??
          false as Future<bool>;
    }
  }
}
