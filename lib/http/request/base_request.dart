import 'package:flutter_bili_talk/http/dao/login_dao.dart';
import 'package:flutter_bili_talk/util/hi_contants.dart';
import 'package:hi_net/request/hi_base_request.dart';

/// 基础请求
abstract class BaseRequest extends HiBaseRequest {
  @override
  String url() {
    // 给需要登录的接口携带登录令牌
    var boardingPass = LoginDao.getBoardingPass();
    if (needLogin() && boardingPass != null) {
      // 给需要登录的接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, boardingPass);
    }
    return super.url();
  }

  /// 请求头
  Map<String, dynamic> header = {
    //∥访问令牌，在课程公告获取
    HiConstants.authTokenK: HiConstants.authTokenV,
    HiConstants.courseFlagK: HiConstants.courseFlagV,
  };
}
