import 'package:core/core.dart';
import '../../../main_lib.dart';

class EmailChatComponent extends GetView<ChatRoomController> {
  final TicketStreams item;

  const EmailChatComponent({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      item.source == "email" &&
              item.content!.contains("</div>\n<br><div>\n<div dir=\"ltr\">")
          ? _prevEmailWidget()
          : Container(),
      item.attachments != null || item.attachments!.isNotEmpty
          ? _emailAttachmentWidget()
          : Container(),
    ]);
  }

  Widget _prevEmailWidget() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            width: 4.0, color: ColorsCollection.cDefault)),
                    color: Color.fromRGBO(237, 237, 237, 1)),
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Percakapan Sebelumnya \n\n',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  const ChatRoomMessageComponent().fontWeight(),
                              fontStyle:
                                  const ChatRoomMessageComponent().fontStyle(),
                              color: ColorsCollection.cDefault,
                              decoration: const ChatRoomMessageComponent()
                                  .textDecoration())),
                      TextSpan(
                          text: item.content!
                              .formattedContentEmail(isPrevMsg: true)
                              .formattedHtmlContent()
                              .parseHtmlString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  const ChatRoomMessageComponent().fontWeight(),
                              fontStyle:
                                  const ChatRoomMessageComponent().fontStyle(),
                              color:
                                  item.isOwner! ? Colors.white : Colors.black,
                              decoration: const ChatRoomMessageComponent()
                                  .textDecoration()))
                    ]),
                    textAlign: TextAlign.start))));
  }

  Widget _emailAttachmentWidget() {
    return Center(
        child: SizedBox(
            width: Get.size.width / 2,
            height: item.attachments!.length * 50,
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Center(
                      child: InkWell(
                          onTap: () => controller
                              .launchURL(item.attachments![index].download!),
                          child: Text(
                              "Download ${item.attachments![index].name}",
                              style: headline1().copyWith(
                                  decoration: TextDecoration.underline,
                                  color: ColorsCollection.cBlue),
                              maxLines: 2)));
                },
                itemCount: item.attachments!.length)));
  }
}
