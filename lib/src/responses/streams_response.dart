import 'package:core/core.dart';
import '../../main_lib.dart';

class StreamsResponse {
  List<StreamRows>? rows;

  StreamsResponse({this.rows});

  StreamsResponse.fromJson(Map<String, dynamic> json) {
    try {
      rows = List<StreamRows>.from(
          json["rows"].map((it) => StreamRows.fromJson(it)));
    } catch (e) {
      printError(info: 'ERROR StreamsResponse : $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rows'] = rows != null
        ? List<StreamRows>.from(
            data['rows'].map((it) => StreamRows.fromJson(it)))
        : null;
    return data;
  }
}

class StreamRows {
  int? order;
  StreamUser? user;
  String? content;
  String? source;
  String? type;
  String? date;
  DateTime? dateTime;
  int? count;
  int? no;
  String? id;
  int? sentiment;
  bool? isOther;
  bool? isProgress;
  bool? isPending;
  bool? isClose;
  bool? closeBySystem;
  bool? isOverNight;
  bool? isSpam;
  ActionBy? assignTo;
  StreamAccount? distributeTo;
  String? escalateNote;
  StreamLock? lock;
  String? subject;
  String? replied;
  String? repliedDate;
  bool? isBlacklist;
  bool? isBookmark;
  String? closedAt;
  ActionBy? closedBy;
  String? spammedAt;
  String? spammedBy;
  String? reopenedAt;
  String? reopenedBy;
  String? otheredAt;
  String? otheredBy;
  bool? isCreated;
  String? createdBy;
  Object? priority;
  StreamAccount? account;
  bool? trash;
  Object? lastRepliedBy;
  List<ImageContent>? image;
  FileContent? file;
  VideoContent? video;
  AudioContent? audio;
  String? repliedBy;

  StreamRows(
      {this.order,
      this.user,
      this.content,
      this.source,
      this.type,
      this.date,
      this.count,
      this.no,
      this.id,
      this.sentiment,
      this.isOther,
      this.isProgress,
      this.isPending,
      this.isClose,
      this.closeBySystem,
      this.isOverNight,
      this.isSpam,
      this.assignTo,
      this.distributeTo,
      this.escalateNote,
      this.lock,
      this.subject,
      this.replied,
      this.repliedDate,
      this.isBlacklist,
      this.isBookmark,
      this.closedAt,
      this.closedBy,
      this.spammedAt,
      this.spammedBy,
      this.reopenedAt,
      this.reopenedBy,
      this.otheredAt,
      this.otheredBy,
      this.isCreated,
      this.createdBy,
      this.priority,
      this.account,
      this.trash,
      this.lastRepliedBy,
      this.image,
      this.file,
      this.audio,
      this.video,
      this.repliedBy,
      this.dateTime});

