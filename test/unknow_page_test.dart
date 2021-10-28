import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/widget/unknow_page.dart';
import 'package:flutter_test/flutter_test.dart';

/// Widget测试 要求被测试对象可以独立运行
void main() {
  testWidgets('测试UnKnownPage', (WidgetTester widgetTester) async {
    var app = MaterialApp(
      home: UnKnowPage(),
    );
    await widgetTester.pumpWidget(app);
    expect(find.text('404'), findsOneWidget);
  });
}
