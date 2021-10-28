import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/provider/theme_provider.dart';
import 'package:provider/provider.dart';

/// 主题夜间模式设置页
class ThemeModeSetting extends StatefulWidget {
  const ThemeModeSetting({Key key}) : super(key: key);

  @override
  _ThemeModeSettingState createState() => _ThemeModeSettingState();
}

class _ThemeModeSettingState extends State<ThemeModeSetting> {
  static const _ITEMS = [
    {'name': '跟随系统', 'mode': ThemeMode.system},
    {'name': '打开', 'mode': ThemeMode.dark},
    {'name': '关闭', 'mode': ThemeMode.light},
  ];

  // 当前主题
  var _currentTheme;

  @override
  void initState() {
    super.initState();

    // 初始化当前主题模式
    var themeMode = context.read<ThemeProvider>().getThemeMode();
    _ITEMS.forEach((element) {
      if (element['mode'] == themeMode) {
        _currentTheme = element;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('夜间模式'),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemCount: _ITEMS.length),
    );
  }

  Widget _item(int index) {
    var theme = _ITEMS[index];
    return InkWell(
      onTap: () => _switchTheme(index),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Text(
                theme['name'],
              ),
            ),
            Opacity(
              opacity: _currentTheme == theme ? 1 : 0,
              child: Icon(
                Icons.done,
                color: Colors.lightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 切换主题
  _switchTheme(int index) {
    var theme = _ITEMS[index];
    context.read<ThemeProvider>().setTheme(theme['mode']);
    setState(() {
      _currentTheme = theme;
    });
  }
}
