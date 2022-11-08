import 'package:core/core.dart';
import '../../../main_lib.dart';

class ChatContentComponent extends GetView<ChatContentController> {
  final StreamRows item;
  const ChatContentComponent({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => controller.onTapNextPage(item: item),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            PlaceholderWidget(
                imgAssets: item.user?.avatar,
                imgPlaceholder: AssetsCollection.ic_avatar),
            const SizedBox(width: 15),
            Expanded(
                child: Row(children: [
              Expanded(flex: 3, child: _secondRowWidget()),
              Expanded(flex: 2, child: _thirdRowWidget())
            ]))
          ]),
          const SizedBox(height: 5),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                item.lock != null
                    ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        const Icon(Icons.lock_rounded,
                            size: 16, color: ColorsCollection.cDarkGrey),
                        const SizedBox(width: 5),
                        Text(item.lock!.name!,
                            style: body3()
                                .copyWith(color: ColorsCollection.cDarkGrey))
                      ])
                    : const SizedBox(),
                item.lock != null && item.assignTo != null
                    ? Text('  |  ',
                        style: subtitle7()
                            .copyWith(color: ColorsCollection.cDarkGrey))
                    : const SizedBox(),
                item.assignTo != null
                    ? Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: ColorsCollection.cDisableColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Text('Assign to ${item.assignTo!.name}',
                            style: body3()
                                .copyWith(color: ColorsCollection.cDarkGrey)))
                    : const SizedBox()
              ]),
          Align(
              alignment: Alignment.centerRight,
              child: controller.ticketType.value != TicketType.closed
                  ? controller.ticketType.value == TicketType.progress
                      ? item.repliedBy == '' || item.repliedBy == null
                          ? Container()
                          : Text('last reply | ${item.repliedBy}',
                              style: body1())
                      : Container()
                  : item.closedBy == null
                      ? Container()
                      : Text('closed by | ${item.closedBy!.name}',
                          style: body1())),
          const SizedBox(height: 15)
        ]));
  }

  Column _secondRowWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(item.user!.realName!,
          style: body1(), overflow: TextOverflow.ellipsis),
      const SizedBox(height: 4),
      Row(children: [
        SocketExtender().chatType(item) != ChatType.TEXT
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                    SocketExtender().chatType(item) != ChatType.AUDIO
                        ? SocketExtender().chatType(item) != ChatType.IMAGE
                            ? SocketExtender().chatType(item) != ChatType.FILE
                                ? SocketExtender().chatType(item) !=
                                        ChatType.VIDEO
                                    ? Icons.image
                                    : Icons.video_library
                                : Icons.insert_drive_file
                            : Icons.image
                        : Icons.library_music,
                    color: Colors.black26))
            : Container(),
        Expanded(
            child: Text(
                (item.content!).formattedHtmlContent().parseHtmlString(),
                style: body1().copyWith(color: const Color(0xFF4A4A4A)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1))
      ])
    ]);
  }

  Widget _thirdRowWidget() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Expanded(
            child: Text('#${item.no}',
                style: body3().copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis)),
        const SizedBox(width: 8),
        Image.asset(item.source!.chatSourceConverter(),
            height: 16.w, fit: BoxFit.fitHeight)
      ]),
      const SizedBox(height: 4),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Expanded(
            child: Text(
                item.source == 'whatsapp'
                    ? item.dateTime!.datetimeConverter()
                    : item.date!.datetimeConverter(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: body3().copyWith(color: ColorsCollection.cDarkGrey))),
        const SizedBox(width: 8),
        item.count == 0
            ? Container()
            : Container(
                height: 16.w,
                width: 16.w,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ColorsCollection.cBlue),
                child: Center(
                    child: Text(item.count.toString(),
                        style: body4().copyWith(color: Colors.white))))
      ])
    ]);
  }
}
