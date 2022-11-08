import '../../main_lib.dart';

class TicketChannels {
  String? channel;
  String? id;
  String? name;
  String? realName;
  String? profileUrl;
  String? avatar;
  Object? protected;
  int? followersCount;
  int? friendsCount;
  int? statusesCount;

  TicketChannels(
      {this.channel,
      this.id,
      this.name,
      this.realName,
      this.profileUrl,
      this.avatar,
      this.protected,
      this.followersCount,
      this.friendsCount,
      this.statusesCount});

  TicketChannels.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    id = json['id'];
    name = json['name'];
    realName = json['real_name'];
    profileUrl = json['profile_url'];
    avatar = json['avatar'];
    protected = json['protected'];
    followersCount = json['followers_count'] ?? 0;
    friendsCount = json['friends_count'] ?? 0;
    statusesCount = json['statuses_count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['id'] = id;
    data['name'] = name;
    data['real_name'] = realName;
    data['profile_url'] = profileUrl;
    data['avatar'] = avatar;
    data['protected'] = protected;
    data['followers_count'] = followersCount;
    data['friends_count'] = friendsCount;
    data['statuses_count'] = statusesCount;
    return data;
  }
}

class CustomContactField {
  String? label;
  String? type;
  String? id;
  bool? isWebchat;
  bool? required;
  String? placeholder;
  String? description;
  List<String>? options;
  String? value;

  CustomContactField(
      {this.label,
      this.type,
      this.id,
      this.isWebchat,
      this.required,
      this.placeholder,
      this.description,
      this.options,
      this.value});

  CustomContactField.fromJson(Map<String, dynamic> json) {
    try {
      label = json['label'] ?? '';
      type = json['type'] ?? '';
      id = json['id'] ?? '';
      isWebchat = json['is_webchat'] ?? false;
      required = json['required'] ?? false;
      placeholder = json['placeholder'] ?? '';
      description = json['description'] ?? '';
      if (json['options'] != null) {
        options = <String>[];
        json['options'].forEach((v) {
          options!.add(v);
        });
      }
      value = json['value'] ?? '';
    } catch (e) {
      printError(info: 'Error CustomContactField: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['type'] = type;
    data['id'] = id;
    data['is_webchat'] = isWebchat;
    data['required'] = required;
    data['placeholder'] = placeholder;
    data['description'] = description;
    data['options'] = options;
    if (options != null) {
      data['options'] = options;
    }
    data['value'] = value;
    return data;
  }
}

class CustomFields {
  String? label;
  String? tag;
  String? type;
  String? name;
  List<CustomOptions>? options;
  String? placeholder;
  // String? defaultValue;
  bool? required;
  bool? isWebchat;
  String? description;
  String? value;

  CustomFields(
      {this.label,
      this.tag,
      this.type,
      this.name,
      this.options,
      this.placeholder,
      // this.defaultValue,
      this.required,
      this.isWebchat,
      this.description,
      this.value});

  CustomFields.fromJson(Map<String, dynamic> json) {
    try {
      label = json['label'] ?? '';
      tag = json['tag'] ?? '';
      type = json['type'] ?? '';
      name = json['name'] ?? '';
      isWebchat = json['is_webchat'] ?? false;
      if (json['options'] != null) {
        options = <CustomOptions>[];
        json['options'].forEach((v) {
          options!.add(CustomOptions.fromJson(v));
        });
      }
      placeholder = json['placeholder'] ?? '';
      // defaultValue = json['default_value'];
      required = json['required'] ?? false;
      description = json['description'] ?? '';
      value = json['value'] ?? '';
    } catch (e) {
      printError(info: 'Error CustomFields: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['tag'] = tag;
    data['type'] = type;
    data['name'] = name;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['placeholder'] = placeholder;
    // data['default_value'] = defaultValue;
    data['is_webchat'] = isWebchat;
    data['required'] = required;
    data['description'] = description;
    data['value'] = value;
    return data;
  }
}

class CustomOptions {
  String? display;
  String? value;

  CustomOptions({this.display, this.value});

  CustomOptions.fromJson(Map<String, dynamic> json) {
    display = json['display'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['display'] = display ?? '';
    data['value'] = value ?? '';
    return data;
  }
}

class ActivityCode {
  String? code;
  String? description;
  String? id;
  String? parent;
  String? template;
  String? merge;
  int? project;

  ActivityCode(
      {this.code,
      this.description,
      this.project,
      this.parent,
      this.id,
      this.template,
      this.merge});

  ActivityCode.fromJson(Map<String, dynamic> json) {
    try {
      code = json['code'] ?? '';
      description = json['description'] ?? '';
      id = json['id'] ?? '';
      parent = json['parent'] ?? '';
      template = json['template'] ?? '';
      project = json['project'] ?? 0;
      merge = json['merge'] ?? '';
    } catch (e) {
      printError(info: 'ERROR ACTIVITY CODE: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code ?? '';
    data['description'] = description ?? '';
    data['id'] = id ?? '';
    data['template'] = template ?? '';
    data['parent'] = parent ?? '';
    data['project'] = project ?? 0;
    data['merge'] = merge ?? '';
    return data;
  }
}

class AdditionalTicketInfo {
  String? label;
  String? name;
  String? value;

  AdditionalTicketInfo({this.label, this.name, this.value});

  AdditionalTicketInfo.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
