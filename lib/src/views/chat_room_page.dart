import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class ChatRoomPage extends GetView<ChatRoomController> {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          controller.unlockMessage();
          return true;
        },
        child: GestureDetector(
            onTap: () => dismissKeyboard(context),
            child: Scaffold(
                backgroundColor: const Color(0xFFFBFBFB),
                appBar: _appBarWidget(),
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
                  Column(children: [
                    Flexible(
                        child: controller.obx(
                            (state) => (state as TicketData) == null
                                ? AlertDialogCustom().emptyWidget()
                                : _contentMessageWidget(),
                            onLoading:
                                AlertDialogCustom().loadingProgressIndicator(),
                            onError: (error) => AlertDialogCustom().onError(
                                onPressed: () =>
                                    controller.fetchTicketMessage(),
                                customText: error!),
                            onEmpty: AlertDialogCustom().emptyWidget())),
                    const Divider(
                        height: 1,
                        thickness: 1,
                        color: ColorsCollection.cDivider),
                    _composeWidget(context)
                  ])
                ]))));
  }

  AppBar _appBarWidget() {
    return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 64.w,
        title: const Expanded(child: ChatRoomHeaderComponents()));
  }

  _contentMessageWidget() {
    return Stack(children: [
      Obx(() {
        return controller.isLoadingHistory.value
            ? Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Center(child: AlertDialogCustom().lazyLoadWidget()))
            : Container();
      }),
      GetBuilder<SocketController>(builder: (socketController) {
        return socketController.messages.isEmpty
            ? Container()
            : GroupedListView<TicketStreams, DateTime>(
                controller: controller.scrollController,
                elements: socketController.messages,
                groupBy: (TicketStreams message) => DateTime(
                    message.dateTime!.year,
                    message.dateTime!.month,
                    message.dateTime!.day),
                groupHeaderBuilder: (TicketStreams message) => SizedBox(
                    height: 40,
                    child: Center(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                                DateFormat.yMMMd().format(message.dateTime!),
                                style: body3().copyWith(
                                    color: const Color(0xFF767676)))))),
                itemBuilder: (context, TicketStreams message) => InkWell(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: message.content));
                      Get.snackbar('Sukses', 'Berhasil Tersalin',
                          backgroundColor: ColorsCollection.cBlue,
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          dismissDirection: DismissDirection.horizontal,
                          animationDuration: const Duration(milliseconds: 400));
                    },
                    child: ChatRoomMessageComponent(item: message)),
                reverse: true,
                floatingHeader: true,
                useStickyGroupSeparators: true,
                order: GroupedListOrder.DESC);
      })
    ]);
  }

  Widget _composeWidget(BuildContext context) {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
            margin: const EdgeInsets.only(
                left: 5.0, right: 10, top: 10, bottom: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Flexible(child: Obx(() {
                return PrimaryTextfield(
                    textEditingController: controller.messageController,
                    textHint: DictionaryUtil.input_text_chat.tr,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    radius: 25,
                    maxLine: controller.isMaxLine.value ? 10 : null);
              })),
              const AttachmentChatComponent(),
              Obx(() {
                return controller.isValidMessage.value
                    ? IconButton(
                        iconSize: 30,
                        padding: const EdgeInsets.all(0),
                        icon: Icon(Icons.send,
                            color: Color(int.parse(configController
                                .colorBtnSend.value
                                .toString()))),
                        onPressed: () => controller.sendMessages())
                    : const SizedBox();
              })
            ])));
  }
}
