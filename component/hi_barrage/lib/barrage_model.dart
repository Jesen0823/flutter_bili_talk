import 'dart:convert';

/// 弹幕数据的model
class BarrageModel {
  String content;
  String vid;
  int priority;
  int type;

  BarrageModel({this.content, this.vid, this.priority, this.type});

  BarrageModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    vid = json['vid'];
    priority = json['priority'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['vid'] = this.vid;
    data['priority'] = this.priority;
    data['type'] = this.type;
    return data;
  }

  static List<BarrageModel> fromJsonString(json) {
    List<BarrageModel> list = [];
    if (!(json is String) || !json.startsWith('[')) {
      print('json is not invalid');
      return [];
    }

    var jsonArray = jsonDecode(json);
    jsonArray.forEach((v) {
      list.add(new BarrageModel.fromJson(v));
    });
    return list;
  }
}
