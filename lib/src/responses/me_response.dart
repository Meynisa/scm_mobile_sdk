import 'package:scm_mobile_sdk/main_lib.dart';

class MeResponse {
  MeData? data;

  MeResponse({this.data});

  MeResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? MeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data['data'] == null ? null : this.data!.toJson();
    return data;
  }
}

class MeData {
  int? lockToMe;
  int? id;
  String? name;
  String? status;
  String? level;
  String? email;
  String? avatar;
  String? type;
  List<MeProjects>? projects;
  int? clientId;
  MePackage? package;
  MeSubscription? subscription;
  int? ticketLimit;
  MeTicketTools? ticketTools;
  int? projetFinnet;
  List<MeChannelsType>? channelsType;
  String? activityCode;
  Object? autoAssignment;
  bool? createLog;
  int? responseWaiting;
  MeCsat? csat;

  MeData(
      {this.lockToMe,
      this.id,
      this.name,
      this.status,
      this.level,
      this.email,
      this.avatar,
      this.type,
      this.projects,
      this.clientId,
      this.package,
      this.subscription,
      this.ticketLimit,
      this.ticketTools,
      this.projetFinnet,
      this.channelsType,
      this.activityCode,
      this.autoAssignment,
      this.createLog,
      this.responseWaiting,
      this.csat});

  MeData.fromJson(Map<String, dynamic> json) {
    try {
      lockToMe = json['lock_to_me'];
      id = json['id'];
      name = json['name'];
      status = json['status'];
      level = json['level'];
      email = json['email'];
      avatar = json['avatar'];
      type = json['type'];
      projects = json['projects'] == null
          ? <MeProjects>[]
          : List<MeProjects>.from(
              json["projects"].map((it) => MeProjects.fromJson(it)));
      clientId = json['client_id'];
      package =
          json['package'] != null ? MePackage.fromJson(json['package']) : null;
      subscription = json['subscription'] != null
          ? MeSubscription.fromJson(json['subscription'])
          : null;
      ticketLimit = json['ticket_limit'];
      ticketTools = json['ticket_tools'] != null
          ? MeTicketTools.fromJson(json['ticket_tools'])
          : null;
      projetFinnet = json['projet_finnet'];
      channelsType = json['channels_type'] == null
          ? <MeChannelsType>[]
          : List<MeChannelsType>.from(
              json["channels_type"].map((it) => MeChannelsType.fromJson(it)));
      activityCode = json['activity_code'];
      autoAssignment = json['auto_assignment'] != null ? null : null;
      createLog = json['create_log'];
      responseWaiting = json['response_waiting'];
      csat = json['csat'] != null ? MeCsat.fromJson(json['csat']) : null;
    } catch (e) {
      printError(info: 'ERROR catch MeData: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lock_to_me'] = lockToMe;
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['level'] = level;
    data['email'] = email;
    data['avatar'] = avatar;
    data['type'] = type;
    data['projects'] = projects == null
        ? <MeProjects>[]
        : projects!.map((v) => v.toJson()).toList();
    data['client_id'] = clientId;
    data['package'] = package == null ? null : package!.toJson();
    data['subscription'] = subscription == null ? null : subscription!.toJson();
    data['ticket_limit'] = ticketLimit;
    data['ticket_tools'] = ticketTools == null ? null : ticketTools!.toJson();
    data['projet_finnet'] = projetFinnet;
    data['channels_type'] = channelsType == null
        ? <MeChannelsType>[]
        : channelsType!.map((v) => v.toJson()).toList();
    data['activity_code'] = activityCode;
    data['auto_assignment'] = autoAssignment == null ? null : null;
    data['create_log'] = createLog;
    data['response_waiting'] = responseWaiting;
    data['csat'] = csat == null ? csat : csat!.toJson();
    return data;
  }
}

class MeProjects {
  int? id;
  String? name;
  String? level;
  int? kpiCount;
  int? kpiTime;
  int? kpiWarning;
  List<String>? channels;

  MeProjects(
      {this.id,
      this.name,
      this.level,
      this.kpiCount,
      this.kpiTime,
      this.kpiWarning,
      this.channels});

  MeProjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    kpiCount = json['kpi_count'];
    kpiTime = json['kpi_time'];
    kpiWarning = json['kpi_warning'];
    channels = json['channels'] != null ? json['channels'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['level'] = level;
    data['kpi_count'] = kpiCount;
    data['kpi_time'] = kpiTime;
    data['kpi_warning'] = kpiWarning;
    data['channels'] = channels;
    return data;
  }
}

class MePackage {
  int? id;
  String? name;
  String? chargeType;
  String? currency;
  bool? isTrial;
  String? price;

  MePackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    chargeType = json['chargeType'];
    currency = json['currency'];
    isTrial = json['is_trial'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['chargeType'] = chargeType;
    data['currency'] = currency;
    data['is_trial'] = isTrial;
    data['price'] = price;
    return data;
  }
}

class MeSubscription {
  bool? status;
  Object? start;
  Object? end;
  int? endByDay;

  MeSubscription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    start = json['start'];
    end = json['end'];
    endByDay = json['end_by_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['start'] = start;
    data['end'] = end;
    data['end_by_day'] = endByDay;
    return data;
  }
}

class MeTicketTools {
  bool? forward;
  Object? forwardType;
  String? defaultNote;

  MeTicketTools.fromJson(Map<String, dynamic> json) {
    forward = json['forward'];
    forwardType = json['forward_type'];
    defaultNote = json['default_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forward'] = forward;
    data['forward_type'] = forwardType;
    data['default_note'] = defaultNote;
    return data;
  }
}

class MeChannelsType {
  String? name;
  String? value;

  MeChannelsType({this.name, this.value});

  MeChannelsType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class MeCsat {
  int? type;
  int? value;

  MeCsat.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}
