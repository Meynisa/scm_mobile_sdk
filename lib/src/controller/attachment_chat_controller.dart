import 'dart:io';
import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class AttachmentChatController extends GetxController {
  PlatformFile? pletformFile;
  File? file;

  TextEditingController messageController = TextEditingController();
  final ChatRoomController _chatRoomController = Get.find<ChatRoomController>();
  RxBool isMaxLine = false.obs;
  RxBool isValidMessage = false.obs;

  @override
  void onInit() {
    super.onInit();
    messageController.addListener(() {
      isValidMessage.value = (messageController.text.isNotEmpty) ? true : false;
    });
  }

  Future<PlatformFile?> pickFile() async {
    messageController.text = _chatRoomController.messageController.text != ''
        ? _chatRoomController.messageController.text
        : '';
    pletformFile = null;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        pletformFile = result.files.single;
        file = File(result.files.single.path!);
        printInfo(info: result.files.single.name);
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      _logException('Unsupported operation $e');
    } catch (e) {
      _logException(e.toString());
    }
    return pletformFile;
  }

  void sendMessage() {
    _chatRoomController.replyMessage(
        message: messageController.text, file: file);
    Get.back();
  }

  void _logException(String message) {
    LogUtil().loggingTest(message);
    Get.snackbar(message, message);
  }
}
