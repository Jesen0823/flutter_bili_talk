import 'package:flutter_bili_talk/http/dao/login_dao.dart';

/// 常量类
class HiConstants {
  static String authTokenK = "auth-token";
  static String authTokenV = "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa";
  static String courseFlagK = "course-flag";
  static String courseFlagV = "fa";
  static const theme = 'hi_theme';

  static headers() {
    //设置请求头校验，注意留意：Console的log输出：flutter：received返回错误信息
    Map<String, dynamic> header = {
      HiConstants.authTokenK: HiConstants.authTokenV,
      HiConstants.courseFlagK: HiConstants.courseFlagV
    };
    header[LoginDao.BOARDING_PASS] = LoginDao.getBoardingPass();
    return header;
  }
}
