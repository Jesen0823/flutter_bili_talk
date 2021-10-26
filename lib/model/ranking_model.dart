import 'package:flutter_bili_talk/model/video_model.dart';

class RankingModel {
  int total;
  List<VideoModel> list;

  RankingModel({this.total, this.list});

  RankingModel.fromJson(dynamic json) {
    total = json["total"];
    if (json["list"] != null) {
      list = [];
      json["list"].forEach((v) {
        list.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["total"] = total;
    if (list != null) {
      map["list"] = list.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
