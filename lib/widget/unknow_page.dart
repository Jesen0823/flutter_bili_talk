import 'package:flutter/material.dart';

/// 之上用来演示Widget测试
class UnKnowPage extends StatefulWidget {
  const UnKnowPage({Key key}) : super(key: key);

  @override
  _UnKnowPageState createState() => _UnKnowPageState();
}

class _UnKnowPageState extends State<UnKnowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('404'),
      ),
    );
  }
}
