import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/profile_model.dart';
import 'package:flutter_bili_talk/util/view_util.dart';

// 个人中心的卡片
class ProfileCard extends StatelessWidget {
  final List<Course> courseList;

  const ProfileCard({Key key, this.courseList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [
          _buildTitle(),
          ..._buildCardList(context, 16 / 6),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '职场进阶',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            '你的技术充电站',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  /// 卡片列表动态布局
  _buildCardList(BuildContext context, double rotation) {
    var courseGroup = Map();
    // 将数据分组
    courseList.forEach((course) {
      if (!courseGroup.containsKey(course.group)) {
        courseGroup[course.group] = [];
      }
      List list = courseGroup[course.group];
      list.add(course);
    });
    return courseGroup.entries.map((e) {
      List list = e.value;

      // 卡片之间间隙
      var gap = (list.length - 1) * 5;
      // 根据卡片数量计算单个卡片宽度
      var cardWidth =
          (MediaQuery.of(context).size.width - 20 - gap) / list.length;
      var cardHeight = cardWidth / rotation;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...list
              .map((course) => _buildCard(course, cardWidth, cardHeight))
              .toSet()
        ],
      );
    });
  }

  // 单个卡片
  _buildCard(Course data, double width, double height) {
    return InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(right: 5, bottom: 7),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: cachedImage(data.cover, width: width, height: height),
          ),
        ));
  }
}
