import '../../main_lib.dart';

class ReplyResponse {
  ReplyData? data;
  bool? fr;
  ReplyActivity? activity;

  ReplyResponse({this.data, this.fr, this.activity});

  ReplyResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ReplyData.fromJson(json['data']) : null;
    fr = json['fr'];
    activity = json['activity'] != null
        ? ReplyActivity.fromJson(json['activity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data['data'] == null ? null : this.data!.toJson();
    data['fr'] = fr;
    data['activity'] = data['activity'] == null ? null : activity!.toJson();
    return data;
  }
}

class ReplyData {
  StreamUser? user;
  String? id;
  String? content;
  String? source;
  String? type;
  String? date;
  bool? read;
  bool? trash;
  bool? isOwner;
  Object? replyAt;

  ReplyData(
      {this.user,
      this.id,
      this.content,
      this.source,
      this.type,
      this.date,
      this.read,
      this.trash,
      this.isOwner,
      this.replyAt});

  ReplyData.fromJson(Map<String, dynamic> json) {
    try {
      user = json['user'] != null ? StreamUser.fromJson(json['user']) : null;
      id = json['id'] ?? '';
      content = json['content'] ?? '';
      source = json['source'] ?? '';
      type = json['type'] ?? '';
      date = json['date'] ?? '';
      read = json['read'] ?? false;
      trash = json['trash'] ?? false;
      isOwner = json['is_owner'] ?? false;
      replyAt = json['reply_at'];
    } catch (e) {
      printError(info: 'ERROR REPLY $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = data['user'] == null ? null : user!.toJson();
    data['id'] = id;
    data['content'] = content;
    data['source'] = source;
    data['type'] = type;
    data['date'] = date;
    data['read'] = read;
    data['trash'] = trash;
    data['is_owner'] = isOwner;
    data['reply_at'] = replyAt;
    return data;
  }
}

class ReplyActivity {
  ActivityData? data;
  String? type;
  int? user;
  int? project;
  String? updatedAt;
  String? createdAt;
  String? sId;
  String? id;

  ReplyActivity(
      {this.data,
      this.type,
      this.user,
      this.project,
      this.updatedAt,
      this.createdAt,
      this.sId,
      this.id});

  ReplyActivity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ActivityData.fromJson(json['data']) : null;
    type = json['type'];
    user = json['user'];
    project = json['project'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data['data'] == null ? null : this.data!.toJson();
    data['type'] = type;
    data['user'] = user;
    data['project'] = project;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class ActivityData {
  DataId? id;
  DataId? streamId;

  ActivityData({this.id, this.streamId});

  ActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? DataId.fromJson(json['id']) : null;
    streamId =
        json['stream_id'] != null ? DataId.fromJson(json['stream_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = data['id'] == null ? null : id!.toJson();
    data['stream_id'] = data['stream_id'] == null ? null : streamId!.toJson();
    return data;
  }
}

class DataId {
  String? oid;

  DataId({this.oid});

  DataId.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$oid'] = oid;
    return data;
  }
}
