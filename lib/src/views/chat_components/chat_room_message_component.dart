import 'package:core/core.dart';
import '../../../main_lib.dart';
import 'dart:io';

class ChatRoomMessageComponent extends GetView<ChatRoomController> {
  final TicketStreams? item;

  const ChatRoomMessageComponent({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _messageModel();
  }

  Widget _messageModel() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Container(
                          margin: item!.isOwner!
                              ? const EdgeInsets.only(right: 2.0)
                              : const EdgeInsets.only(left: 2.0),
                          padding: item!.isOwner!
                              ? const EdgeInsets.only(left: 40)
                              : const EdgeInsets.only(right: 40),
                          child: Column(
                              mainAxisAlignment: item!.isOwner!
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: item!.isOwner!
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: item!.isOwner!
                                            ? Color(configController
                                                .bgColorMsgOwner
                                                .value) //ColorsCollection.cBlue
                                            : Color(configController
                                                .bgColorMsgSender
                                                .value), //ColorsCollection.cDefault,
                                        borderRadius: item!.isOwner!
                                            ? const BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                topLeft: Radius.circular(8),
                                                bottomLeft: Radius.circular(8))
                                            : const BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                topLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(8))),
                                    child: Column(
                                        crossAxisAlignment: item!.isOwner!
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        children: <Widget>[
                                          item!.isOwner!
                                              ? const SizedBox()
                                              : item!.user!.isWaGroup!
                                                  ? Text(
                                                      '${item!.user!.realName} - ${item!.user!.hp}',
                                                      style: body3().copyWith(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Color(
                                                              configController
                                                                  .lblColorMsgOwner
                                                                  .value)))
                                                  : const SizedBox(),
                                          item!.isSent == true
                                              ? _repliedFileWidget()
                                              : _senderFileWidget(),
                                          item!.content == ''
                                              ? const SizedBox()
                                              : const SizedBox(height: 6.0),
                                          Text(
                                              (item!.source == 'email'
                                                      ? item!.content!
                                                          .formattedContentEmail()
                                                      : item!.content!)
                                                  .formattedHtmlContent()
                                                  .parseHtmlString(),
                                              textAlign: TextAlign.start,
                                              style: body1().copyWith(
                                                  fontWeight: fontWeight(),
                                                  fontStyle: fontStyle(),
                                                  color: item!.isOwner!
                                                      ? Color(configController
                                                          .lblColorMsgOwner
                                                          .value)
                                                      : Color(configController
                                                          .lblColorMsgSender
                                                          .value),
                                                  decoration: textDecoration()))
                                        ])),
                                EmailChatComponent(item: item!),
                                const SizedBox(height: 6.0),
                                Text(
                                    "send at ${item!.source == 'whatsapp' ? item!.dateTime!.dateConverter(dateFormat: "HH:mm") : item!.date!.dateConverter(dateFormat: "HH:mm")}",
                                    style: body4().copyWith(
                                        color: ColorsCollection.cContentGrey,
                                        fontWeight: FontWeight.w400)),
                                item!.source == "whatsapp"
                                    ? _ackStatus(ackId: item!.ack)
                                    : const SizedBox(),
                                item!.isOwner! && item!.user!.isWaGroup!
                                    ? const SizedBox(height: 6.0)
                                    : const SizedBox(),
                                item!.isOwner!
                                    ? item!.user!.isWaGroup!
                                        ? Text(
                                            'replied by ${item!.user!.realName}',
                                            style: body3().copyWith(
                                                fontStyle: FontStyle.italic))
                                        : const SizedBox()
                                    : const SizedBox()
                              ]))),
                  // item!.isOwner!
                  //     ? item!.isSent!
                  //         ? Container()
                  //         : InkWell(
                  //             child: const Icon(
                  //               Icons.error,
                  //               color: Colors.red,
                  //             ),
                  //             onTap: () => controller.replyMessage(isResendMsg: true))
                  //     : Container()
                ]),
          ],
        ));
  }

  Widget _repliedFileWidget() {
    return item!.mimee == "image"
        ? Container(
            height: Get.size.width / 1.5,
            width: Get.size.width / 1.5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(item!.image![0].standard!)),
                    fit: BoxFit.cover)))
        : SocketExtender().chatTypeTicket(item!) != ChatType.FILE
            ? SocketExtender().chatTypeTicket(item!) != ChatType.AUDIO
                ? SocketExtender().chatTypeTicket(item!) != ChatType.VIDEO
                    ? const SizedBox()
                    : _fileTypeWidget(
                        () {}, Icons.video_library, item!.video!.url)
                : _fileTypeWidget(() {}, Icons.library_music, item!.audio!.url)
            : _fileTypeWidget(() {}, Icons.insert_drive_file, item!.file!.url);
  }

  Widget _senderFileWidget() {
    return SocketExtender().chatTypeTicket(item!) != ChatType.IMAGE
        ? SocketExtender().chatTypeTicket(item!) != ChatType.FILE
            ? SocketExtender().chatTypeTicket(item!) != ChatType.AUDIO
                ? SocketExtender().chatTypeTicket(item!) != ChatType.VIDEO
                    ? const SizedBox()
                    : _fileTypeWidget(
                        () => controller.launchURL(item!.video!.url!),
                        Icons.video_library,
                        item!.video!.url)
                : _fileTypeWidget(() => controller.launchURL(item!.audio!.url!),
                    Icons.library_music, item!.audio!.title)
            : _fileTypeWidget(() => controller.launchURL(item!.file!.url!),
                Icons.insert_drive_file, item!.file!.name)
        : InkWell(
            onTap: () => Get.toNamed(AppPages.PICTURE_DETAIL, arguments: {
                  'avatar': Get.arguments['user']['avatar'],
                  'url': item!.image![0].standard,
                  'date': '${DateTime.now()}',
                  'name': Get.arguments['user']['name']
                }),
            child: PlaceholderWidget(
                borderRadius: 0,
                size: Get.size.width / 1.5,
                fit: BoxFit.contain,
                imgAssets: item!.image![0].standard));
  }

  Widget _ackStatus({int? ackId = 0}) {
    if (item!.isOwner == true) {
      if (ackId == 1) {
        return const Icon(
          Icons.cancel,
          size: 15,
          color: Colors.red,
        );
      } else if (ackId == 2) {
        return const Icon(
          Icons.done,
          size: 15,
          color: Colors.white,
        );
      } else if (ackId == 3) {
        return const Icon(
          Icons.done_all,
          size: 15,
          color: Colors.white,
        );
      } else {
        return const Icon(
          Icons.done,
          size: 15,
          color: Colors.white,
        );
      }
    } else {
      return const SizedBox();
    }
  }

  Widget _fileTypeWidget(
      GestureTapCallback? onTapped, IconData? iconData, String? fileName) {
    return InkWell(
        onTap: onTapped,
        child: Row(children: <Widget>[
          Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item!.isOwner!
                      ? ColorsCollection.cDefault
                      : ColorsCollection.cBlue),
              child: Icon(iconData,
                  color: item!.isOwner!
                      ? ColorsCollection.cBlue
                      : ColorsCollection.cDefault)),
          const SizedBox(width: 5),
          Expanded(
              child: Text(fileName!,
                  style: subtitle7().copyWith(
                      color: item!.isOwner! ? Colors.white : Colors.black)))
        ]));
  }

  FontWeight fontWeight() {
    return item!.content != ""
        ? item!.content![0] == "*" &&
                item!.content!.substring(item!.content!.length - 1) == "*"
            ? FontWeight.bold
            : FontWeight.normal
        : FontWeight.normal;
  }

  FontStyle fontStyle() {
    return item!.content! != ""
        ? item!.content![0] == "_" &&
                item!.content!.substring(item!.content!.length - 1) == "_"
            ? FontStyle.italic
            : FontStyle.normal
        : FontStyle.normal;
  }

  TextDecoration textDecoration() {
    return item!.content! != ""
        ? item!.content![0] == "~" &&
                item!.content!.substring(item!.content!.length - 1) == "~"
            ? TextDecoration.lineThrough
            : TextDecoration.none
        : TextDecoration.none;
  }
}
