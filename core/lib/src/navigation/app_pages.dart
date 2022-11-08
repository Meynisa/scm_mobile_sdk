import 'package:scm_mobile_sdk/main_lib.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;
  static const ONBOARDING = Routes.ONBOARDING;
  static const LOGIN = Routes.LOGIN;
  static const MAIN_TABBAR = Routes.MAIN_TABBAR;
  static const CHAT_ROOM = Routes.CHAT_ROOM;
  static const PICTURE_DETAIL = Routes.PICTURE_DETAIL;
  static const DETAIL_PROFILE = Routes.DETAIL_PROFILE;
  static const EDIT_PROFILE = Routes.EDIT_PROFILE;
  static const LIST_CATEGORY = Routes.LIST_CATEGORY;
  static const HISTORY_PAGE = Routes.HISTORY_PAGE;
  static const PROFILE_AGENT = Routes.PROFILE_AGENT;

  static final routes = [
    GetPage(name: _Paths.SPLASH_SCREEN, page: () => SplashScreen()),
    // GetPage(name: _Paths.ONBOARDING, page: () => OnboardingPage()),
    GetPage(
        name: _Paths.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: _Paths.MAIN_TABBAR,
        page: () => MainTabbar(),
        binding: MainTabbarBinding()),
    GetPage(
        name: _Paths.CHAT_ROOM,
        page: () => ChatRoomPage(),
        binding: ChatBinding()),
    GetPage(name: _Paths.PICTURE_DETAIL, page: () => PictureDetailPage()),
    GetPage(
        name: _Paths.DETAIL_PROFILE,
        page: () => DetailProfilePage(),
        binding: ProfileBinding()),
    GetPage(name: _Paths.EDIT_PROFILE, page: () => EditProfilePage()),
    GetPage(name: _Paths.LIST_CATEGORY, page: () => CategoryViewModel()),
    GetPage(
        name: _Paths.HISTORY_PAGE,
        page: () => HistoryPage(),
        binding: HistoryBinding()),
    GetPage(
        name: _Paths.PROFILE_AGENT,
        page: () => ProfileAgentPage(),
        binding: ProfileAgentBinding())
  ];
}
