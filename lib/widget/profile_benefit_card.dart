import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/profile_model.dart';
import 'package:flutter_bili_talk/util/view_util.dart';
import 'package:flutter_bili_talk/widget/hi_blur.dart';

// 个人中心增值服务卡片
class ProfileBenefitCard extends StatelessWidget {
  final List<Benefit> benefitList;

  const ProfileBenefitCard({Key key, this.benefitList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 5, top: 15),
      child: Column(
        children: [
          _buildTitle(),
          _buildCardList(context, 16 / 6),
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
            '增值服务',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          hiSpace(width: 10),
          Text(
            '需要登录才能访问增值服务.确定已经登录',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  /// 卡片列表动态布局
  _buildCardList(BuildContext context, double rotation) {
    // 卡片之间间隙
    var gap = (benefitList.length - 1) * 5;
    // 根据卡片数量计算单个卡片宽度
    var cardWidth =
        (MediaQuery.of(context).size.width - 20 - gap) / benefitList.length;
    var cardHeight = 60.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...benefitList
            .map((benefit) =>
                _buildCard(context, benefit, cardWidth, cardHeight))
            .toList()
      ],
    );
  }

  // 单个卡片
  _buildCard(BuildContext context, Benefit data, double width, double height) {
    return InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(right: 5, bottom: 7),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              decoration: BoxDecoration(color: Colors.deepPurpleAccent),
              child: Stack(
                children: [
                  Positioned.fill(child: HiBlur()),
                  Positioned.fill(
                      child: Center(
                    child: Text(
                      data.name,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
