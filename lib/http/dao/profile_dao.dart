import 'package:flutter_bili_talk/http/request/profile_request.dart';
import 'package:flutter_bili_talk/model/profile_model.dart';
import 'package:hi_net/hi_net.dart';

/// 个人中心请求
class ProfileDao {
  static get() async {
    ProfileRequest request = ProfileRequest();
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return ProfileModel.fromJson(result['data']);
  }
}
