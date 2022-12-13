import 'package:scm_mobile_sdk/main_lib.dart';

class ReadSocketResponse {
  String? section;
  SocketData? data;

  ReadSocketResponse({this.section, this.data});

  ReadSocketResponse.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    data = json['data'] != null ? SocketData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section'] = section;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SocketData {
  String? id;
  int? no;
  int? user;
  String? name;
  int? project;
  int? clientId;
  bool? isProgress;
  String? ticket;

  SocketData(
      {this.id,
      this.no,
      this.user,
      this.name,
      this.project,
      this.clientId,
      this.isProgress,
      this.ticket});

  SocketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    no = json['no'];
    user = json['user'];
    name = json['name'];
    project = json['project'];
    clientId = json['client_id'];
    if (json['is_progress'] != null) {
      isProgress = json['is_progress'];
    }
    if (json['ticket'] != null) {
      ticket = json['ticket'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['no'] = no;
    data['user'] = user;
    data['name'] = name;
    data['project'] = project;
    data['client_id'] = clientId;
    if (isProgress != null) {
      data['is_progress'] = isProgress;
    }
    if (ticket != null) {
      data['ticket'] = ticket;
    }
    return data;
  }
}

class UnlockSocketResponse {
  String? section;
  SocketData? data;

  UnlockSocketResponse({this.section, this.data});

  UnlockSocketResponse.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    data = json['data'] != null ? SocketData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section'] = section;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CloseSocketResponse {
  String? section;
  SocketData? data;
  String? message;

  CloseSocketResponse({this.section, this.data, this.message});

  CloseSocketResponse.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    data = json['data'] != null ? SocketData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section'] = section;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class AssignSocketResponse {
  String? section;
  String? type;
  AssignSocketData? data;

  AssignSocketResponse({this.section, this.type, this.data});

  AssignSocketResponse.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    type = json['type'];
    data =
        json['data'] != null ? AssignSocketData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section'] = section;
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AssignSocketData {
  String? content;
  String? ticket;
  int? user;
  int? project;
  int? agentId;
  int? clientId;

  AssignSocketData(
      {this.content,
      this.ticket,
      this.user,
      this.project,
      this.agentId,
      this.clientId});

  AssignSocketData.fromJson(Map<String, dynamic> json) {
    try {
      content = json['content'] ?? '';
      ticket = json['ticket'] ?? '';
      user = json['user'] ?? 0;
      project = json['project'] ?? 0;
      agentId = json['agent_id'] ?? 0;
      clientId = json['client_id'] ?? 0;
    } catch (e) {
      printError(info: 'ERROR AssignSocketData : ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['ticket'] = ticket;
    data['user'] = user;
    data['project'] = project;
    data['agent_id'] = agentId;
    data['client_id'] = clientId;
    return data;
  }
}
