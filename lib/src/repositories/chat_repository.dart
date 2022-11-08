import 'package:core/core.dart';
import '../../main_lib.dart';

abstract class ChatRepository {
  Future fetchStreamMessage(StreamParam streamParam);
  Future fetchTicketMessage(TicketParam ticketParam);
  Future replyTickets(ReplyParam replyParam);
  Future unlockMessage(TicketParam ticketParam);
  Future fetchMultiCategories(MultiCategoryParam multiCategory);
  Future editProfile(body);
  Future closeTicket(CloseTicketParam closeTicketParam);
  Future fetchTagAutoComplete(TagParam tagParam);
  Future submitCategory(body, CategoryType type);
  Future fetchTemplateMessage(TemplateParam templateParam);
  Future statusAgent(String agentStatus);
  Future editCustomField(CustomFieldParam customFieldParam);
  Future editCustomContactField(CustomContactParam customParam);
}
