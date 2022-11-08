import '../../main_lib.dart';

class TicketResponse {
  TicketData? data;

  TicketResponse({this.data});

  TicketResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? TicketData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data['data'] == null ? null : this.data!.toJson();
    return data;
  }
}

class TicketData {
  String? id;
  int? no;
  String? service;
  String? type;
  String? domain;
  bool? isClose;
  bool? isOther;
  bool? isBookmark;
  bool? isOnline;
  bool? isSpam;
  bool? isProgress;
  bool? isPending;
  Object? note;
  Object? sr;
  String? account;
  String? date;
  int? totalTicket;
  List<PreviousTickets>? previousTickets;
  List<ActivityCode>? activityCode;
  String? caption;
  String? postUrl;
  List<TicketStreams>? streams;
  TicketUser? user;
  List<dynamic>? emailCc;
  List<dynamic>? emailTo;
  List<dynamic>? emailBcc;
  List<CustomContactField>? customContactField;
  List<CustomFields>? customFields;
  List<AdditionalTicketInfo>? additionalTicketInfo;
  Object? forwardPartner;
  bool? isCreated;
  Object? createdBy;
  Object? priority;
  Object? assignTo;
  Object? subject;
  bool? isWaBusiness;
  bool? isWaMultidevice;
  bool? isReplied;
  bool? accountNotExists;
  int? sentiment;
  Forward? forward;

  TicketData(
      {this.id,
      this.no,
      this.service,
      this.type,
      this.domain,
      this.isClose,
      this.isOther,
      this.isBookmark,
      this.isOnline,
      this.isSpam,
      this.isProgress,
      this.isPending,
      this.note,
      this.sr,
      this.account,
      this.date,
      this.totalTicket,
      this.previousTickets,
      this.activityCode,
      this.caption,
      this.postUrl,
      this.streams,
      this.user,
      this.emailCc,
      this.emailTo,
      this.emailBcc,
      this.customContactField,
      this.customFields,
      this.additionalTicketInfo,
      this.forwardPartner,
      this.isCreated,
      this.createdBy,
      this.priority,
      this.assignTo,
      this.subject,
      this.isWaBusiness,
      this.isWaMultidevice,
      this.isReplied,
      this.accountNotExists,
      this.sentiment,
      this.forward});

