import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/home_model.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry padding;
  const HiBanner(this.bannerList,
      {Key key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;

    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },

      // 自定义banner指示器
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 8)),
    );
  }

  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
        print(bannerMo.title);
        _handleClick(bannerMo);
      },
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            bannerMo.cover,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _handleClick(BannerMo bannerMo) {
    if (bannerMo.type == 'video') {
      HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
          args: {'videoMo': VideoModel(vid: bannerMo.url)});
    } else {
      print(bannerMo.url);
    }
  }
}
