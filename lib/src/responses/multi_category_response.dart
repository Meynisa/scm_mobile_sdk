import '../../../main_lib.dart';

class MultiCategoryResponse {
  bool? status;
  List<ActivityCode>? data;

  MultiCategoryResponse({this.status, this.data});

  MultiCategoryResponse.fromJson(Map<String, dynamic> json) {
    try {
      status = json['status'];
      data = json['data'] == null
          ? <ActivityCode>[]
          : List<ActivityCode>.from(
              json["data"].map((it) => ActivityCode.fromJson(it)));
    } catch (e) {
      printError(info: 'ERROR MultiCategoryResponse : $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = data != null
        ? List<ActivityCode>.from(
            data['data'].map((it) => ActivityCode.fromJson(it)))
        : <ActivityCode>[];
    return data;
  }
}
