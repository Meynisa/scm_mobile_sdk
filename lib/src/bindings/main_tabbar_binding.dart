import '../../../main_lib.dart';

class MainTabbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabbarController>(() => MainTabbarController());
    Get.lazyPut<ChatContentController>(() => ChatContentController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<SocketController>(() => SocketController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<FilterController>(() => FilterController());
    Get.lazyPut<CustomTabviewController>(() => CustomTabviewController());
  }
}
