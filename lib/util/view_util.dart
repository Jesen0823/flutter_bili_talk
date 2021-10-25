import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 带缓存的Image
Widget cachedImage(String url, {double width, double height}) {
  return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String url) => Container(
            color: Colors.grey[200],
          ),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          Icon(Icons.error),
      imageUrl: url);
}
