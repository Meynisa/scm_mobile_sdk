import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class SocketExtender {
  void addMessages(NewCommentData? commentData, String ticketId,
      RxList<TicketStreams> messages) {
    TicketStreams item = TicketStreams(
        id: commentData!.id,
        content: '${commentData.content}' == 'null'
            ? commentData.replied ?? ''
            : '${commentData.content}',
        date: '${commentData.date}',
        dateTime: commentData.source == 'whatsapp'
            ? TimeUtils().dateStringToDateTimeWA('${commentData.date}')
            : TimeUtils().dateStringToDateTime('${commentData.date}'),
        image: commentData.image == null
            ? null
            : [ImageContent(standard: commentData.image!.standard)],
        isImage: commentData.image == null ? false : true,
        audio: commentData.audio == null
            ? null
            : AudioContent(
                url: commentData.audio!.url, title: commentData.audio!.title),
        isAudio: commentData.file == null ? false : true,
        file: commentData.file == null
            ? null
            : FileContent(
                url: commentData.file!.url, name: commentData.file!.name),
        isFile: commentData.file == null ? false : true,
        isVideo: commentData.video == null ? false : true,
        attachments: [],
        source: commentData.source,
        isSent: true,
        user: StreamUser(
            realName: commentData.user!.realName,
            name: commentData.user!.name,
            hp: commentData.user!.hp,
            isWaGroup: commentData.user!.isWaGroup ?? false),
        isOwner: commentData.isOwner);
    String roomId =
        PreferenceUtils().getStringPreferences(StringPreferences.roomId) ?? '';
    if (ticketId == roomId) {
      messages.add(item);
    }
  }

  void updateTicketsStatus(int from, int to, TicketStreams item, int no,
      RxList<List<StreamRows>> listAllTickets, bool isConsist) {
    StreamRows? itemFrom;
    for (int i = 0; i < listAllTickets[from].length; i++) {
      if (item.id == listAllTickets[from][i].id) {
        itemFrom = listAllTickets[from][i];
        listAllTickets[from].removeAt(i);
      }
    }

    for (int i = 0; i < listAllTickets[to].length; i++) {
      if (item.id == listAllTickets[to][i].id) {
        isConsist = true;
        listAllTickets[to][i].content = item.content;
        listAllTickets[to][i].date = item.date;
      }
    }
    if (!isConsist && itemFrom != null) {
      listAllTickets[to].insert(0, itemFrom);
    } else if (!isConsist && itemFrom == null) {
      itemFrom = StreamRows(
          content: item.content,
          date: item.date,
          source: item.source,
          no: no,
          user: StreamUser(
              avatar: item.user!.avatar,
              hp: item.user!.hp,
              isWaGroup: item.user!.isWaGroup ?? false,
              name: item.user!.name));
      listAllTickets[to].insert(0, itemFrom);
    }
  }

  int ticketTypeConverter(String type) {
    switch (type) {
      case 'open':
        return 0;
      case 'progress':
        return 1;
      case 'closed':
        return 2;
      case 'pending':
        return 3;
      case 'escalated':
        return 4;
      case 'spam':
        return 5;
      default:
        return 0;
    }
  }

  String intTypeToString(int index) {
    switch (index) {
      case 0:
        return 'open';
      case 1:
        return 'progress';
      case 2:
        return 'closed';
      case 3:
        return 'pending';
      case 4:
        return 'escalated';
      case 5:
        return 'spam';
      default:
        return 'open';
    }
  }

  Future parseJson(Map<String, dynamic> text) {
    return compute(parseAndDecode, text);
  }

  ChatType? chatType(StreamRows item) {
    return item.file == null
        ? item.audio == null
            ? item.image == null
                ? item.video == null
                    ? ChatType.TEXT
                    : ChatType.VIDEO
                : ChatType.IMAGE
            : ChatType.AUDIO
        : ChatType.FILE;
  }

  ChatType? chatTypeTicket(TicketStreams item) {
    return item.file == null
        ? item.audio == null
            ? item.image == null
                ? item.video == null
                    ? ChatType.TEXT
                    : ChatType.VIDEO
                : ChatType.IMAGE
            : ChatType.AUDIO
        : ChatType.FILE;
  }
}
