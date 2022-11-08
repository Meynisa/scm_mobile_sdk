import 'package:core/core.dart';

import '../../main_lib.dart';

class TicketStreams {
  StreamUser? user;
  String? id;
  String? content;
  String? source;
  String? account;
  String? type;
  String? date;
  DateTime? dateTime;
  bool? read;
  bool? trash;
  bool? isOwner;
  List<ActivityCode>? activityCode;
  Object? sr;
  Object? replyAt;
  bool? isFile;
  bool? isAudio;
  FileContent? file;
  AudioContent? audio;
  Object? repliedBy;
  Object? escalateId;
  List<AttachmentContent>? attachments;
  bool? isImage;
  List<ImageContent>? image;
  bool? isVideo;
  VideoContent? video;
  int? ack;
  bool? isSent;
  int? chatId;
  String? mimee;

  TicketStreams(
      {this.user,
      this.id,
      this.content,
      this.source,
      this.account,
      this.type,
      this.date,
      this.read,
      this.trash,
      this.isOwner,
      this.activityCode,
      this.sr,
      this.replyAt,
      this.isFile,
      this.isAudio,
      this.file,
      this.audio,
      this.repliedBy,
      this.escalateId,
      this.attachments,
      this.isImage,
      this.image,
      this.ack,
      this.isSent,
      this.chatId,
      this.isVideo,
      this.video,
      this.dateTime,
      this.mimee});

  TicketStreams.fromJson(Map<String, dynamic> json) {
    try {
      user = json["user"] == null ? null : StreamUser.fromJson(json["user"]);
      id = json["id"] ?? '';
      content = json["content"] ?? "";
      source = json["source"] ?? "";
      account = json["account"] ?? "";
      type = json["type"] ?? "";
      date = json["date"] ??
          TimeUtils()
              .dateFormat(DateTime.now(), dateFormat: 'yyyy-MM-dd HH:mm:ss');
      dateTime = TimeUtils().dateStringToDateTime(json["date"]);
      read = json["read"] ?? false;
      trash = json["trash"] ?? false;
      isOwner = json["is_owner"] ?? false;
      activityCode = json["activity_code"] == null
          ? <ActivityCode>[]
          : List<ActivityCode>.from(
              json["activity_code"].map((it) => ActivityCode.fromJson(it)));
      sr = json["sr"];
      replyAt = json["reply_at"];
      isFile = json["is_file"] ?? false;
      isAudio = json["is_audio"] ?? false;
      file =
          json["file"] == null ? null : FileContent.fromJsonMap(json["file"]);
      audio = json["audio"] == null
          ? null
          : AudioContent.fromJsonMap(json["audio"]);
      repliedBy = json["replied_by"];
      escalateId = json["escalate_id"];
      isImage = json["is_image"] ?? false;
      image = json['image'] == null
          ? null
          : List<ImageContent>.from(
              json["image"].map((it) => ImageContent.fromJsonMap(it)));
      isVideo = json["is_video"] ?? false;
      video = json["video"] == null
          ? null
          : VideoContent.fromJsonMap(json["video"]);
      attachments = json["attachments"] == null
          ? <AttachmentContent>[]
          : List<AttachmentContent>.from(json["attachments"]
              .map((it) => AttachmentContent.fromJsonMap(it)));
      ack = json["ack"] ?? 0;
      isSent = json["isSent"] ?? true;
      chatId = json["chatId"] ?? 0;
      mimee = json['mimee'] ?? 'text';
    } catch (e) {
      printError(info: 'ERROR TICKET STREAM : ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user == null ? null : user!.toJson();
    data['id'] = id;
    data['content'] = content;
    data['source'] = source;
    data['account'] = account;
    data['type'] = type;
    data['date'] = TimeUtils().dateStringToDateTime(date!);
    data['read'] = read;
    data['trash'] = trash;
    data['is_owner'] = isOwner ?? false;
    data['activity_code'] = activityCode != null
        ? activityCode!.map((v) => v.toJson()).toList()
        : null;
    data['sr'] = sr;
    data['reply_at'] = replyAt;
    data['is_file'] = isFile ?? false;
    data['is_video'] = isVideo ?? false;
    data['file'] = file == null ? null : file!.toJson();
    data['audio'] = audio == null ? null : audio!.toJson();
    data['video'] = video == null ? null : video!.toJson();
    data['replied_by'] = repliedBy;
    data['escalate_id'] = escalateId;
    data['is_image'] = isImage ?? false;
    data['is_audio'] = isAudio ?? false;
    data['image'] = image != null ? image!.map((v) => v.toJson()).toList() : [];
    data['attachments'] =
        attachments != null ? attachments!.map((v) => v.toJson()).toList() : [];
    data['ack'] = ack ?? 0;
    data['isSent'] = isSent ?? true;
    data['chatId'] = chatId ?? 0;
    data['mimee'] = mimee ?? 'text';
    return data;
  }
}

class Forward {
  List<CustomFields>? customFields;

  Forward({this.customFields});

  Forward.fromJson(Map<String, dynamic> json) {
    if (json['custom_fields'] != null) {
      customFields = <CustomFields>[];
      json['custom_fields'].forEach((v) {
        customFields!.add(CustomFields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customFields != null) {
      data['custom_fields'] = customFields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
