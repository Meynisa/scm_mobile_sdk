import '../../main_lib.dart';

class ChildrenCategoryResponse {
  bool? status;
  List<ActivityCode>? data;

  ChildrenCategoryResponse({this.status, this.data});

  ChildrenCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ActivityCode>[];
      json['data'].forEach((v) {
        data!.add(ActivityCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
