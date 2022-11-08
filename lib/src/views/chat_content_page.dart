import 'package:core/core.dart';
import '../../../main_lib.dart';

class ChatContentPage extends GetView<ChatContentController> {
  const ChatContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15, top: 15, left: 15),
        child: RefreshIndicator(
            color: Colors.white,
            backgroundColor: ColorsCollection.cPurple,
            onRefresh: () => controller.fetchStreamMessage(),
            child: Column(children: [
              Obx(() {
                return controller.socketController.newUpdateMsg.value == 0
                    ? Container()
                    : Center(
                        child: Column(children: [
                        const SizedBox(height: 8),
                        Text(
                            'View ${controller.socketController.newUpdateMsg.value} new update tickets'),
                        IconButton(
                            onPressed: () => controller.newUpdatesOnTapped(),
                            icon: const Icon(Icons.replay_rounded,
                                color: ColorsCollection.cPurple))
                      ]));
              }),
              Expanded(
                  child: controller.obx(
                      (state) => (state as List<StreamRows>).isEmpty ||
                              (state)[0].id == null
                          ? AlertDialogCustom().emptyWidget(
                              isReload: true,
                              onPressed: () => controller.fetchStreamMessage())
                          : GetBuilder<SocketController>(
                              builder: (socketController) {
                              return socketController
                                      .listAllTickets[
                                          controller.ticketType.value.index]
                                      .isEmpty
                                  ? AlertDialogCustom().emptyWidget()
                                  : ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) =>
                                          ChatContentComponent(
                                              item:
                                                  socketController.listAllTickets[
                                                      controller.ticketType
                                                          .value.index][index]),
                                      itemCount: socketController
                                          .listAllTickets[controller.ticketType.value.index]
                                          .length);
                            }),
                      onLoading: AlertDialogCustom().loadingProgressIndicator(),
                      onError: (error) => AlertDialogCustom().onError(
                          onPressed: () => controller.fetchStreamMessage()),
                      onEmpty: AlertDialogCustom().emptyWidget()))
            ])));
  }
}
