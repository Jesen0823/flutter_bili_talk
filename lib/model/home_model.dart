import 'package:flutter_bili_talk/model/video_model.dart';

///工具：在线json转dart https://www.devio.org/io/tools/json-to-dart/
class HomeMo {
  List<BannerMo> bannerList;
  List<CategoryMo> categoryList;
  List<VideoModel> videoList;

  HomeMo({this.bannerList, this.categoryList, this.videoList});

  HomeMo.fromJson(Map<String, dynamic> json) {
    if (json['bannerList'] != null) {
      bannerList = new List<BannerMo>.empty(growable: true);
      json['bannerList'].forEach((v) {
        bannerList.add(new BannerMo.fromJson(v));
      });
    }
    if (json['categoryList'] != null) {
      categoryList = new List<CategoryMo>.empty(growable: true);
      json['categoryList'].forEach((v) {
        categoryList.add(new CategoryMo.fromJson(v));
      });
    }
    if (json['videoList'] != null) {
      videoList = new List<VideoModel>.empty(growable: true);
      json['videoList'].forEach((v) {
        videoList.add(new VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    if (this.categoryList != null) {
      data['categoryList'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    if (this.videoList != null) {
      data['videoList'] = this.videoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerMo {
  String id;
  int sticky;
  String type;
  String title;
  String subtitle;
  String url;
  String cover;
  String createTime;

  BannerMo(
      {this.id,
      this.sticky,
      this.type,
      this.title,
      this.subtitle,
      this.url,
      this.cover,
      this.createTime});

  BannerMo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sticky = json['sticky'];
    type = json['type'];
    title = json['title'];
    subtitle = json['subtitle'];
    url = json['url'];
    cover = json['cover'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sticky'] = this.sticky;
    data['type'] = this.type;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['url'] = this.url;
    data['cover'] = this.cover;
    data['createTime'] = this.createTime;
    return data;
  }
}

class CategoryMo {
  String name;
  int count;

  CategoryMo({this.name, this.count});

  CategoryMo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}
