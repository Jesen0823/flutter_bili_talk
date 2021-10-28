import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/main.dart' as app;
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// 集成测试用例
///
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('集成测试登录注册跳转', (WidgetTester tester) async {
    // 构建应用
    app.main();

    // 捕获一帧
    await tester.pumpAndSettle();
    // 通过key查找注册按钮
    var registerBtn = find.byKey(Key('registerKey'));
    // tap可以触发注册button的点击事件
    await tester.tap(registerBtn);
    // 继续捕获一帧
    await tester.pumpAndSettle();
    // 暂停,观察效果
    await Future.delayed(Duration(seconds: 5));

    // 判断是否跳转到了注册页
    var current = HiNavigator.getInstance().getCurrent().routeStatus;
    expect(current, RouteStatus.registration);

    // 获取返回按钮
    var backBtn = find.byType(BackButton);
    // 触发返回按钮
    await tester.tap(backBtn);
    // 捕获一帧
    await tester.pumpAndSettle();
    // 延迟3秒
    await Future.delayed(Duration(seconds: 3));
    // 判断是否返回到了登录页面
    var current2 = HiNavigator.getInstance().getCurrent().routeStatus;
    expect(current2, RouteStatus.login);
  });
}
