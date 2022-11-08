import 'package:core/core.dart';
import '../../../main_lib.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatServices _chatServices = ChatServices();

  @override
  Future fetchStreamMessage(StreamParam streamParam) async {
    var response = await _chatServices.fetchStreamMessage(streamParam);
    if (response.data != null) {
      var res = response.data;
      res = StreamsResponse.fromJson(res);
      return res;
    } else {
      return throw Exception('failed to fetch stream message');
    }
  }

  @override
  Future fetchTicketMessage(TicketParam ticketParam) async {
    var response = await _chatServices.fetchTicketMessage(ticketParam);
    if (response.data != null) {
      var res = response.data;
      res = TicketResponse.fromJson(res);
      return res;
    } else {
      return throw Exception('failed to fetch ticket message');
    }
  }

  @override
  Future replyTickets(ReplyParam replyParam) async {
    var response = await _chatServices.replyTicket(replyParam);
    if (response.data != null) {
      var res = response.data;
      res = ReplyResponse.fromJson(res);
      return res;
    } else {
      return throw Exception('failed to replay tickets');
    }
  }

  @override
  Future unlockMessage(TicketParam ticketParam) async {
    var response = await _chatServices.unlockMessage(ticketParam);
    if (response.data != null) {
      var res = response.data;
      return res;
    } else {
      return throw Exception('failed to unlock messages');
    }
  }

  @override
  Future fetchMultiCategories(MultiCategoryParam multiCategory) async {
    var response = await _chatServices.multiCategory(multiCategory);
    if (response.data != null) {
      var res = response.data;
      var listData = res['data'];
      List<ActivityCode> data = (listData as List).isNotEmpty
          ? listData.map((i) => ActivityCode.fromJson(i)).toList()
          : [];
      return data;
    } else {
      return throw Exception('failed to get multi categories');
    }
  }

  @override
  Future editProfile(body) async {
    var response = await _chatServices.editProfile(body);
    if (response.data != null) {
      var res = response.data;
      return res;
    } else {
      return throw Exception('failed to post edit profile');
    }
  }

  @override
  Future closeTicket(CloseTicketParam closeTicketParam) async {
    var response = await _chatServices.closeTicket(closeTicketParam);
    if (response.data != null) {
      var res = response.data;
      return res;
    } else {
      return throw Exception('failed to post close ticket');
    }
  }

  @override
  Future fetchTagAutoComplete(TagParam tagParam) async {
    var response = await _chatServices.tagAutoComplete(tagParam);
    if (response.data != null) {
      var res = response.data;
      List<ActivityCode> data = (res as List).isNotEmpty
          ? res.map((i) => ActivityCode.fromJson(i)).toList()
          : [];
      return data;
    } else {
      return throw Exception('failed to get tag auto complete');
    }
  }

  @override
  Future submitCategory(body, CategoryType type) async {
    var response = await _chatServices.submitCategory(body, type);
    if (response.data != null) {
      var res = response.data;
      return res;
    } else {
      return throw Exception('failed to submit category type : $type ');
    }
  }

  @override
  Future fetchTemplateMessage(TemplateParam templateParam) async {
    var response = await _chatServices.templateMessage(templateParam);
    if (response.data != null) {
      var res = response.data;
      res = TemplateResponse.fromJson(res);
      return res;
    } else {
      return throw Exception('failed to fetch template param');
    }
  }

  @override
  Future statusAgent(String agentStatus) async {
    var response = await _chatServices.statusAgent(agentStatus);
    if (response.data != null) {
      var res = response.data;
      return res;
    } else {
      return throw Exception('failed to submit status agent : $agentStatus');
    }
  }

  @override
  Future editCustomContactField(CustomContactParam customParam) async {
    var response = await _chatServices.editCustomContactField(customParam);
    if (response.data != null) {
      var res = response.data;
      return res;
    } else {
      return throw Exception('failed to edit custom contact field');
    }
  }

  @override
  Future editCustomField(CustomFieldParam customFieldParam) async {
    var response = await _chatServices.editCustomField(customFieldParam);
    if (response.data != null) {
      var res = response.data;
      return res;
    } else {
      return throw Exception('failed to edit custom field');
    }
  }
}
