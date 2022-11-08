import 'package:core/core.dart';

class TemplateResponse {
  TemplateData? templateData;

  TemplateResponse({this.templateData});

  TemplateResponse.fromJson(Map<String, dynamic> json) {
    templateData =
        json['data'] != null ? TemplateData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (templateData != null) {
      data['data'] = templateData!.toJson();
    }
    return data;
  }
}

int i = 0;

class TemplateData {
  int? currentPage;
  List<ChannelData>? channelData;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  TemplateData(
      {this.currentPage,
      this.channelData,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  TemplateData.fromJson(Map<String, dynamic> json) {
    try {
      currentPage = json['current_page'];
      channelData = List<ChannelData>.from(
          json["data"].map((it) => ChannelData.fromJson(it)));
      firstPageUrl = json['first_page_url'];
      from = json['from'];
      lastPage = json['last_page'];
      lastPageUrl = json['last_page_url'];
      nextPageUrl = json['next_page_url'];
      path = json['path'];
      perPage = json['per_page'];
      prevPageUrl = json['prev_page_url'];
      to = json['to'];
      total = json['total'];
    } catch (e) {
      printError(info: 'ERROR TemplateData : $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    i = 0;
    data['data'] = channelData != null
        ? List<ChannelData>.from(
            data['data'].map((it) => ChannelData.fromJson(it)))
        : [];
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class ChannelData {
  int? id;
  String? name;
  String? channelMedia;
  String? content;
  int? isChecked;

  ChannelData(
      {this.id, this.name, this.channelMedia, this.content, this.isChecked});

  ChannelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    channelMedia = json['channel_media'];
    content = json['content'];
    isChecked = i++;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['channel_media'] = channelMedia;
    data['content'] = content;
    data['isChecked'] = isChecked ?? 0;
    return data;
  }
}
