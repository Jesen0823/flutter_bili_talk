import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/http/core/hi_error.dart';
import 'package:flutter_bili_talk/http/dao/profile_dao.dart';
import 'package:flutter_bili_talk/model/profile_model.dart';
import 'package:flutter_bili_talk/util/toast.dart';
import 'package:flutter_bili_talk/util/view_util.dart';
import 'package:flutter_bili_talk/widget/hi_blur.dart';
import 'package:flutter_bili_talk/widget/hi_flexible_header.dart';

/// 个人中心页面
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel _profileModel;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
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
                            'http://image.biaobaiju.com/uploads/20200731/ccf53c0b7b8ee1088c46238d154456bd.jpg')),
                    Positioned.fill(
                      child: HiBlur(
                        sigma: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('标题$index'),
            );
          },
          itemCount: 20,
        ),
      ),
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
}
