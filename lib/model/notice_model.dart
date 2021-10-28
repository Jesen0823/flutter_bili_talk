import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/home_model.dart';

class NoticeModel {
  NoticeModel({
    @required this.total,
    @required this.list,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<BannerMo> list = jsonRes['list'] is List ? <BannerMo>[] : null;
    if (list != null) {
      for (final dynamic item in jsonRes['list']) {
        if (item != null) {
          list.add(new BannerMo.fromJson(item));
        }
      }
    }
    return NoticeModel(
      total: jsonRes['total'],
      list: list,
    );
  }

  int total;
  List<BannerMo> list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total': total,
        'list': list,
      };
}
