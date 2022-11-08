import 'dart:io';
import 'package:core/core.dart';

class StreamParam {
  int? projectId;
  String? section;
  DateTime? from;
  DateTime? to;
  String? sentiment;
  String? channels;
  int? limit;
  String? orderBy;
  String? orderDir;
  String? fromTime;
  String? toTime;
  int? offset;
  String? assign;
  String? searchBy;
  String? channelType;
  String? q;

  StreamParam(
      {this.projectId,
      this.section,
      this.from,
      this.to,
      this.sentiment,
      this.channels,
      this.limit,
      this.orderBy,
      this.orderDir,
      this.fromTime,
      this.toTime,
      this.offset,
      this.assign,
      this.searchBy,
      this.channelType,
      this.q});

  StreamParam.fromJson(Map<String, dynamic> json) {
    projectId = json['project'];
    section = json['section'];
    from = TimeUtils().dateStringToDateTime(json['from']);
    to = TimeUtils().dateStringToDateTime(json['to']);
    sentiment = json['sentiment'];
    channels = json['channels'];
    limit = json['limit'];
    orderBy = json['order_by'];
    orderDir = json['order_dir'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    offset = json['offset'];
    assign = json['assign'];
    searchBy = json['search_by'];
    channelType = json['channel_type'];
    q = json['q'];
  }

  Map<String, dynamic> toMap() {
    return {
      'project': projectId,
      'section': section,
      'from': TimeUtils().dateFormat(from!, dateFormat: 'yyyy-MM-dd'),
      'to': TimeUtils().dateFormat(to!, dateFormat: 'yyyy-MM-dd'),
      'sentiment': sentiment,
      'channels': channels,
      'limit': limit,
      'order_by': orderBy,
      'order_dir': orderDir,
      'from_time': fromTime,
      'to_time': toTime,
      'offset': offset,
      'assign': assign,
      'search_by': searchBy,
      'channel_type': channelType,
      'q': q
    };
  }
}

class TicketParam {
  final int projectId;
  final String ticketId;

  TicketParam(this.ticketId, {required this.projectId});

  Map<String, dynamic> toMap() {
    return {'project': projectId};
  }
}

class ReplyParam {
  final int projectId;
  final String accountId;
  final String campaignId;
  final String type;
  final String content;
  final File? file;

  ReplyParam(
      this.projectId, this.accountId, this.campaignId, this.type, this.content,
      {this.file});
}

class MultiCategoryParam {
  final int projectId;
  final String parentId;
  final bool isParent;

  MultiCategoryParam(this.projectId, this.parentId, this.isParent);

  Map<String, dynamic> parentToMap() {
    return {'project': projectId};
  }

  Map<String, dynamic> childrenToMap() {
    return {'project': projectId, 'parent': parentId};
  }
}

class CloseTicketParam {
  final String ticketId;
  final bool status;

  CloseTicketParam(this.ticketId, this.status);

  Map<String, dynamic> toMap() {
    return {'status': status};
  }
}

class TagParam {
  final int projectId;
  final int limit;
  final String q;

  TagParam(this.projectId, this.limit, this.q);

  Map<String, dynamic> toMap() {
    return {'limit': limit, 'project': projectId, 'q': q};
  }
}

class TemplateParam {
  final int project;
  final String channel;

  TemplateParam(this.project, this.channel);

  Map<String, dynamic> toMap() {
    return {'project': project, 'channel': channel};
  }
}

class CustomContactParam {
  final String contactId;
  final int clientId;
  final String template;
  final String ticketId;

  CustomContactParam(
      this.contactId, this.clientId, this.template, this.ticketId);

  Map<String, dynamic> toMap() {
    return {
      'contact_id': contactId,
      'client_id': clientId,
      'template': template,
      'ticket_id': ticketId
    };
  }
}

class CustomFieldParam {
  final String key;
  final String value;
  final String id;

  CustomFieldParam(this.key, this.value, this.id);
}