  StreamRows.fromJson(Map<String, dynamic> json) {
    try {
      order = json['order'] ?? 0;
      user = json['user'] != null ? StreamUser.fromJson(json['user']) : null;
      content = json['content'] ?? '';
      source = json['source'] ?? '';
      type = json['type'] ?? '';
      date = json['date'] ?? '';
      dateTime = TimeUtils().dateStringToDateTime(json['date']);
      count = json['count'] ?? 0;
      no = json['no'] ?? 0;
      id = json['id'] ?? '';
      sentiment = json['sentiment'] ?? 0;
      isOther = json['is_other'] ?? false;
      isProgress = json['is_progress'] ?? false;
      isPending = json['is_pending'] ?? false;
      isClose = json['is_close'] ?? false;
      closeBySystem = json['close_by_system'] ?? false;
      isOverNight = json['is_over_night'] ?? false;
      isSpam = json['is_spam'] ?? false;
      assignTo = json['assign_to'] == null
          ? null
          : ActionBy.fromJsonMap(json['assign_to']);
      distributeTo = json['distribute_to'] == null
          ? null
          : StreamAccount.fromJson(json["distribute_to"]);
      escalateNote = json['escalate_note'] ?? '';
      lock = json['lock'] == null ? null : StreamLock.fromJsonMap(json["lock"]);
      subject = json['subject'] ?? '';
      replied = json['replied'] ?? '';
      repliedDate = json['replied_date'] ?? '';
      isBlacklist = json['is_blacklist'] ?? false;
      isBookmark = json['is_bookmark'] ?? false;
      closedAt = json['closed_at'] ?? '';
      closedBy = json['closed_by'] != null
          ? ActionBy.fromJsonMap(json['closed_by'])
          : null;
      spammedAt = json['spammed_at'] ?? '';
      spammedBy = json['spammed_by'] ?? '';
      reopenedAt = json['reopened_at'] ?? '';
      reopenedBy = json['reopened_by'] ?? '';
      otheredAt = json['othered_at'] ?? '';
      otheredBy = json['othered_by'] ?? '';
      isCreated = json['is_created'] ?? false;
      createdBy = json['created_by'] ?? '';
      priority = json['priority'];
      account = json['account'] != null
          ? StreamAccount.fromJson(json['account'])
          : null;
      trash = json['trash'] ?? false;
      lastRepliedBy = json['last_replied_by'];
      image = json["image"] == null
          ? null
          : List<ImageContent>.from(
              json["image"].map((it) => ImageContent.fromJsonMap(it)));
      file =
          json["file"] == null ? null : FileContent.fromJsonMap(json["file"]);
      audio = json["audio"] == null
          ? null
          : AudioContent.fromJsonMap(json["audio"]);
      video = json["video"] == null
          ? null
          : VideoContent.fromJsonMap(json["video"]);
      repliedBy = json['replied_by'] ?? '';
    } catch (e) {
      printError(info: 'ERROR STREAM ROWS : $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order'] = order;
    data['user'] = user == null ? null : user!.toJson();
    data['content'] = content;
    data['source'] = source;
    data['type'] = type;
    data['date'] = date;
    data['count'] = count;
    data['no'] = no;
    data['id'] = id;
    data['sentiment'] = sentiment;
    data['is_other'] = isOther;
    data['is_progress'] = isProgress;
    data['is_pending'] = isPending;
    data['is_close'] = isClose;
    data['close_by_system'] = closeBySystem;
    data['is_over_night'] = isOverNight;
    data['is_spam'] = isSpam;
    data['assign_to'] = assignTo;
    data['distribute_to'] =
        distributeTo == null ? null : distributeTo!.toJson();
    data['escalate_note'] = escalateNote;
    data['lock'] = lock == null ? null : lock!.toJson();
    data['subject'] = subject;
    data['replied'] = replied;
    data['replied_date'] = repliedDate;
    data['is_blacklist'] = isBlacklist;
    data['is_bookmark'] = isBookmark;
    data['closed_at'] = closedAt;
    data['closed_by'] = closedBy == null ? null : closedBy!.toJson();
    data['spammed_at'] = spammedAt;
    data['spammed_by'] = spammedBy;
    data['reopened_at'] = reopenedAt;
    data['reopened_by'] = reopenedBy;
    data['othered_at'] = otheredAt;
    data['othered_by'] = otheredBy;
    data['is_created'] = isCreated;
    data['created_by'] = createdBy;
    data['priority'] = priority;
    data['account'] = account == null ? null : account!.toJson();
    data['trash'] = trash;
    data['last_replied_by'] = lastRepliedBy;
    data['image'] =
        image != null ? image!.map((v) => v.toJson()).toList() : null;
    data['file'] = file == null ? null : file!.toJson();
    data['audio'] = audio == null ? null : audio!.toJson();
    data['video'] = video == null ? null : video!.toJson();
    data['replied_by'] = repliedBy;
    return data;
  }
}

class StreamLock {
  int? user;
  String? name;

  StreamLock({this.user, this.name});

  StreamLock.fromJsonMap(Map<String, dynamic> map) {
    try {
      name = map["name"] ?? '';
      user = map["user"] ?? '';
    } catch (e) {
      printError(info: 'ERROR StreamLock : ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['user'] = user;
    return data;
  }
}
