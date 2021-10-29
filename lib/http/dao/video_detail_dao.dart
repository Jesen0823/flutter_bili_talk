import 'package:flutter_bili_talk/http/request/video_detail_request.dart';
import 'package:flutter_bili_talk/model/video_detail_model.dart';
import 'package:hi_net/hi_net.dart';

/// 视频详情页请求
class VideoDetailDao {
  static get(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print('video detail request result: $result');
    return VideoDetailModel.fromJson(result['data']);
  }
}
