import 'package:core/core.dart';
import '../../../main_lib.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFBFBFB),
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 64.w,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios)),
            title: Text('History Chat Message',
                style: headline7().copyWith(fontWeight: FontWeight.w500))),
        body: Stack(children: [
          Positioned(
              left: 0,
              right: 0,
              top: -150,
              child: Image.asset(AssetsCollection.bg_lighter,
                  fit: BoxFit.fill,
                  scale: 8.0,
                  width: Get.size.width,
                  height: Get.size.height)),
          controller.listTickets!.isNotEmpty
              ? Obx(() {
                  return ListView.builder(
                      key: Key('selected ${controller.selectedItem.value}'),
                      itemCount: controller.listTickets!.length,
                      itemBuilder: (_, index) => ExpansionTile(
                              maintainState: true,
                              key: Key(index.toString()),
                              initiallyExpanded:
                                  index == controller.selectedItem.value,
                              onExpansionChanged: (isOpen) {
                                if (isOpen) {
                                  controller.selectedItem.value = index;
                                  controller.fetchTicketMessage(
                                      controller.listTickets![index].id!);
                                }
                              },
                              title: _expansionTitle(
                                  controller.listTickets![index]),
                              children: <Widget>[
                                Column(children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8),
                                      child: Container(
                                          height: 300,
                                          color: Colors.teal.withOpacity(0.05),
                                          child: controller.obx(
                                              (state) => (state as TicketData) == null
                                                  ? AlertDialogCustom()
                                                      .emptyWidget()
                                                  : GroupedListView<TicketStreams, DateTime>(
                                                      elements: controller
                                                          .listMessage.value,
                                                      groupBy: (TicketStreams message) => DateTime(
                                                          message.dateTime!.year,
                                                          message.dateTime!.month,
                                                          message.dateTime!.day),
                                                      groupHeaderBuilder: (TicketStreams message) => SizedBox(height: 40, child: Center(child: Padding(padding: const EdgeInsets.only(top: 8.0), child: Text(DateFormat.yMMMd().format(message.dateTime!), style: body3().copyWith(color: const Color(0xFF767676)))))),
                                                      itemBuilder: (context, TicketStreams message) => ChatRoomMessageComponent(item: message),
                                                      reverse: true,
                                                      floatingHeader: true,
                                                      useStickyGroupSeparators: true,
                                                      order: GroupedListOrder.DESC),
                                              onLoading: AlertDialogCustom().loadingProgressIndicator(),
                                              onError: (error) => AlertDialogCustom().onError(onPressed: () => controller.fetchTicketMessage(controller.listTickets![index].id!), customText: error!),
                                              onEmpty: AlertDialogCustom().emptyWidget())))
                                ])
                              ]));
                })
              : AlertDialogCustom().emptyWidget()
        ]));
  }

  _expansionTitle(PreviousTickets? item) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        Image.asset(item!.service!.chatSourceConverter(),
            height: 20, fit: BoxFit.fitHeight),
        const SizedBox(width: 5),
        Text('Ticket #${item.no}', style: body1())
      ]),
      Row(children: [
        const Icon(Icons.chat_bubble, size: 15, color: ColorsCollection.cGrey),
        const SizedBox(width: 5),
        Text("${item.count} | ", style: body1()),
        Text(
            TimeUtils()
                .dateFormat(TimeUtils().dateStringToDateTime(item.date!)),
            style: body1())
      ])
    ]);
  }
}
