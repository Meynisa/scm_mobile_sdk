import '../../../main_lib.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRoomController>(() => ChatRoomController());
    Get.lazyPut<TemplateMessageController>(() => TemplateMessageController());
    Get.lazyPut<AttachmentChatController>(() => AttachmentChatController());
  }
}
