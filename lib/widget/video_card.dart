import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_bili_talk/util/format_util.dart';
import 'package:flutter_bili_talk/util/view_util.dart';

/// 视频卡片
class VideoCard extends StatelessWidget {
  final VideoModel videoModel;

  const VideoCard({Key key, @required this.videoModel}) : super(key: key);

  /// 图片
  Widget _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cachedImage(videoModel.cover, width: size.width / 2 - 10, height: 120),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 3,
              top: 5,
            ),
            decoration: BoxDecoration(
              // 渐变
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.ondemand_video, videoModel.view ?? 0),
                _iconText(Icons.favorite_border, videoModel.favorite ?? 0),
                _iconText(null, videoModel.duration ?? 0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 图标文本
  _iconText(IconData iconData, int count) {
    String textCount = "";
    if (iconData != null) {
      textCount = countFormat(count);
    } else {
      textCount = durationTransform(videoModel.duration);
    }
    return Row(
      children: [
        if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            textCount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  /// 信息文本
  _infoText(Color textColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          top: 5,
          left: 8,
          right: 8,
          bottom: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              videoModel.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
              ),
            ),
            _owner(textColor)
          ],
        ),
      ),
    );
  }

  /// 作者
  _owner(Color textColor) {
    var owner = videoModel.owner;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: cachedImage(
                owner.face,
                height: 24,
                width: 24,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                owner.name,
                style: TextStyle(
                  fontSize: 11,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
        Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black87;
    return InkWell(
      onTap: () {
        HiNavigator.getInstance().onJumpTo(
          RouteStatus.detail,
          args: {'videoModel': videoModel},
        );
      },
      child: SizedBox(
        height: 200,
        child: Card(
          // 取消卡片默认边距
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemImage(context),
                _infoText(textColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
