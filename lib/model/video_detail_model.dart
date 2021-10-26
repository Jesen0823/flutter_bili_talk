import 'package:flutter_bili_talk/model/video_model.dart';

class VideoDetailModel {
  bool isFavorite;
  bool isLike;
  VideoModel videoModel;
  List<VideoModel> videoList;

  VideoDetailModel(
      {this.isFavorite, this.isLike, this.videoModel, this.videoList});

  VideoDetailModel.fromJson(dynamic json) {
    isFavorite = json["isFavorite"];
    isLike = json["isLike"];
    videoModel = json["videoInfo"] != null
        ? VideoModel.fromJson(json["videoInfo"])
        : null;
    if (json["videoList"] != null) {
      videoList = [];
      json["videoList"].forEach((v) {
        videoList.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["isFavorite"] = isFavorite;
    map["isLike"] = isLike;
    if (videoModel != null) {
      map["videoInfo"] = videoModel.toJson();
    }
    if (videoList != null) {
      map["videoList"] = videoList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "149"
/// vid : "BV1V4411c7xg"
/// title : "清凉柔嫩的旺仔白玉团子奶冻~芋头控的最爱！！！"
/// tname : "美食测评"
/// url : "https://o.devio.org/files/video/v=2sIC1sh-yc0.mp4"
/// cover : "https://o.devio.org/images/fa/photo-1461214626925-421f126d9f11.webp"
/// pubdate : 1562313937
/// desc : "二喵建了QQ群进来一起玩叭：972959347\nBGM:\nParalyzed Veterans of America - Yankee\n梶浦由記 - Yokoku\nmamerico - Waltz for Hulot"
/// view : 699630
/// duration : 295
/// owner : {"name":"Sandm。旧颜","face":"https://o.devio.org/images/o_as/avatar/tx19.jpeg","fans":1353369198}
/// reply : 733
/// favorite : 25673
/// like : 41425
/// coin : 15389
/// share : 1774
/// createTime : "2020-11-14 19:35:54"
/// size : 17593

/// name : "Sandm。旧颜"
/// face : "https://o.devio.org/images/o_as/avatar/tx19.jpeg"
/// fans : 1353369198

class Owner {
  String name;
  String face;
  int fans;

  Owner({this.name, this.face, this.fans});

  Owner.fromJson(dynamic json) {
    name = json["name"];
    face = json["face"];
    fans = json["fans"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["face"] = face;
    map["fans"] = fans;
    return map;
  }
}

/// id : "165"
/// vid : "BV1sa4y1J7yK"
/// title : "穿越次元壁！哆啦A梦最爱的拉丝年糕真的有那么好吃吗？"
/// tname : "美食测评"
/// url : "https://o.devio.org/files/video/v=a23945btJYw.mp4"
/// cover : "https://o.devio.org/images/fa/cat-2536662__340.webp"
/// pubdate : 1597482610
/// desc : "没事千万别在家戳纯糯米团~真的会黏到怀疑喵生。。。\n二喵的小群：819809001 （快来玩）"
/// view : 4184292
/// duration : 391
/// owner : {"name":"迎娶白富美","face":"https://o.devio.org/images/o_as/avatar/tx12.jpeg","fans":1335582531}
/// reply : 3585
/// favorite : 50148
/// like : 466536
/// coin : 302953
/// share : 3747
/// createTime : "2020-11-14 19:35:54"
/// size : 34748

class VideoInfo {
  String id;
  String vid;
  String title;
  String tname;
  String url;
  String cover;
  int pubdate;
  String desc;
  int view;
  int duration;
  Owner owner;
  int reply;
  int favorite;
  int like;
  int coin;
  int share;
  String createTime;
  int size;

  VideoInfo(
      {this.id,
      this.vid,
      this.title,
      this.tname,
      this.url,
      this.cover,
      this.pubdate,
      this.desc,
      this.view,
      this.duration,
      this.owner,
      this.reply,
      this.favorite,
      this.like,
      this.coin,
      this.share,
      this.createTime,
      this.size});

  VideoInfo.fromJson(dynamic json) {
    id = json["id"];
    vid = json["vid"];
    title = json["title"];
    tname = json["tname"];
    url = json["url"];
    cover = json["cover"];
    pubdate = json["pubdate"];
    desc = json["desc"];
    view = json["view"];
    duration = json["duration"];
    owner = json["owner"] != null ? Owner.fromJson(json["owner"]) : null;
    reply = json["reply"];
    favorite = json["favorite"];
    like = json["like"];
    coin = json["coin"];
    share = json["share"];
    createTime = json["createTime"];
    size = json["size"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["vid"] = vid;
    map["title"] = title;
    map["tname"] = tname;
    map["url"] = url;
    map["cover"] = cover;
    map["pubdate"] = pubdate;
    map["desc"] = desc;
    map["view"] = view;
    map["duration"] = duration;
    if (owner != null) {
      map["owner"] = owner.toJson();
    }
    map["reply"] = reply;
    map["favorite"] = favorite;
    map["like"] = like;
    map["coin"] = coin;
    map["share"] = share;
    map["createTime"] = createTime;
    map["size"] = size;
    return map;
  }
}
