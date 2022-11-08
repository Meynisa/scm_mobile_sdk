import 'package:core/core.dart';
import '../../../main_lib.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  late IO.Socket socket;
  RxList<TicketStreams> messages = RxList<TicketStreams>();
  RxList<List<StreamRows>> listAllTickets = [
    [StreamRows()],
    [StreamRows()],
    [StreamRows()],
    [StreamRows()],
    [StreamRows()],
    [StreamRows()],
  ].obs;
  RxInt newUpdateMsg = 0.obs;
  String ticketId = '';
  int ticketNo = 0;
  bool isConsist = false;
  int from = 0;
  int to = 0;
  StreamRows? lockTicketItem;
  Rx<TicketType> ticketType = TicketType.open.obs;
  StreamRows streamItem = StreamRows();

  final NotificationController notificationController =
      Get.find<NotificationController>();

  void connectingSocket() {
    String token = PreferenceUtils().getUserToken() ?? '';
    int projectId =
        PreferenceUtils().getFromPreferences(StringPreferences.projectId) ?? 0;
    socket = IO.io(Endpoint.socketUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      'query': {"token": token}
    });

    socket.connect();
    socket.on('connect', (data) {
      printInfo(info: "Connect : $data, $projectId");
      socket.emit('project', projectId);
    });

    socket.onConnect((data) => printInfo(info: "Connected : $data"));
    socket.on(
        'connect_timeout', (data) => printInfo(info: 'SOCKET_TIMEOUT : $data'));
    socket.on('connect_error',
        (data) => printInfo(info: 'SOCKET_CONNECT_ERROR : $data'));
    socket.on(
        'reconnect', (data) => printInfo(info: 'SOCKET_RECONNECT : $data'));
    socket.on(
        'connecting', (data) => printInfo(info: 'SOCKET_CONNECTING : $data'));

    socket.on('hello', ((data) async {
      printInfo(info: "socket hello: $data");
      if (data["section"] == 'summary-dashboard') {
        SocketExtender().parseJson(data).then((value) {
          SummarySocketResponse summaryData = value;
          _summaryDataMethod(summaryData.data);
        });
      } else if (data["section"] == 'unlock_ticket') {
        SocketExtender().parseJson(data).then((value) {
          UnlockSocketResponse unlockData = value;
          _unlockDataMethod(unlockData.data);
        });
      } else if (data["section"] == 'read_ticket') {
        SocketExtender().parseJson(data).then((value) {
          ReadSocketResponse readData = value;
          _readDataMethod(readData.data);
        });
      } else if (data["section"] == 'assignment') {
        _assignDataMethod(data);
      } else if (data["section"] == 'close') {
        SocketExtender().parseJson(data).then((value) {
          CloseSocketResponse closeData = value;
          _closeMethod(closeData.data);
        });
      } else if (data["section"] == 'refresh_online') {
        if (data['data']['user']['status'] == null) {
          ChatContentController? chatContentControlller;
          chatContentControlller = ChatContentController();
          chatContentControlller.fetchStreamMessage();
        } else {
          //nothing happened
        }
      } else if (data["section"] == 'newupdate') {
        SocketExtender().parseJson(data).then((value) {
          NewUpdateSocketResponse updateData = value;
          _newUpdateMethod(updateData.data);
        });
      } else if (data["section"] == 'newcomment') {
        SocketExtender().parseJson(data).then((value) {
          NewCommentSocketResponse commentData = value;
          _newCommentMethod(commentData.data);
        });
      }
    }));

    printInfo(info: " isconnect ${socket.connected}");
  }

  void _summaryDataMethod(SummarySocketData? summaryData) {
    (summaryData!.isNew == true || listAllTickets[from].isEmpty) &&
            summaryData.service != 'chat'
        ? newUpdateMsg.value = newUpdateMsg.value + 1
        : null;
    from = SocketExtender().ticketTypeConverter(summaryData.from!);
    to = SocketExtender().ticketTypeConverter(summaryData.to!);
    if (from != to) {
      StreamRows? itemFrom;
      for (int i = 0; i < listAllTickets[from].length; i++) {
        if (ticketId == listAllTickets[from][i].id) {
          itemFrom = listAllTickets[from][i];
          listAllTickets[from].removeAt(i);
        }
      }

      for (int i = 0; i < listAllTickets[to].length; i++) {
        if (ticketId == listAllTickets[to][i].id) {
          isConsist = true;
          if (itemFrom != null) listAllTickets[to][i] = itemFrom;
        }
      }
      if (!isConsist && itemFrom != null) {
        listAllTickets[to].insert(0, itemFrom);
      }
    }
    to == 0 &&
            (summaryData.service != 'chat' || summaryData.service != 'email') &&
            from != 0
        ? newUpdateMsg.value = newUpdateMsg.value + 1
        : null;
    from = to;
    update();
  }

  void _unlockDataMethod(SocketData? unlockData) {
    ticketId = '${unlockData!.id}';
    for (int i = 0; i < listAllTickets.length; i++) {
      for (int j = 0; j < listAllTickets[i].length; j++) {
        if (ticketId == listAllTickets[i][j].id) {
          listAllTickets[i][j].lock = null;
        }
      }
    }
    update();
  }

  void _readDataMethod(SocketData? readData) {
    ticketNo = readData!.no ?? 0;
    lockTicketItem = null;
    for (int i = 0; i < listAllTickets.length; i++) {
      for (int j = 0; j < listAllTickets[i].length; j++) {
        if (ticketNo == listAllTickets[i][j].no) {
          listAllTickets[i][j].lock =
              StreamLock(user: readData.user, name: readData.name);
          listAllTickets[i][j].count = 0;
        }
      }
    }
    update();
  }

  void _assignDataMethod(assignData) {
    ticketId = assignData['data']['ticket'] ?? '';
    lockTicketItem = null;
    for (int i = 0; i < listAllTickets.length; i++) {
      for (int j = 0; j < listAllTickets[i].length; j++) {
        if (ticketId == listAllTickets[i][j].id) {
          listAllTickets[i][j].assignTo =
              ActionBy(name: "${assignData['data']['agent_id']}");
          listAllTickets[i][j].count = 0;
        }
      }
    }
    update();
  }

  void _closeMethod(SocketData? closeData) {
    ticketId = '${closeData!.ticket}';
    for (int j = 0; j < listAllTickets[from].length; j++) {
      if (ticketId == listAllTickets[from][j].id) {
        listAllTickets[2].insert(0, listAllTickets[from][j]);
        listAllTickets[from].removeAt(j);
      }
    }
    update();
  }

  void _newUpdateMethod(NewUpdateData? updateData) {
    ticketId = '${updateData!.ticket}';
    for (int i = 0; i < listAllTickets[to].length; i++) {
      if (ticketId == listAllTickets[to][i].id) {
        listAllTickets[to][i].count =
            (listAllTickets[to][i].count! + updateData.count!);
      }
    }
    update();
  }

  void _newCommentMethod(NewCommentData? commentData) {
    ticketId = '${commentData!.ticket}';
    int ticketIdx = 0;
    bool addTickets = false;
    bool isWaGroup = commentData.user!.isWaGroup ?? false;
    String? source = '${commentData.source}';
    String? contentTicket = '${commentData.content}' == 'null'
        ? commentData.replied ?? ''
        : '${commentData.content}';
    List<ImageContent>? image = commentData.image == null
        ? null
        : [ImageContent(standard: commentData.image!.standard)];
    AudioContent? audio = commentData.audio == null
        ? null
        : AudioContent(
            url: commentData.audio!.url, title: commentData.audio!.title);
    FileContent? file = commentData.file == null
        ? null
        : FileContent(url: commentData.file!.url, name: commentData.file!.name);
    VideoContent? video = commentData.video == null
        ? null
        : VideoContent(url: commentData.video!.url, duration: 1);

    SocketExtender().addMessages(commentData, ticketId, messages);

    for (int i = 0; i < listAllTickets[to].length; i++) {
      if (ticketId == listAllTickets[to][i].id && source != 'chat') {
        StreamRows item = listAllTickets[to][i];
        item.user!.name = '${commentData.user!.name}';
        item.user!.avatar = '${commentData.user!.avatar}';
        item.user!.isWaGroup = isWaGroup;
        item.user!.hp = commentData.user!.hp;
        item.content = contentTicket;
        item.date = '${commentData.date}';
        item.dateTime = commentData.source == 'whatsapp'
            ? TimeUtils().dateStringToDateTimeWA('${commentData.date}')
            : TimeUtils().dateStringToDateTime('${commentData.date}');
        item.image = image;
        item.file = file;
        item.audio = audio;
        item.video = video;
        item.source = '${commentData.source}';
        ticketIdx = i;
        addTickets = true;
        streamItem = listAllTickets[to][i];
      }
    }

    if (addTickets) {
      StreamRows element = listAllTickets[to][ticketIdx];
      listAllTickets[to].removeAt(ticketIdx);
      listAllTickets[to].insert(0, element);
    } else {
      StreamRows item = StreamRows(
          id: ticketId,
          content: contentTicket,
          date: '${commentData.date}',
          dateTime: commentData.source == 'whatsapp'
              ? TimeUtils().dateStringToDateTimeWA('${commentData.date}')
              : TimeUtils().dateStringToDateTime('${commentData.date}'),
          image: image,
          file: file,
          video: video,
          audio: audio,
          source: source,
          user: StreamUser(
              name: '${commentData.user!.name}',
              isWaGroup: commentData.user!.isWaGroup ?? false,
              hp: commentData.user!.hp,
              avatar: '${commentData.user!.avatar}'));

      streamItem = item;
    }

    notificationController.notifUpdates(commentData, ticketId);
    update();
  }

  void replyMessages(TicketStreams item, int no) {
    messages.add(item);
    update();
  }

  TicketStreams? updateChatStatus(int chatId) {
    TicketStreams? data;
    for (var item in messages) {
      if (chatId == item.chatId) {
        item.isSent = false;
        data = item;
      }
    }
    update();
    return data;
  }

  notificationOnSelect() {
    Get.toNamed(AppPages.CHAT_ROOM,
        arguments: streamItem.toJson(),
        parameters: {'ticket_type': ticketType.value.name});
  }

  void disconnectingSocket() {
    try {
      socket.clearListeners();
      socket.destroy();
      socket.dispose();
      socket.disconnect();
      socket.io.disconnect();
      socket.io.close();
      socket.io.destroy(socket);

      printInfo(info: 'SOCKET DISCONNECTED');
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