  TicketData.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] ?? '';
      no = json['no'] ?? 0;
      service = json['service'] ?? '';
      type = json['type'] ?? '';
      domain = json['domain'] ?? '';
      isClose = json['is_close'] ?? false;
      isOther = json['is_other'] ?? false;
      isBookmark = json['is_bookmark'] ?? false;
      isOnline = json['is_online'] ?? false;
      isSpam = json['is_spam'] ?? false;
      isProgress = json['is_progress'] ?? false;
      isPending = json['is_pending'] ?? false;
      note = json['note'];
      sr = json['sr'];
      account = json['account'] ?? '';
      date = json['date'] ?? '';
      totalTicket = json['total_ticket'] ?? 0;
      previousTickets = json['previous_tickets'] == null
          ? <PreviousTickets>[]
          : List<PreviousTickets>.from(json["previous_tickets"]
              .map((it) => PreviousTickets.fromJson(it)));
      activityCode = json['activity_code'] == null
          ? <ActivityCode>[]
          : List<ActivityCode>.from(
              json["activity_code"].map((it) => ActivityCode.fromJson(it)));
      caption = json['caption'] ?? '';
      postUrl = json['post_url'] ?? '';
      streams = json['streams'] == null
          ? <TicketStreams>[]
          : List<TicketStreams>.from(
              json["streams"].map((it) => TicketStreams.fromJson(it)));
      user = json['user'] != null ? TicketUser.fromJson(json['user']) : null;
      emailCc = json["email_cc"] ?? [];
      emailTo = json["email_to"] ?? [];
      emailBcc = json["email_bcc"] ?? [];
      if (json['custom_contact_field'] != null) {
        customContactField = <CustomContactField>[];
        json['custom_contact_field'].forEach((v) {
          customContactField!.add(CustomContactField.fromJson(v));
        });
      }
      if (json['custom_fields'] != null) {
        customFields = <CustomFields>[];
        json['custom_fields'].forEach((v) {
          customFields!.add(CustomFields.fromJson(v));
        });
      }
      if (json['additional_ticket_info'] != null) {
        additionalTicketInfo = <AdditionalTicketInfo>[];
        json['additional_ticket_info'].forEach((v) {
          additionalTicketInfo!.add(AdditionalTicketInfo.fromJson(v));
        });
      }
      forwardPartner = json['forward_partner'];
      isCreated = json['is_created'] ?? false;
      createdBy = json['created_by'];
      priority = json['priority'];
      assignTo = json['assign_to'];
      subject = json['subject'];
      isWaBusiness = json['is_wa_business'] ?? false;
      isWaMultidevice = json['is_wa_multidevice'] ?? false;
      isReplied = json['is_replied'] ?? false;
      accountNotExists = json['account_not_exists'] ?? false;
      sentiment = json['sentiment'] ?? 0;
      forward =
          json['forward'] != null ? Forward.fromJson(json['forward']) : null;
    } catch (e) {
      printError(info: 'ERROR TICKETS DATA $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['no'] = no;
    data['service'] = service;
    data['type'] = type;
    data['domain'] = domain;
    data['is_close'] = isClose;
    data['is_other'] = isOther;
    data['is_bookmark'] = isBookmark;
    data['is_online'] = isOnline;
    data['is_spam'] = isSpam;
    data['is_progress'] = isProgress;
    data['is_pending'] = isPending;
    data['note'] = note;
    data['sr'] = sr;
    data['account'] = account;
    data['date'] = date;
    data['total_ticket'] = totalTicket;
    data['previous_tickets'] = previousTickets != null
        ? previousTickets!.map((v) => v.toJson()).toList()
        : <PreviousTickets>[];
    data['activity_code'] = activityCode != null
        ? activityCode!.map((v) => v.toJson()).toList()
        : <ActivityCode>[];
    data['caption'] = caption;
    data['post_url'] = postUrl;
    data['streams'] = streams != null
        ? streams!.map((v) => v.toJson()).toList()
        : <TicketStreams>[];
    data['user'] = user == null ? null : user!.toJson();
    if (emailCc != null) {
      data['email_cc'] = emailCc!.map((v) => v).toList();
    }
    if (emailTo != null) {
      data['email_to'] = emailTo!.map((v) => v).toList();
    }
    if (emailBcc != null) {
      data['email_bcc'] = emailBcc!.map((v) => v).toList();
    }
    if (customContactField != null) {
      data['custom_contact_field'] =
          customContactField!.map((v) => v.toJson()).toList();
    }
    if (customFields != null) {
      data['custom_fields'] = customFields!.map((v) => v.toJson()).toList();
    }
    if (additionalTicketInfo != null) {
      data['additional_ticket_info'] =
          additionalTicketInfo!.map((v) => v.toJson()).toList();
    }
    data['forward_partner'] = forwardPartner;
    data['is_created'] = isCreated;
    data['created_by'] = createdBy;
    data['priority'] = priority;
    data['assign_to'] = assignTo;
    data['subject'] = subject;
    data['is_wa_business'] = isWaBusiness;
    data['is_wa_multidevice'] = isWaMultidevice;
    data['is_replied'] = isReplied;
    data['account_not_exists'] = accountNotExists;
    data['sentiment'] = sentiment;
    if (forward != null) {
      data['forward'] = forward!.toJson();
    }
    return data;
  }
}

class PreviousTickets {
  String? id;
  int? no;
  String? date;
  int? count;
  String? service;
  bool? isExpanded;

  PreviousTickets(
      {this.id, this.no, this.date, this.count, this.service, this.isExpanded});

  PreviousTickets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    no = json['no'];
    date = json['date'];
    count = json['count'];
    service = json['service'];
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['no'] = no;
    data['date'] = date;
    data['count'] = count;
    data['service'] = service;
    data['isExpanded'] = false;
    return data;
  }
}
