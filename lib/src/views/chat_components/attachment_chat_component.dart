import 'dart:io';
import 'package:core/core.dart';
import '../../../main_lib.dart';

class AttachmentChatComponent extends GetView<AttachmentChatController> {
  const AttachmentChatComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 13, right: 8),
        child: InkWell(
            onTap: () =>
                controller.pickFile().then((value) => attachmentPreview(value)),
            child: Icon(Icons.attach_file_rounded,
                color: Color(configController.colorThemeDefault.value))));
  }

  void attachmentPreview(PlatformFile? platformFile) {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              content: SizedBox(
                  height: (Get.size.height / 3),
                  child: Column(children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              controller.messageController.text = '';
                              Get.back();
                            },
                            icon: const Icon(Icons.cancel_outlined,
                                color: ColorsCollection.cPurple))),
                    platformFile == null
                        ? Container()
                        : ListTile(
                            title: Text(platformFile.name,
                                overflow: TextOverflow.clip),
                            subtitle: Text("${platformFile.size} B"),
                            isThreeLine: true,
                            leading: platformFile.extension! == 'png' ||
                                    platformFile.extension! == 'jpg' ||
                                    platformFile.extension! == 'jpeg'
                                ? Container(
                                    height: Get.width / 5,
                                    width: Get.width / 5,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                            color: Colors.black38,
                                            style: BorderStyle.solid),
                                        image: DecorationImage(
                                            image: FileImage(
                                                File(platformFile.path!)),
                                            fit: BoxFit.cover)))
                                : SizedBox.fromSize(
                                    size:
                                        Size((Get.width / 7), (Get.width / 7)),
                                    child: const ClipOval(
                                        child: Material(
                                            color: ColorsCollection.cPurple,
                                            child: Icon(
                                                Icons.insert_drive_file_rounded,
                                                color: Colors.white))))),
                    const SizedBox(height: 16),
                    Flexible(child: Obx(() {
                      return PrimaryTextfield(
                          textEditingController: controller.messageController,
                          textHint: DictionaryUtil.input_text_chat.tr,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          radius: 25,
                          maxLine: controller.isMaxLine.value ? 10 : null);
                    })),
                    const SizedBox(height: 8),
                    Obx(() {
                      return PrimaryButton(
                          title: 'Send',
                          onTap: controller.isValidMessage.value
                              ? () => controller.sendMessage()
                              : null);
                    })
                  ])));
        });
  }
}
