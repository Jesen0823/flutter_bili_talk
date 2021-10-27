import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/barrage/barrage_item.dart';
import 'package:flutter_bili_talk/barrage/barrage_view_util.dart';
import 'package:flutter_bili_talk/barrage/hi_socket.dart';
import 'package:flutter_bili_talk/barrage/i_barrage.dart';
import 'package:flutter_bili_talk/model/barrage_model.dart';

enum BarrageStatus { play, pause }

/// 弹幕组件
class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;

  const HiBarrage(
      {Key key,
      this.lineCount = 4,
      @required this.vid,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false})
      : super(key: key);

  @override
  HiBarrageState createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> with IBarrage {
  HiSocket _hiSocket;
  double _height;
  double _width;

  // 弹幕Widget集合
  List<BarrageItem> _barrageItemList = [];
  // 弹幕数据集合
  List<BarrageModel> _barrageModelList = [];

  int _barrageIndex = 0;
  Random _random = Random();
  BarrageStatus _barrageStatus;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _hiSocket = HiSocket();
    _hiSocket.open(widget.vid).listen((value) {
      _handleMessage(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [
          // 给出一个空Container，防止Stack为空的情况
          Container(),
        ]..addAll(_barrageItemList),
      ),
    );
  }

  void _handleMessage(List<BarrageModel> modelList, {bool instant = false}) {
    if (instant) {
      // 插到集合头部
      _barrageModelList.insertAll(0, modelList);
    } else {
      // 插到集合最尾部
      _barrageModelList.addAll(modelList);
    }

    // 收到弹幕,进行播放
    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }

    // 如果是新弹幕
    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }

  @override
  void dispose() {
    if (_hiSocket != null) {
      _hiSocket.close();
    }
    if (_timer != null) {
      _timer.cancel();
    }

    super.dispose();
  }

  /// 弹幕播放
  void play() {
    _barrageStatus = BarrageStatus.play;
    print('danmu startPlay');
    if (_timer != null && _timer.isActive) {
      return;
    }

    // 每隔一段时间发送弹幕
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        // 将要发送的弹幕移除集合
        var temp = _barrageModelList.removeAt(0);
        addBarrage(temp);
        print('danmu start: ${temp.content}');
      } else {
        print('danmu all barrages been sent.');
        _timer.cancel();
      }
    });
  }

  // 添加弹幕到屏幕
  void addBarrage(BarrageModel model) {
    double singleRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = line * singleRowHeight + widget.top;

    // 给每条弹幕生成一个ID
    String id = '${_random.nextInt(10000)}:${model.content}';
    var item = BarrageItem(
      id: id,
      top: top,
      child: BarrageViewUtil.barrageView(model),
      onComplete: _onComplete,
    );
    _barrageItemList.add(item);
    setState(() {
      // 刷新
    });
  }

  @override
  void pause() {
    _barrageStatus = BarrageStatus.pause;
    // 清空屏幕上的弹幕
    _barrageModelList.clear();
    setState(() {
      // 刷新屏幕
    });
    print('danmu paused.');
    _timer.cancel();
  }

  @override
  void send(String message) {
    if (message == null) return;
    _hiSocket.send(message);
    // 发送完毕后展示在屏幕
    _handleMessage([
      BarrageModel(content: message, vid: widget.vid, priority: 1, type: 1)
    ]);
  }

  void _onComplete(id) {
    print('danmu _onComplete, $id');
    //弹幕播放完毕将其从弹幕widget集合中剔除
    _barrageItemList.removeWhere((element) => element.id == id);
  }
}
