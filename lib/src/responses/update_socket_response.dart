import '../../main_lib.dart';

class NewCommentSocketResponse {
  String? section;
  NewCommentData? data;

  NewCommentSocketResponse({this.section, this.data});

  NewCommentSocketResponse.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    data = json['data'] != null ? NewCommentData.fromJson(json['data']) : null;
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

class NewCommentData {
  int? project;
  String? ticket;
  StreamUser? user;
  String? id;
  String? content;
  String? replied;
  String? source;
  String? account;
  String? type;
  String? date;
  bool? read;
  bool? trash;
  bool? isOwner;
  ImageContent? image;
  FileContent? file;
  AudioContent? audio;
  VideoContent? video;

  NewCommentData(
      {this.project,
      this.ticket,
      this.user,
      this.id,
      this.content,
      this.source,
      this.account,
      this.type,
      this.date,
      this.read,
      this.trash,
      this.isOwner,
      this.replied,
      this.image,
      this.file,
      this.audio,
      this.video});

  NewCommentData.fromJson(Map<String, dynamic> json) {
    project = json['project'];
    ticket = json['ticket'];
    user = json['user'] != null ? StreamUser.fromJson(json['user']) : null;
    id = json['id'];
    content = json['content'];
    source = json['source'];
    account = json['account'];
    type = json['type'];
    date = json['date'];
    read = json['read'];
    trash = json['trash'];
    isOwner = json['is_owner'];
    replied = json['replied'];
    image =
        json['image'] != null ? ImageContent.fromJsonMap(json['image']) : null;
    file = json['file'] != null ? FileContent.fromJsonMap(json['file']) : null;
    audio =
        json['audio'] != null ? AudioContent.fromJsonMap(json['audio']) : null;
    video =
        json['video'] != null ? VideoContent.fromJsonMap(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project'] = project;
    data['ticket'] = ticket;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['id'] = id;
    data['content'] = content;
    data['source'] = source;
    data['account'] = account;
    data['type'] = type;
    data['date'] = date;
    data['read'] = read;
    data['trash'] = trash;
    data['is_owner'] = isOwner;
    data['replied'] = replied;
    data['image'] = image;
    data['audio'] = audio;
    data['file'] = file;
    data['video'] = video;
    return data;
  }
}

class NewUpdateSocketResponse {
  String? section;
  NewUpdateData? data;

  NewUpdateSocketResponse({this.section, this.data});

  NewUpdateSocketResponse.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    data = json['data'] != null ? NewUpdateData.fromJson(json['data']) : null;
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

class NewUpdateData {
  int? project;
  String? channel;
  int? count;
  String? ticket;
  String? account;
  ActionBy? user;

  NewUpdateData(
      {this.project,
      this.channel,
      this.count,
      this.ticket,
      this.account,
      this.user});

  NewUpdateData.fromJson(Map<String, dynamic> json) {
    project = json['project'];
    channel = json['channel'];
    count = json['count'];
    ticket = json['ticket'];
    account = json['account'];
    user = json['user'] != null ? ActionBy.fromJsonMap(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project'] = project;
    data['channel'] = channel;
    data['count'] = count;
    data['ticket'] = ticket;
    data['account'] = account;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class SummarySocketResponse {
  String? section;
  SummarySocketData? data;

  SummarySocketResponse({this.section, this.data});

  SummarySocketResponse.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    data =
        json['data'] != null ? SummarySocketData.fromJson(json['data']) : null;
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

class SummarySocketData {
  int? project;
  String? service;
  String? from;
  String? to;
  Object? action;
  bool? isNew;

  SummarySocketData(
      {this.project,
      this.service,
      this.from,
      this.to,
      this.action,
      this.isNew});

  SummarySocketData.fromJson(Map<String, dynamic> json) {
    project = json['project'];
    service = json['service'];
    from = json['from'];
    to = json['to'];
    action = json['action'];
    isNew = json['is_new'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project'] = project;
    data['service'] = service;
    data['from'] = from;
    data['to'] = to;
    data['action'] = action;
    data['is_new'] = isNew;
    return data;
  }
}

parseAndDecode(Map<String, dynamic> response) {
  switch (response['section']) {
    case 'newupdate':
      return NewUpdateSocketResponse.fromJson(response);
    case 'newcomment':
      return NewCommentSocketResponse.fromJson(response);
    case 'summary-dashboard':
      return SummarySocketResponse.fromJson(response);
    case 'read_ticket':
      return ReadSocketResponse.fromJson(response);
    case 'unlock_ticket':
      return UnlockSocketResponse.fromJson(response);
    case 'close':
      return CloseSocketResponse.fromJson(response);
  }
}
