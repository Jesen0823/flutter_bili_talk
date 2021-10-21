import 'package:shared_preferences/shared_preferences.dart';

/// 缓存管理类

class HiCache {
  SharedPreferences prefs;

  HiCache._() {
    init();
  }

  static HiCache _instance;

  //预初始化，防止使用get时，prefs还未完成初始化,在页面init前调用一次
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance;
  }

  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
    }
    return _instance;
  }

  void init() async {
    if (prefs == null) {
      //返回一个Future   导致可能不同步 所以对prefs预初始化
      prefs = await SharedPreferences.getInstance();
    }
  }

  HiCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  setString(String key, String value) {
    prefs.setString(key, value);
  }

  setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs.setStringList(key, value);
  }

  T get<T>(String key) {
    return prefs.get(key);
  }
}
