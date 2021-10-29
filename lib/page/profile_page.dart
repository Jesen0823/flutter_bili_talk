import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/http/dao/profile_dao.dart';
import 'package:flutter_bili_talk/model/profile_model.dart';
import 'package:flutter_bili_talk/util/toast.dart';
import 'package:flutter_bili_talk/util/view_util.dart';
import 'package:flutter_bili_talk/widget/hi_banner.dart';
import 'package:flutter_bili_talk/widget/hi_blur.dart';
import 'package:flutter_bili_talk/widget/hi_flexible_header.dart';
import 'package:flutter_bili_talk/widget/profile_benefit_card.dart';
import 'package:flutter_bili_talk/widget/profile_card.dart';
import 'package:flutter_bili_talk/widget/theme_mode_item.dart';
import 'package:hi_net/core/hi_error.dart';

/// 个人中心页面
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  ProfileModel _profileModel;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildAppBar(),
            ];
          },
          body: ListView(
            padding: EdgeInsets.only(top: 10),
            children: [
              ..._buildContentList(),
            ],
          )),
    );
  }

  void _loadData() async {
    try {
      ProfileModel result = await ProfileDao.get();
      print('profile result:$result');
      setState(() {
        _profileModel = result;
      });
    } on NeedAuth catch (e) {
      print('profile request，$e');
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print('profile request，$e');
      showWarnToast(e.message);
    }
  }

  _buildHead() {
    if (_profileModel == null) {
      return Container();
    }
    return HiFlexibleHeader(
        name: _profileModel.name,
        face: _profileModel.face,
        controller: _controller);
  }

  _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 160, //扩展高度
      pinned: true, // 标题栏是否固定
      // 固定空间
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(
                child: cachedImage(
                    'http://image.biaobaiju.com/uploads/20180303/01/1520011785-GVrsLbMfYq.jpg')),
            Positioned.fill(
              child: HiBlur(
                sigma: 20,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildProfileTab(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _buildContentList() {
    if (_profileModel == null) {
      return [];
    }
    return [
      _buildBanner(),
      ProfileCard(
        courseList: _profileModel.courseList,
      ),
      ProfileBenefitCard(
        benefitList: _profileModel.benefitList,
      ),
      // 夜间模式设置入口
      ThemeModeItem(),
    ];
  }

  _buildBanner() {
    return HiBanner(
      _profileModel.bannerList,
      bannerHeight: 120,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }

  /// 用户资产
  _buildProfileTab() {
    if (_profileModel == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText('收藏', _profileModel.favorite),
          _buildIconText('点赞', _profileModel.like),
          _buildIconText('浏览', _profileModel.browsing),
          _buildIconText('金币', _profileModel.coin),
          _buildIconText('粉丝', _profileModel.fans),
        ],
      ),
    );
  }

  /// 资产详情
  _buildIconText(String text, int num) {
    return Column(
      children: [
        Text(
          '$num',
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
        Text(
          '$text',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
