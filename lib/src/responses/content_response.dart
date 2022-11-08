class ImageContent {
  String? thumbnail;
  String? standard;

  ImageContent({this.thumbnail, this.standard});

  ImageContent.fromJsonMap(Map<String, dynamic> map)
      : thumbnail = map["thumbnail"] ?? "",
        standard = map["standard"] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumbnail'] = thumbnail ?? "";
    data['standard'] = standard ?? "";
    return data;
  }
}

class VideoContent {
  String? url;
  int? duration;

  VideoContent({this.url, this.duration});

  VideoContent.fromJsonMap(Map<String, dynamic> map)
      : url = map["url"] ?? "",
        duration = map["duration"] ?? 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url ?? "";
    data['duration'] = duration ?? 0;
    return data;
  }
}

class FileContent {
  String? url;
  String? name;

  FileContent({this.url, this.name});

  FileContent.fromJsonMap(Map<String, dynamic> map)
      : url = map["url"] ?? "",
        name = map["name"] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url ?? "";
    data['name'] = name ?? "";
    return data;
  }
}

class AttachmentContent {
  String? download;
  String? name;

  AttachmentContent({this.download, this.name});

  AttachmentContent.fromJsonMap(Map<String, dynamic> map)
      : download = map["download"] ?? "",
        name = map["name"] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['download'] = download ?? "";
    data['name'] = name ?? "";
    return data;
  }
}

class AudioContent {
  String? url;
  String? title;

  AudioContent({this.url, this.title});

  AudioContent.fromJsonMap(Map<String, dynamic> map)
      : url = map["url"] ?? "",
        title = map["title"] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url ?? "";
    data['title'] = title ?? "";
    return data;
  }
}
