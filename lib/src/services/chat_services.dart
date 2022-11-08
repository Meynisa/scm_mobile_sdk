import 'package:core/core.dart';
import '../parameters/parameters.dart';

class ChatServices {
  Future<Response<dynamic>> fetchStreamMessage(StreamParam streamParam) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .get(Endpoint.streams, queryParameters: streamParam.toMap());
  }

  Future<Response<dynamic>> fetchTicketMessage(TicketParam ticketParam) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .get('${Endpoint.tickets}/${ticketParam.ticketId}',
            queryParameters: ticketParam.toMap());
  }

  Future<Response<dynamic>> replyTicket(ReplyParam replyParam) async {
    String? fileName, mimeType, mimee, type;

    if (replyParam.file != null) {
      fileName = replyParam.file!.path.split('/').last;
      mimeType = mime(fileName);
      mimee = mimeType!.split('/')[0];
      type = mimeType.split('/')[1];
    }

    FormData formData = FormData.fromMap({
      "project": replyParam.projectId,
      "account": replyParam.accountId,
      "id": replyParam.campaignId,
      "type": replyParam.type,
      "content": replyParam.content,
      "attachments[]": replyParam.file != null
          ? await MultipartFile.fromFile(replyParam.file!.path,
              filename: fileName, contentType: MediaType(mimee!, type!))
          : ''
    });

    return DioConfig.addInterceptorsMultipart(
            dio: DioConfig.createDioWithForm(), isRequireAuth: true)
        .post(Endpoint.replyChat, data: formData);
  }

  Future<Response<dynamic>> unlockMessage(TicketParam ticketParam) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .get('${Endpoint.unlockTickets}/${ticketParam.ticketId}');
  }

  Future<Response<dynamic>> multiCategory(MultiCategoryParam categoryParam) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .get(Endpoint.multiCategories,
            queryParameters: categoryParam.isParent
                ? categoryParam.parentToMap()
                : categoryParam.childrenToMap());
  }

  Future<Response<dynamic>> editProfile(body) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .post(Endpoint.editProfile, data: body);
  }

  Future<Response<dynamic>> closeTicket(CloseTicketParam closeTicketParam) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .post('${Endpoint.tickets}/${closeTicketParam.ticketId}/close',
            queryParameters: closeTicketParam.toMap());
  }

  Future<Response<dynamic>> tagAutoComplete(TagParam tagParam) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .get(Endpoint.tagListAutoComplete, queryParameters: tagParam.toMap());
  }

  Future<Response<dynamic>> submitCategory(body, CategoryType type) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDioWithForm(), isRequireAuth: true)
        .post(
            type == CategoryType.tag
                ? Endpoint.createTag
                : Endpoint.createTicketCategories,
            data: body);
  }

  Future<Response<dynamic>> templateMessage(TemplateParam templateParam) {
    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .get(Endpoint.templateMessage, queryParameters: templateParam.toMap());
  }

  Future<Response<dynamic>> statusAgent(String agentStatus) {
    Map<String, dynamic> body = <String, dynamic>{};
    body['agent_status'] = agentStatus;
    return DioConfig.addInterceptors(
            dio: DioConfig.createDioWithForm(), isRequireAuth: true)
        .post(Endpoint.statusAgent, data: body);
  }

  Future<Response<dynamic>> editCustomField(CustomFieldParam customFieldParam) {
    FormData formData =
        FormData.fromMap({customFieldParam.key: customFieldParam.value});

    return DioConfig.addInterceptors(
            dio: DioConfig.createDio(), isRequireAuth: true)
        .post("${Endpoint.customFieldUpdate}/${customFieldParam.id}",
            data: formData);
  }

  Future<Response<dynamic>> editCustomContactField(
      CustomContactParam customParam) {
    FormData formData = FormData.fromMap(customParam.toMap());

    return DioConfig.addInterceptors(
            dio: DioConfig.createDioWithForm(), isRequireAuth: true)
        .post(Endpoint.customContactFieldUpdate, data: formData);
  }
}
