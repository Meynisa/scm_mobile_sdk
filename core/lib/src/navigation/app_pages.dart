import 'package:scm_mobile_sdk/main_lib.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;
  static const LOGIN = Routes.LOGIN;
  static const CHAT_ROOM = Routes.CHAT_ROOM;
  static const PICTURE_DETAIL = Routes.PICTURE_DETAIL;

  static final routes = [
    GetPage(name: _Paths.SPLASH_SCREEN, page: () => SplashScreen()),
    GetPage(
        name: _Paths.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: _Paths.CHAT_ROOM,
        page: () => ChatRoomPage(),
        binding: ChatBinding()),
    GetPage(name: _Paths.PICTURE_DETAIL, page: () => PictureDetailPage())
  ];
}
