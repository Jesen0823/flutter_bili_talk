import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_bili_talk/provider/theme_provider.dart';
import 'package:hi_base/view_util.dart';
import 'package:provider/provider.dart';

class ThemeModeItem extends StatelessWidget {
  const ThemeModeItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    var icon = themeProvider.isDark()
        ? Icons.nightlight_round
        : Icons.wb_sunny_rounded;
    var color = themeProvider.isDark() ? Colors.white70 : Colors.black26;

    return InkWell(
      // 跳转夜间模式设置页
      onTap: () => HiNavigator.getInstance().onJumpTo(RouteStatus.themeSetting),
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, bottom: 15),
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [
            Text(
              '夜间模式',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
                padding: EdgeInsets.only(top: 2, left: 10),
                child: Icon(
                  icon,
                  color: color,
                )),
          ],
        ),
      ),
    );
  }
}
