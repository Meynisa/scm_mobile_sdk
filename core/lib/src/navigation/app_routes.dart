part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const LOGIN = _Paths.LOGIN;
  static const CHAT_ROOM = _Paths.CHAT_ROOM;
  static const PICTURE_DETAIL = _Paths.PICTURE_DETAIL;
  static const NOTIF = _Paths.NOTIF;
}

abstract class _Paths {
  static const SPLASH_SCREEN = '/SPLASH_SCREEN';
  static const LOGIN = '/LOGIN_SCREEN';
  static const CHAT_ROOM = '/CHAT_ROOM';
  static const PICTURE_DETAIL = '/PICTURE_DETAIL';
  static const NOTIF = '/NOTIF_SCREEN';
}
