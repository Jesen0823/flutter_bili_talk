import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';
import 'package:hi_base/view_util.dart';

/// 自定义顶部appBar

appBar(String title, String rightTitle, VoidCallback rightButtonClick, {key}) {
  return AppBar(
    backgroundColor: primary[50],
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(color: Colors.white),
    title: Text(
      title,
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
    actions: [
      InkWell(
        key: key,
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}

/// 视频详情页appBar
videoAppBar() {
  return Container(
    padding: EdgeInsets.only(right: 8),
    decoration: BoxDecoration(gradient: blackLineGradient(fromTop: true)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.live_tv_rounded,
              color: Colors.white,
              size: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        )
      ],
    ),
  );
}
