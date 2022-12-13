import 'package:scm_mobile_sdk/main_lib.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRoomController>(() => ChatRoomController());
    Get.lazyPut<AttachmentChatController>(() => AttachmentChatController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<SocketController>(() => SocketController());
  }
}
