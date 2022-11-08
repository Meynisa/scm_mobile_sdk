class PushNotification {
  PushNotification({this.title, this.body, this.date, this.status, this.img});

  String? title;
  String? body;
  String? date;
  String? status;
  String? img;

  PushNotification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    date = json['date'];
    status = json['status'];
    img = json['img'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['body'] = body;
    map['date'] = date;
    map['status'] = status;
    map['img'] = img;
    return map;
  }
}
