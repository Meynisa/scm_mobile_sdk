import '../../main_lib.dart';

class LoginResponse {
  String? token;

  LoginResponse({this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}

class StreamUser {
  int? statusesCount;
  int? friendsCount;
  int? followersCount;
  bool? protected;
  String? profileUrl;
  String? avatar;
  String? realName;
  String? name;
  String? id;
  bool? isWaGroup;
  String? hp;

  StreamUser(
      {this.statusesCount,
      this.friendsCount,
      this.followersCount,
      this.protected,
      this.profileUrl,
      this.avatar,
      this.realName,
      this.name,
      this.id,
      this.isWaGroup,
      this.hp});

  StreamUser.fromJson(Map<String, dynamic> json) {
    try {
      statusesCount = json['statuses_count'] ?? 0;
      friendsCount = json['friends_count'] ?? 0;
      followersCount = json['followers_count'] ?? 0;
      protected = json['protected'] ?? false;
      profileUrl = json['profile_url'] ?? '';
      avatar = json['avatar'] ?? '';
      realName = json['real_name'] ?? '';
      name = json['name'] ?? '';
      id = (json['id']).toString();
      isWaGroup = json['is_wa_group'] ?? false;
      hp = json['hp'] ?? '';
    } catch (e) {
      printError(info: 'ERROR StreamUser : ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statuses_count'] = statusesCount;
    data['friends_count'] = friendsCount;
    data['followers_count'] = followersCount;
    data['protected'] = protected;
    data['profile_url'] = profileUrl;
    data['avatar'] = avatar;
    data['real_name'] = realName;
    data['name'] = name;
    data['id'] = id;
    data['is_wa_group'] = isWaGroup ?? false;
    data['hp'] = hp ?? '';
    return data;
  }
}

class StreamAccount {
  String? name;
  String? userName;
  String? avatar;

  StreamAccount({this.name, this.userName, this.avatar});

  StreamAccount.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['user_name'];
    avatar = json['avatar'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['user_name'] = userName;
    data['avatar'] = avatar ?? '';
    return data;
  }
}

class TicketUser {
  String? name;
  String? address;
  String? city;
  String? gender;
  String? phone;
  String? email;
  String? avatar;
  List<TicketChannels>? channels;
  List<String>? phoneOther;
  bool? isBlacklist;
  String? id;
  String? realName;
  List<CustomFields>? customField;
  List<CustomContactField>? customContactField;
  String? oid;
  Object? parent;
  bool? isWaGroup;
  String? hp;

  TicketUser(
      {this.name,
      this.address,
      this.city,
      this.gender,
      this.phone,
      this.email,
      this.avatar,
      this.channels,
      this.isBlacklist,
      this.id,
      this.realName,
      this.customField,
      this.oid,
      this.parent,
      this.isWaGroup,
      this.hp,
      this.phoneOther,
      this.customContactField});

  TicketUser.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    address = json['address'] ?? '-';
    city = json['city'] ?? '-';
    gender = json['gender'] ?? '-';
    phone = json['phone'] ?? '-';
    email = json['email'] ?? '-';
    avatar = json['avatar'] ?? '';
    if (json['channels'] != null) {
      channels = <TicketChannels>[];
      json['channels'].forEach((v) {
        channels!.add(TicketChannels.fromJson(v));
      });
    }
    phoneOther =
        json['phone_other'] != null ? json['phone_other'].cast<String>() : [];
    customContactField = json['custom_contact_field'] == null
        ? <CustomContactField>[]
        : List<CustomContactField>.from(json["custom_contact_field"]
            .map((it) => CustomContactField.fromJson(it)));
    customField = json['custom_field'] == null
        ? <CustomFields>[]
        : List<CustomFields>.from(
            json["custom_field"].map((it) => CustomFields.fromJson(it)));
    isBlacklist = json['is_blacklist'] ?? false;
    id = json['id'] ?? '';
    realName = json['real_name'] ?? '';
    oid = json['oid'] ?? '';
    parent = json['parent'];
    isWaGroup = json['is_wa_group'] ?? false;
    hp = json['hp'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['gender'] = gender;
    data['phone'] = phone;
    data['email'] = email;
    data['avatar'] = avatar;
    if (channels != null) {
      data['channels'] = channels!.map((v) => v.toJson()).toList();
    }
    data['is_blacklist'] = isBlacklist;
    data['id'] = id;
    data['real_name'] = realName;
    if (customContactField != null) {
      data['custom_contact_field'] =
          customContactField!.map((v) => v.toJson()).toList();
    }
    if (customField != null) {
      data['custom_field'] = customField!.map((v) => v.toJson()).toList();
    }
    data['phone_other'] = phoneOther;
    data['oid'] = oid;
    data['parent'] = parent;
    data['is_wa_group'] = isWaGroup ?? false;
    data['hp'] = hp ?? '';
    return data;
  }
}

class ActionBy {
  int? id;
  String? name;
  String? realName;

  ActionBy({this.id, this.name, this.realName});

  ActionBy.fromJsonMap(Map<String, dynamic> map) {
    try {
      name = map["name"] ?? '';
      id = map["id"] ?? '';
      if (map['real_name'] != null) {
        realName = map['real_name'];
      }
    } catch (e) {
      printError(info: 'ERROR ActionBy : ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    if (realName != null) {
      data['real_name'] = realName;
    }
    return data;
  }
}
