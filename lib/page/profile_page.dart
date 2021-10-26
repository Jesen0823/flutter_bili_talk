import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/http/core/hi_error.dart';
import 'package:flutter_bili_talk/http/dao/profile_dao.dart';
import 'package:flutter_bili_talk/model/profile_model.dart';
import 'package:flutter_bili_talk/util/color.dart';
import 'package:flutter_bili_talk/util/toast.dart';
import 'package:flutter_bili_talk/util/view_util.dart';

/// 个人中心页面
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel _profileModel;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 160, //扩展高度
              pinned: true, // 标题栏是否固定
              // 固定空间
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 0),
                title: _buildHead(),
                background: Container(
                  color: primary,
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
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: 30, left: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: cachedImage(_profileModel.face, width: 46, height: 46),
          ),
          hiSpace(width: 8),
          Text(
            _profileModel.name,
            style: TextStyle(fontSize: 12, color: Colors.black26),
          )
        ],
      ),
    );
  }
}
