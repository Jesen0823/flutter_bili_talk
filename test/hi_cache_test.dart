import 'package:flutter_bili_talk/db/hi_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

///单元测试
///
void main() {
  test('测试HiCache', () async {
    //fix ServicesBinding.defaultBinaryMessenger was accessed before the bin
    TestWidgetsFlutterBinding.ensureInitialized();
    //fix MissingPluginException(No implementation found for method getAll o
    SharedPreferences.setMockInitialValues({});
    await HiCache.preInit();
    var key = 'testHiCache', value = 'Hello.';
    HiCache.getInstance().setString(key, value);

    // 传入实际值和期望值
    expect(HiCache.getInstance().get(key), value);
  });
}
